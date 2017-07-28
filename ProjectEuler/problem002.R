# Problem 2: Even Fibonacci numbers
# https://projecteuler.net/problem=2
# By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
# find the sum of the even-valued terms.

fib <- c(1, 2)  #Define first two numbers
while (max(fib) < 4E+06) { 
    # Generate Fibonacci numbers until limit is reached
    len <- length(fib)
    fib <- c(fib, fib[len - 1] + fib[len])
}
answer <- sum(fib[fib %% 2 == 0])
print(answer)

library(gmp)
i <- 1
answer <- 0
fib <- fibnum(1)
while (fibnum(i) <= 4E6) {
    fib <- fibnum(i)
    if (fib %% 2 == 0) answer <- answer + fib
    i <- i + 1
}
print(answer)
