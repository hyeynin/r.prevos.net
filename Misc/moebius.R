# Topological Tomfoolery in R: Plotting a Möbius Strip
# Peter Prevos
# https://r.prevos.net/plotting-mobius-strip/ 

library(rgl)
library(plot3D)

# Define Parameters
R <- 5 # Radius
n <- 3 # Number of twists
u <- seq(0, 2 * pi, length.out = 100)
v <- seq(-1, 1, length.out = 100)
m <- mesh(u, v)
u <- m$x
v <- m$y

# Möbius Strip parametric equations
x <- (R * 2 + v/2 * cos(n * u /2)) * cos(u)
y <- (R + v/2 * cos(n * u /2)) * sin(u)
z <- v/2 * sin(u / 2)

# Visualise
bg3d(color = "white")
surface3d(x, y, z, color= "blue")
