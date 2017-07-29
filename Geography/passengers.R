# Libraries
library(ggmap)
library(rvest)
library(ggplot2)
library(ggrepel)

# Passegener volumes
url <- "https://en.wikipedia.org/wiki/List_of_the_busiest_air_routes_in_Australia_by_passenger_traffic"
xpath <- '//*[@id="mw-content-text"]/div/table[1]'
sydneytraffic <- url %>%
    read_html() %>%
    html_nodes(xpath = xpath) %>%
    html_table()
sydneytraffic <- sydneytraffic[[1]]
sydneytraffic <- data.frame(From = "Sydney", To = sydneytraffic[-11,3], 
                            Passengers = sydneytraffic[-11,7])


# Lookup coordinates
airports <- unique(c("Sydney", as.character(sydneytraffic$To)))
coords <- geocode(airports)
airports <- data.frame(airport=airports, coords)

# Add coordinates to flight list
sydneytraffic <- merge(sydneytraffic, airports, by.x="To", by.y="airport")
sydneytraffic <- merge(sydneytraffic, airports, by.x="From", by.y="airport")
sydneytraffic$Passengers <- as.numeric(gsub(",", "", as.character(sydneytraffic$Passengers)))
sydneytraffic$linew <- sydneytraffic$Passengers/min(sydneytraffic$Passengers)

# Plot flight routes
worldmap <- borders("world", colour="#efede1", fill="#efede1") # create a layer of borders
ggplot() + worldmap + 
    geom_curve(data=sydneytraffic, aes(x = lon.x, y = lat.x, xend = lon.y, yend = lat.y), col = "#b29e7d", 
               size = sydneytraffic$linew/2, curvature = .2) + 
    geom_point(data=airports, aes(x = lon, y = lat), col = "#970027") + 
    geom_text_repel(data=airports, aes(x = lon, y = lat, label = airport), col = "black", size = 2, segment.color = NA) + 
    xlim(110, 155) + ylim(-45, -10) + coord_fixed() + 
    theme(panel.background = element_rect(fill="white"), 
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
    )
ggsave("Geography/Sydney_Passengers.png")
