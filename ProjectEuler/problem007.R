## Euler Problem 7: 10,001st Prime
## https://projecteuler.net/problem=7

source("euler.R")
is.prime <- function(n) {
    primes <- esieve(ceiling(sqrt(n)))
    prod(n %% primes!=0)==1
}

i <- 2 # First Prime
n <- 1 # Start counter
while (n < 10001) { # Find 10001 prime numbers
    i <- i + 1 # Next number
    if(is.prime(i)) { # Test next number
        n <- n + 1 # Increment counter
        i <- i + 1 # Next prime is at least two away
    }
}
answer <- i - 1
print(answer)

## Visualise
primes <- esieve(answer)
gaps <- primes[2:10001] - primes[1:10000]

library(tidyverse)

data_frame(gap = gaps) %>%
    ggplot(aes(gap)) +
    geom_histogram(binwidth = 1, fill = "dodgerblue3") +
    xlab("Prime gap occurence")
ggsave("Images/problem007.png", dpi = 300)
