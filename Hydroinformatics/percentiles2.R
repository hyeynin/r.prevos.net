# Percentile fitting

library(ggplot2)
library(quantreg)

my.url <- 'https://dl.dropboxusercontent.com/u/10963448/QuantileEg.csv'
wq <- read.csv(my.url)
wq$Date <- as.Date(wq$Date, format = "%d/%m/%y")
wq <- wq[complete.cases(wq), ]

fit <- function(p)
    quantreg::rq(Total.N ~ splines::bs(Date, df = 15), tau = p, data = wq)

wq$pc.25 <- predict.rq(fit(0.25))
wq$pc.50 <- predict.rq(fit(0.50))
wq$pc.75 <- predict.rq(fit(0.75))

ggplot(wq, aes(x = Date, y = Total.N)) + geom_point() + 
    geom_line(aes(y = pc.75, colour = "75th percentile")) + 
    geom_line(aes(y = pc.50, colour = "Median")) + 
    geom_line(aes(y = pc.25, colour = "25th percentile")) + 
    scale_color_manual(name = "", 
                       values = c("75th percentile" = "red", "25th percentile" = "green", "Median" = "blue"), 
                       breaks = c("75th percentile", "Median", "25th percentile")) +
    theme_bw() +
    ylab('Total Nitrogen mg/L')
ggsave("quantreg.png")


x <- 12
bf <- 1

i <- 4
for (i in 2:x) {
    bf <- Reduce("+", rep(bf, i))
}
print(bf)
factorial(x)


Reduce("+", rep(12, 13))

