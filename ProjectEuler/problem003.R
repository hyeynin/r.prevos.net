## Euler Problem 3: Largest prime factor
## https://r.prevos.net/euler-problem-3/
esieve <- function(n) {
    if (n == 1) return(NULL)
    if (n == 2) return(n)
    ## Create a list of consecutive integers {2,3,…,N}.
    l <- 2:n
    ## Start counter
    i <- 1
    ## Select p as the first prime number in the list, p=2.
    p <- 2
    while (p^2<=n) {
        ## Remove all multiples of p from the l.
        l <- l[l == p | l %% p!= 0]
        ## set p equal to the next integer in l which has not been removed.
        i <- i + 1
        ## Repeat steps 3 and 4 until p2 > n,
        ## all the remaining numbers in the list are primes
        p <- l[i]
    }
    return(l)
}

prime.factors <- function (n) {
    ## Define list of factors
    factors <- c()
    ## Define primes to be tested
    primes <- esieve(floor(sqrt(n)))
    ## Idenitfy prime divisors
    d <- which(n %% primes == 0) 
    ## No prime divisors
    if (length(d) == 0) 
        return(n)
    ## Test candidate primes
    for (q in primes[d]) {
        ## Generate list of factors
        while (n %% q == 0) {
            factors <- c(factors, q)
            n <- n/q } }
    if (n > 1) factors <- c(factors, n)
    return(factors)
}

max(prime.factors(600851475143))

## Using number package
library(numbers)
max(primeFactors(600851475143))

## Sieve animation
library(animation)

plot.sieve <- function(n){
    plot.new()
    plot.window(xlim = c(0, 90), ylim = c(0, 90))
    par(mar = rep(0, 4))
    abline(h = seq(5, 100, 10), col = "grey")
    abline(v = seq(5, 100, 10), col = "grey")
    x <- 10 * (0:99 %% 10)
    y <- 100 - (0:99 - 0:99 %% 10) - 10
    text(x, y, 1:100, col = "black", cex = 3)
    for (i in 1:n) {
        text(x[d[[i]]], y[d[[i]]], d[[i]], col = c[i], cex = 3)
    }
}

d <- list(1,
          seq(4, 100, 2),
          seq(9, 100, 6),
          c(seq(25,100,30),seq(35,100,30)),
          c(49, 77, 91))
c <- c("red", "green", "blue", "orange", "purple")

saveGIF({
    ani.options(interval = 2)
    for (i in 1:5) {
        plot.sieve(i)
        }
}, movie.name = "Images/Eratosthenes.gif", ani.width = 800, ani.height = 800)
