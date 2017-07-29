pumps <- read.csv("Cholora/pumps.txt")
deaths <- read.csv("Cholora/deaths.txt")

plot(deaths$X, deaths$Y, pch=19, xlim=c(0,20), ylim=c(0,20))
points(pumps$X, pumps$Y, col="blue", pch=19)


library(png)
snow_map <- readPNG("Cholora/snow_map.png")

#Set up the plot area
plot(type='n', main="Plotting Over an Image", xlab="Easting", ylab="Northing", xlim=c(0,4417), ylim=0,4201)

#Get the plot information so the image will fill the plot box, and draw it
lim <- par()
rasterImage(snow_map, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
grid()
points(pumps$X, pumps$Y, col="blue", pch=19, cex=2, xlim=c(0,20))


library(ggplot2)
g <- rasterGrob(snow_map, interpolate=TRUE) 
help("rasterImage")



help("annotation_custom")


klust <- kmeans(deaths[,1:2], 5, nstart=20)
plot(deaths$X, deaths$Y, col=klust$cluster, pch=19)
points(pumps$X, pumps$Y, col="orange", pch=17, cex=3)
