library(ggmap)
library(gridExtra)

antipode <- function(location, zm = 6) {
    # Map location
    lonlat <- geocode(location)
    loc1 <- get_map(lonlat, zoom = zm)
    map1 <- ggmap(loc1) + geom_point(data = lonlat, aes(lon, lat, col = "red", size = 10)) + 
        theme(legend.position = "none")
    # Define antipode
    lonlat$lon <- lonlat$lon-180
    if (lonlat$lon < -180) 
        lonlat$lon <- 360 + lonlat$lon
    lonlat$lat <- -lonlat$lat
    loc2 <- get_map(lonlat, zoom = zm)
    map2 <- ggmap(loc2) + geom_point(data = lonlat, aes(lon, lat, col = "red", size = 10)) + 
        theme(legend.position = "none")
    grid.arrange(map1, map2, nrow = 1)
}

antipode("20 Alpina Place, Kangaroo Flat", 6)
antipode("Rector Nelissenstraat 47 Hoensbroek", 4)
antipode ("Chicago,IL", 4)

library(globe)
# Create antipodean map
flip <- earth
flip$coords[,1] <- flip$coords[,1]-180
flip$coords[,2] <- -flip$coords[,2]
par(mar = rep(0,4)) # Remove plotting margins
globeearth(eye = c(90,0), col = "blue")
globepoints(loc = flip$coords, eye = c(90,0), col = "red", pch = ".")
