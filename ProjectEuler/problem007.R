# Problem 7: 10001st prime
# https://projecteuler.net/problem=7
# What is the 10 001st prime number?

# Load prime sieve function
source("ProjectEuler/euler.R")

# Check for primality
is.prime <- function(n) {
    primes <- esieve(ceiling(sqrt(n))) # Idenitfy prime divisors
    prod(n%%primes!=0)==1 # Check for divisibility
}

primes <- vector()
primes[1] <- 2
i <- 2 # First number in sequence
n <- 1 # Start counter
while (n<10001) { # Find 10001 prime numbers
    i <- i + 1 # Next number
    if(is.prime(i)) { # Test next number
        primes[n+1] <- i
        n <- n + 1 # Increment counter
        i <- i + 1 # Next prime is at least two away
    }
}

answer <- i-1
print(answer)

gaps <- primes[2:10001] - primes[1:10000]
library(ggplot2)
ggplot(as.data.frame(gaps), aes(gaps)) + geom_histogram(binwidth=1) + xlab("Prime Gap")
ggsave("ProjectEuler/Images/problem007.png")
# Largest
gaps[which.max(gaps)]
# Most common
table(gaps)


