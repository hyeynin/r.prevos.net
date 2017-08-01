# Investigating multiple reflections of a laser beam
# Problem 144

# Plot ellipse
a <- 5
b <- 10
plot.new()
plot.window(xlim = c(-5, 5), ylim = c(-10, 10), asp = 1)
par(mar=rep(0,4))
x <- seq(-5, 5, 0.01)
y <- sqrt(b^2 - (b^2 / a^2) * x^2)
lines(x, y)
lines(x, -y)
abline(v = 0, h = 0, col = "lightgrey", lwd = .5)

# First laser
x1 <- 0
y1 <- 10.1
x2 <- 1.4
y2 <- -9.6
answer <- 0

while((x2 < -0.01 | x2 > 0.01) | y2 < 0) {
    # Draw laser
    lines(c(x1, x2), c(y1, y2), col = "red", lwd = .5)
    # Tangent to ellipse
    t <- -4 * x2 / y2
    abline(y2 - t * x2, t, col = "lightgrey")
    # Deflection on sloping mirror y = mx + c
    dydx <- (y2 - y1) / (x2 - x1)
    m <- tan(pi - atan(dydx) + 2 * atan(t))
    c <- y2 - m * x2
    # Determine intersection point
    # Source: http://www.ambrsoft.com/TrigoCalc/Circles2/Ellipse/EllipseLine.htm
    x1 <- x2
    y1 <- y2
    x2a <- (-a^2 * m * c + a * b * sqrt(a^2 * m^2 + b^2 - c^2)) / (a^2 * m^2 + b^2)
    x2b <- (-a^2 * m * c - a * b * sqrt(a^2 * m^2 + b^2 - c^2)) / (a^2 * m^2 + b^2)
    x2 <- ifelse(round(x1 / x2a, 6) == 1, x2b, x2a)
    y2 <- m * x2 + c
    answer <- answer + 1
}
print(answer)



