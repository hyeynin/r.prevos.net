# Euler Problem 30: Digit Fifth Powers
# https://projecteuler.net/problem=30

# Find the sum of all the numbers that can be written as the 
# sum of fifth powers of their digits.

t <- proc.time()
largest <- 6 * 9^5
answer <- 0
for (n in 2:largest) {
    power.sum <-0
    i <- n
    while (i > 0) {
        d <- i %% 10
        i <- floor(i / 10)
        power.sum <- power.sum + d^5
    }
    if (power.sum == n) {
        print(n)
        answer <- answer + n
    }
}
print(answer)
print(proc.time()-t)
