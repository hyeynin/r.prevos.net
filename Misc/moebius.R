# Moebius strip

library(plot3D)
library(manipulate)

u <- seq(0, 2*pi, length.out=100)
v <- seq(-1, 1,   length.out=100)

m <- mesh(u, v)

u <- m$x
v <- m$y

x <- (1 + (v / 2) * cos(u / 2)) * cos(u)
y <- (1 + (v / 2) * cos(u / 2)) * sin(u)
z <- (v / 2) * sin(u / 2)

par(mar=rep(0,4))

surf3D(x, y, z, colkey=F, phi=120)
