# Problem 28: Number spiral diagonals
# https://projecteuler.net/problem=28

source("ProjectEuler/euler.R")

size <- 1001 # Size of matrix
answer <- 1 # Starting number
# Define corners of subsequent matrices
for (n in seq(from = 3, to = size, by = 2)) {
    corners <- seq(from = n * (n - 3) + 3, by = n - 1, length.out = 4)
    answer <- answer + sum(corners)
}
print(answer)

# Ulam Spiral
size <- 201 # Size of matrix
ulam <- matrix(ncol = size, nrow = size)
mid <- floor(size / 2 + 1)
ulam[mid, mid] <- 1
for (n in seq(from = 3, to = size, by = 2)) {
    numbers <- (n * (n - 4) + 5) : ((n + 2) * ((n + 2) - 4) + 4)
    d <- mid - floor(n / 2)
    l <- length(numbers)
    ulam[d, d:(d + n - 1)] <- numbers[(l - n + 1):l]
    ulam[d + n - 1, (d + n - 1):d] <- numbers[(n - 1):(n - 2 + n)]
    ulam[(d + 1):(d + n - 2), d] <- numbers[(l - n):(l - 2 * n + 3)]
    ulam[(d + 1):(d + n - 2), d + n - 1] <- numbers[1:(n - 2)]
}
ulam.primes <- apply(ulam, c(1, 2), is.prime)

# Visualise
library(ggplot2)
library(reshape2)
ulam <- melt(ulam.primes, varnames = c("x", "y"), value.name = "colour")
head(ulam)
ggplot(ulam, aes(x = x, y = y, fill = colour)) + geom_tile() + 
    scale_fill_manual(values = c("white", "dodgerblue4")) + 
    guides(fill=FALSE) +
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank()) + 
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()
    )
ggsave("ProjectEuler/Images/problem028l.png")

