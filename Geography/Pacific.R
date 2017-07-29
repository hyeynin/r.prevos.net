# Init
library(ggmap)
library(ggplot2)
library(ggrepel)
library(geosphere)

# Read flight list and airport list
flights <- read.csv("Geography/PacificFlights.csv", stringsAsFactors = FALSE)
f <- "Geography/airports.csv"
if (file.exists(f)) {
    airports <- read.csv(f)
    } else airports <- data.frame(airport = NA, lat = NA, lon = NA)

# Lookup coordinates for new airports
all_airports <- unique(c(flights$From, flights$To))
new_airports <- all_airports[!(all_airports %in% airports$airport)]
if (length(new_airports) != 0) {
    coords <- geocode(new_airports)
    new_airports <- data.frame(airport = new_airports, coords)
    airports <- rbind(airports, new_airports)
    airports <- subset(airports, !is.na(airport))
    write.csv(airports, "Geography/airports.csv", row.names = FALSE)
}

# Add coordinates to flight list
flights <- merge(flights, airports, by.x="From", by.y="airport")
flights <- merge(flights, airports, by.x="To", by.y="airport")

# Remove country names
airports$airport <- as.character(airports$airport)
comma <- regexpr(",", airports$airport)
airports$airport[which(comma > 0)] <- substr(airports$airport[which(comma > 0)], 1, comma[comma > 0] - 1)

# Pacific centric
flights$lon.x[flights$lon.x < 0] <- flights$lon.x[flights$lon.x < 0] + 360
flights$lon.y[flights$lon.y < 0] <- flights$lon.y[flights$lon.y < 0] + 360
airports$lon[airports$lon < 0] <- airports$lon[airports$lon < 0] + 360

# Plot flight routes
worldmap <- borders("world2", colour="#efede1", fill="#efede1") # create a layer of borders
ggplot() + worldmap + 
    geom_point(data=airports, aes(x = lon, y = lat), col = "#970027") + 
    geom_text_repel(data=airports, aes(x = lon, y = lat, label = airport), col = "black", size = 2, segment.color = NA) + 
    geom_curve(data=flights, aes(x = lon.x, y = lat.x, xend = lon.y, yend = lat.y, col = Airline), size = .4, curvature = .2) + 
    theme(panel.background = element_rect(fill="white"), 
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
          )

ggsave("Geography/pacifc_flights.png")

# Network Analysis
library(igraph)
g <- graph_from_edgelist(as.matrix(flights[,1:2]), directed = FALSE)
par(mar = rep(0, 4))
plot(g, layout = layout.fruchterman.reingold, vertex.size=0)
shortest_paths(g, "Auckland", "Saipan")

