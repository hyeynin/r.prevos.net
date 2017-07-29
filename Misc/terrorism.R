# Load data
terrorism <- read.csv("RAND_Database_of_Worldwide_Terrorism_Incidents.csv")
names(terrorism)

table(terrorism$Weapon)
summary(terrorism$Fatalities)

# Download lattitude and longitude
library(ggmap)
locations <- data.frame(location = unique(paste(terrorism$Country, terrorism$City)))
coords <- unlist(lapply(as.character(locations$location), geocode))
locations$lon <- coords[seq(1, by = 2, length(coords))]
locations$lat <- coords[seq(2, by = 2, length(coords))]

map <- get_map(location = c(lon=mean(locations$lon, na.rm=TRUE), lat=mean(locations$lat, na.rm=TRUE)), zoom=1)
ggmap(map) + geom_point(data=locations, aes(x=lon, y=lat))
