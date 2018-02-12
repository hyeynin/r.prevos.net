# Topological Tomfoolery in R: Plotting a Möbius Strip
# Peter Prevos
# https://r.prevos.net/plotting-mobius-strip/ 

library(rgl)
library(plot3D)

# Define Parameters
R <- 5 # Radius
n <- 1 # Number of twists
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

# Klein Bottle (3D Möbius Strip)
u <- seq(0, pi, length.out = 100)
v <- seq(0, 2 * pi, length.out = 100)
m <- mesh(u, v)
u <- m$x
v <- m$y
x <- (-2 / 15) * cos(u) * (3 * cos(v) - 30 * sin(u) + 90 * cos(u)^4 * sin(u) - 60 * cos(u)^6 * sin(u) + 5 * cos(u) * cos(v) * sin(u))
y <- (-1 / 15) * sin(u) * (3 * cos(v) - 3 * cos(u)^2 * cos(v) - 48 * cos(u)^4 * cos(v) + 48 * cos(u)^6 * 
                               cos(v) - 60 * sin(u) + 5 * cos(u) * cos(v) * sin(u) - 5 * cos(u)^3 * cos(v) * sin(u) - 80 * 
                               cos(u)^5 * cos(v) * sin(u) + 80 * cos(u)^7 * cos(v) * sin(u))
z <- (+2 / 15) * (3 + 5 * cos(u) * sin(u)) * sin(v)

bg3d(color = "white")
surface3d(x, y, z, color= "blue", alpha = 0.5)
