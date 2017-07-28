# Problem 19
# https://projecteuler.net/problem=19

dates <- seq.Date(as.Date("1901/01/01"), as.Date("2000/12/31"), "days")
days <- rep(1:7, length.out=length(dates))
answer <- sum(days[substr(dates, 9, 10)=="01"]==1)
print(answer)

library(lubridate, quietly=TRUE)
answer <- sum(wday(dates[substr(dates, 9, 10)=="01"])==1)
print(answer)

week.day <- 0
answer <- 0
for (y in 1901:2000) {
    for (m in 1:12) {
        max.day <- 31
        if (m %in% c(4, 6, 9, 11)) max.day <- 30
        if (m == 2) {
            if (y%%4 == 0 & y%%100 != 0 | y%%400 == 0) max.day <- 29
            else max.day <- 28
            }
        for (d in 1:max.day) {
            week.day <- week.day + 1
            if (week.day == 8) week.day <- 1
            if (week.day == 1 & d == 1) answer <- answer + 1
        }
    }
}
print(answer)


