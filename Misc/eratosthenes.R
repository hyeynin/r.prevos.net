library(animation)
source("ProjectEuler/euler.R")

plotnums <- function(nums, cl="black"){
    for (n in nums) {
        a <- n-1
        y <- 100-(a-a%%10) - 10
        x <- 10*(a%%10)
        text(x,y, n, col=cl)
    }
}

plot.new()
plot.window(xlim=c(0,90), ylim=c(0,90))
par(mar=rep(0,4))

abline(h=seq(5,100,10), col="grey")
abline(v=seq(5,100,10), col="grey")
box(col="grey")

saveGIF({
    plot.new()
    plot.window(xlim=c(0,90), ylim=c(0,90))
    par(mar=rep(0,4))
    
    plotnums(1:100, "black")
    plotnums(seq(4,100,2), "white")
    plotnums(seq(9,100,6), "white")
    plotnums(c(seq(25,100,30),seq(35,100,30)), "white")
    plotnums(c(49,77,91), "white")
}, interval=1, movie.name="Misc/eratosthenes.gif", ani.width=800, ani.height=800)


