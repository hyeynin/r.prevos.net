#Read Preference Data
htv <- read.csv("BendigoHtV.csv", header=T)
htv

#Convert preferences to points matrix
#Second preference = 7 points
row.names(htv) <- htv[,1]
htv <- as.matrix(9-htv[,-1])

#Remove self-preference (first preference)
diag(htv) <- 0
htv

#Number of points received by parties
#Each partie can distribute 28 points (1-7)
#Max=7*7, min=7*1
barplot(sort(colSums(htv)), ylim=c(7,49))
abline(h=7, col="red")
abline(h=49, col="red")

#Calculate net scores (strength of ties) between parties
htv[lower.tri(htv)] <- htv[lower.tri(htv)]+htv[upper.tri(htv)]
htv[upper.tri(htv)] <- 0
htv

#Network analysis
#Spinglass community detection based on the strength of ties
library(igraph)
g <- graph.adjacency(htv, weighted=T, mode = "undirected")
c <- spinglass.community(g)
plot(c,g)
