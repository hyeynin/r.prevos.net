# Flightpath map
# https://r.prevos.net/create-air-travel-route-maps/

# Init
library(tidyverse)
library(ggmap)
library(ggrepel)

# Read flight and airports lists 
flights <- read.csv("Geography/flights.csv", stringsAsFactors = FALSE)
airports <- read.csv("Geography/airports.csv", stringsAsFactors = FALSE)

# Lookup coordinates
destinations <- unique(c(flights$From, flights$To))
new_destinations <- destinations[!destinations %in% airports$airport]
if (length(new_destinations) > 0) {
    coords <- geocode(new_destinations)
    airports <- rbind(airports, data.frame(airport = new_destinations, coords))
    write.csv(airports, "Geography/airports.csv", row.names = FALSE)
    }

# Remove return flights
d <- vector()
for (i in 1:nrow(flights)) {
    d <- which(paste(flights$From, flights$To) %in% paste(flights$To[i], flights$From[i]))
    flights$From[d] <- "R"
}
flights <- flights %>%
  filter(From != "R") %>%
  select(From, To)

# Add coordinates to flight list
flights <- merge(flights, airports, by.x="From", by.y="airport")
flights <- merge(flights, airports, by.x="To", by.y="airport")
flights <- flights %>% 
  select(From, To, lon.x, lat.x, lon.y, lat.y) %>% 
  as_data_frame()

# Circumnaviation
circ <- which(abs(flights$lon.y - flights$lon.x) > 180)
flights[circ, ]
flights$lon.y[circ] <- ifelse(flights$lon.y[circ] < 0, 180, -180)
flights$lat.y[circ] <- rowSums(flights[circ, c("lat.x", "lat.y")]) / 2
flights <- rbind(flights, 
                 data_frame(From = rep("", length(circ)),
                            To = flights$To[circ],
                            lon.x = -flights$lon.y[circ],
                            lat.x = flights$lat.y[circ],
                            lon.y = airports[airports$airport %in% flights$To[circ], "lon"],
                            lat.y = airports[airports$airport %in% flights$To[circ], "lat"])
                 )
  

# Remove country names
airports$airport <- as.character(airports$airport)
comma <- regexpr(",", airports$airport)
airports$airport[which(comma > 0)] <- substr(airports$airport[which(comma > 0)], 1, comma[comma > 0] - 1)

# Plot flight routes
worldmap <- borders("world", colour="#efede1", fill="#efede1") # create a layer of borders
ggplot() + worldmap + 
    geom_point(data=airports, aes(x = lon, y = lat), col = "#970027") + 
    geom_text_repel(data=airports, aes(x = lon, y = lat, label = airport), col = "black", size = 2, segment.color = NA) + 
    geom_curve(data = flights, aes(x = lon.x, y = lat.x, xend = lon.y, yend = lat.y), col = "#b29e7d", size = .4) + 
    theme(panel.background = element_rect(fill="white"), 
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
    )

ggsave("Geography/flights_map.png")

# geom_curve curvature test
data.frame(x1 = c(1, 3), 
           y1 = c(2, 3),
           x2 = c(2, 2),
           y2 = c(1, 2)) %>% 
  ggplot() + geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2))
