## Trip around the world
## Flat Earth mathematics
## https://lucidmanager.org/flat-earth-mathematics/

## Recreate Gleason's Map
library(tidyverse)
world <- map_data("world")
worldmap <- ggplot(world) +
    geom_path(aes(x = long, y = lat, group = group)) +
    theme(axis.text = element_blank(),
          axis.ticks = element_blank()) +
    labs(x = "", y = "")
worldmap + 
    coord_map("azequidistant", orientation = c(90, 0, 270))
ggsave("azequidistant.png", dpi = 150)

## Define itinerary
library(ggmap)
airports <- tibble(city = c("Melbourne", "Tokyo", "Amsterdam", "San Francisco", "Melbourne"))

## Find coordinates
## Where you receive an OVER_QUERY_LIMIT error, repeat the code
itinerary <- geocode(airports$city) %>%
    mutate(location = airports$city)

## Split travel past dateline
dl <- which(diff(itinerary$lon) > 180)
dr <- ifelse(itinerary$lon[dl] < 0, -180, 180)
dateline <- tibble(lon = c(dr, -dr),
                   lat = rep(mean(itinerary$lat[dl:(dl + 1)]), 2),
                   location = "dateline")
itinerary <- rbind(itinerary[1:dl, ], dateline,
                   itinerary[(dl + 1):nrow(itinerary), ])
itinerary

## Visualise
worldmap +
    geom_point(data = itinerary, aes(lon, lat), colour = "red", size = 4) +
    geom_path(data = itinerary, aes(lon, lat), colour = "red", size = 1) +
    coord_map("azequidistant", orientation = c(-90, 0, 270))
ggsave("rtw.png", dpi = 150)

worldmap +
    geom_point(data = itinerary, aes(lon, lat), colour = "red", size = 4) +
    geom_path(data = itinerary, aes(lon, lat), colour = "red", size = 1) +
    coord_map(project="albers", par=c(39, 45))

## Great Circle Distance
library(geosphere)
sapply(1:(nrow(itinerary) - 1), function(l)
    distVincentyEllipsoid(itinerary[l, 1:2], itinerary[(l + 1), 1:2]) / 1000) %>%
    sum()

## Flat Eart Mathematics
library(mapproj)
coords <- mapproject(itinerary$lon, itinerary$lat, "azequidistant",
                     orientation = c(-90, 0, 270))
coords <- tibble(x = coords$x, y = coords$y)
sum(sqrt(diff(coords$x)^2 + diff(coords$y)^2) * 6378.137)



