## Topological Tomfoolery in R: Plotting a Möbius Strip
## Peter Prevos
### https://lucidmanager.org/plotting-mobius-strip/

library(rgl)
library(plot3D)

## Define Parameters
R <- 1 # Radius
n <- 1 # Number of twists
u <- seq(0, 2 * pi, length.out = 100)
v <- seq(-1, 1, length.out = 100)
m <- mesh(u, v)
u <- m$x
v <- m$y

## Möbius Strip parametric equations
x <- (R  + v * cos(n /2)) * cos(n)
y <- (R + v * cos(n  /2)) * sin(n)
z <- v * sin(n/ 2)

## Visualise
bg3d(color = "grey")
surface3d(x, y, z, color= "red")




