# Problem 6: Sum square difference
# https://projecteuler.net/problem=6
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

# Solution 1
n <- 100
answer <- sum(1:n)^2 - sum((1:n)^2)
print(answer)

# Solution 2
answer <- ((n * (n + 1)) / 2)^2 - (n * (n + 1) * (2 * n + 1)) / 6
print(answer)
