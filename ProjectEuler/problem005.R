# Problem 5: Smallest multiple
# https://projecteuler.net/problem=5
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

t <- proc.time()
# Start as high as possible
i <- 2520
# Check consecutive numbers for divisibility by 1:20
while (sum(i%%(1:20)) != 0) {
    i <- i + 2520
}
answer <- i
print(answer)
print(proc.time()-t)

# Analytical Solution using Euclidean algorithm
# David Radcliffe

t <- proc.time()

gcd <- function (x, y) ifelse(x == 0, y, gcd(y %% x, x))
lcm <- function (x, y) x * y / gcd(x,y)

answer <- (Reduce(lcm, 1:20, accumulate=FALSE))
print(answer)

print(proc.time()-t)




