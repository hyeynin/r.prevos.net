
library(rvest)
OzLotto <- readLines("https://thelott.com/nswlotteries/results/number-frequencies")


apply(OzLotto, Function(x) grepl(x, "primaryNumbersDrawnCount"))
