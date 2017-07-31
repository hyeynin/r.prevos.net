# Problem 1: Multiples of 3 and 5
# https://projecteuler.net/problem=1
# Find the sum of all the multiples of 3 or 5 below 1000

# Solution 1
answer <- 0
for (i in 1:999) {
    if (i %% 3 == 0 | i %% 5 == 0) {
        answer <- answer + i
        print(i)}
}
print(answer)

# Solution 2
answer <- sum((1:999)[((1:999) %% 3 == 0) | ((1:999) %% 5 == 0)])
print(answer)

# Solution 3
answer <- sum(unique(c(seq(3, 999, 3), seq(5, 999, 5))))
print(answer)

# Solution 4
t <- proc.time()
SumDivBy <- function(n, m) {
    p <- m %/% n * n # Round to multiple of n
    return (p * (1 + (p / n)) / 2)
}
answer <- SumDivBy(3, 999) + SumDivBy(5, 999) - SumDivBy(15, 999)
print(answer)
print(proc.time()-t)

# Johannes
t <- proc.time()
answer <- sum(sapply(1:999, function(x){
    if(x%%5 == 0) return(x)
    if(x%%3 == 0) return(x)
    else return(0)
    }
    )
    )
print(answer)
print(proc.time()-t)
















