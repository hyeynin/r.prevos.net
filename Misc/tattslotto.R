LottoURL <- "https://thelott.com/tattersalls/results/number-frequencies"

lotto <- readLines(LottoURL)

i <- which(grepl("var product = \"Tattslotto\"", lotto))

while (!grepl("primaryNumbersDrawnCount", lotto[i])) 
    i <- i + 1
primaryNumbersDrawnCount <- lotto[i]
primaryNumbersDrawnCount <- strsplit(primaryNumbersDrawnCount, ",")
primaryNumbersDrawnCount <- sapply(primaryNumbersDrawnCount, 
                                   function(x) as.numeric(gsub("[^0-9]", "", x)))
tattslotto <- data.frame(Number = 1:45, Frequency = primaryNumbersDrawnCount)

library(ggplot2)
ggplot(tattslotto, aes(x=Number, y=Frequency)) + 
    geom_bar(stat="identity", fill="dodgerblue4", alpha=0.5) + 
    geom_hline(yintercept=mean(tattslotto$Frequency), col="red")

avg <- mean(tattslotto$Frequency)
sdev <- sd(tattslotto$Frequency)
ggplot(tattslotto, aes(Frequency)) + geom_histogram(binwidth=5, aes(y=..density..), fill="dodgerblue") + 
    geom_area(stat="function", fun=dnorm, args=list(mean=avg, sd=sdev), 
              colour="red", fill="red", alpha=.5) + 
    theme(text=element_text(size=16))

draws <- (2613-413)


t.test(tattslotto$Frequency, mu=draws * 6/45)


sum(tattslotto$Frequency)/6




