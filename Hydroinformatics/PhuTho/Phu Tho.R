# --------------------------
# Viet Tri Water consumption

# Read the data
water <- read.csv("Hydroinformatics/PhuTho/MeterReads.csv")
water$Consumption <- water$read_new - water$read_old

head(water)
summary(water$Consumption)

# Load map library
library(ggmap)

# Find the middle of the points
centre <- c(mean(range(water$lon)), mean(range(water$lat)))

# Download the satellite image
viettri <- get_map(centre, zoom = 17, maptype = "hybrid")

# Plot the data
ggmap(viettri) + # Satelite image
    # Add the points
    geom_point(data = reads, aes(x = lon, y = lat, size = Consumption), 
        shape = 21, colour = "dodgerblue4", fill = "dodgerblue", alpha = .5) +
    scale_size_area(max_size = 20) + 
    # Size of the biggest point 
    ggtitle("Việt Trì sự tiêu thụ nước")

# Save image to disk
ggsave("Hydroinformatics/PhuTho/VietTri.png")
