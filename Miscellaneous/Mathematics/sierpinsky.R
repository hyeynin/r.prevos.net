## Sierpinsky Triangle

## Initialise triangle
p <- c(0, 0, 1000)
q <- c(0, 1000, 500)
x11()
par(mar = rep(0, 4))
plot(p, q, col= "red", pch = 15, cex = 1, axes = FALSE)

## Random starting point
x <- sample(0:1000, 1)
y <- sample(0:1000, 1)
n <- 1

## Chaos game
for (i in 1:100000) {
    # Sys.sleep(.001)
    n <- (n + 1)
    if (n == 4) n <- 1
    n <- sample(1:length(p), 1)
    x <- floor(x + (p[n] - x) / 2)
    y <- floor(y + (q[n] - y) / 2)
    points(x, y, pch = 15, cex = 0.5)
}
