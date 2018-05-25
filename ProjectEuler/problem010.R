## Problem 10: Summation of primes
## https://projecteuler.net/problem=10
## https://r.prevos.net/euler-problem-10/

source("euler.R")

primes <- esieve(2e6)
answer <- sum(as.numeric(primes))
print(answer)

p <- length(primes)
gaps <- primes[2:p] - primes[1:(p - 1)]

library(ggplot2)
ggplot(as.data.frame(gaps), aes(gaps)) +
    geom_histogram(binwidth=1) +
    xlab("Prime Gap")
ggsave("Images/problem010.png")
