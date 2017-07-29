# Init
library(ggmap)
library(ggplot2)
library(ggrepel)

# Read flight list
flights <- read.csv("Geography/flights.csv", stringsAsFactors = FALSE)

# Lookup coordinates
airports <- unique(c(flights$From, flights$To))
coords <- geocode(airports)
airports <- data.frame(airport=airports, coords)

# Remove return flights
d <- vector()
for (i in 1:nrow(flights)) {
    d <- which(paste(flights$From, flights$To) %in% paste(flights$To[i], flights$From[i]))
    flights$From[d] <- "R"
}
flights <- subset(flights, From != "R")

# Add coordinates to flight list
flights <- merge(flights, airports, by.x="From", by.y="airport")
flights <- merge(flights, airports, by.x="To", by.y="airport")
flights <- flights[,c(2, 1, 4:7)]

# Circumnaviation
circ <- which(abs(flights$lon.y - flights$lon.x) > 180)
flights$lon.y[circ] <- 180
flights$lat.y[circ] <- sum(flights[circ, c("lat.x", "lat.y")])/2
flights <- rbind(flights, data.frame(From = rep("", length(circ)),
                          To = flights$To[circ],
                          lon.x = -180,
                          lat.x = flights$lat.y[circ],
                          lon.y = airports[airports$airport == flights$To[circ], "lon"],
                          lat.y = airports[airports$airport == flights$To[circ], "lat"]
                          ))
flights$To[circ] <- ""

# Remove country names
airports$airport <- as.character(airports$airport)
comma <- regexpr(",", airports$airport)
airports$airport[which(comma > 0)] <- substr(airports$airport[which(comma > 0)], 1, comma[comma > 0] - 1)

# Plot flight routes
worldmap <- borders("world", colour="#efede1", fill="#efede1") # create a layer of borders
ggplot() + worldmap + 
    geom_point(data=airports, aes(x = lon, y = lat), col = "#970027") + 
    geom_text_repel(data=airports, aes(x = lon, y = lat, label = airport), col = "black", size = 2, segment.color = NA) + 
    geom_curve(data=flights, aes(x = lon.x, y = lat.x, xend = lon.y, yend = lat.y), col = "#b29e7d", size = .4, curvature = .2) + 
    theme(panel.background = element_rect(fill="white"), 
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
    )

ggsave("Geography/flights_map.png")
