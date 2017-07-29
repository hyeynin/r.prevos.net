# Monte Carlo Simulation
library(triangle)


par(mfrow=c(2,2), mar=c(0,0,0,0))
plot(dtriangle(seq(.1:.9, by = .01)), type="l")
plot(ptriangle(seq(.1:.9, by = .01)), type="l")
plot(qtriangle(seq(.1:.9, by = .01)), type="l")
plot(rtriangle(seq(.1:.9, by = .01)), type="l")

tri1 <- rltriangle(100000, 1, 100, 10)
tri2 <- rltriangle(10000, 1, 100, 10)
tri3 <- rltriangle(200000, 1, 100, 10)
tri4 <- rltriangle(35000, 1, 100, 10)
tri5 <- rltriangle(780000, 1, 100, 10)

hist(tri1+tri2+tri3+tri4+tri5, breaks = 1000000)
