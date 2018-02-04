# Moebius strip
library(rgl)

# Define Parameters
R <- 5
u <- seq(0, 2 * pi, length.out = 100)
v <- seq(-1, 1, length.out = 100)
m <- mesh(u, v)
u <- m$x
v <- m$y

x <- (R + v/2 * cos(u /2)) * cos(u)
y <- (R + v/2 * cos(u /2)) * sin(u)
z <- v/2 * sin(u / 2)  

bg3d(color = "white")
surface3d(x, y, z, color= "blue")
