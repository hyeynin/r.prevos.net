## Network Example
## https://www.reddit.com/r/rstats/comments/9pwhiv/network_plotting_question_what_is_the_r_package/

suns <- read.csv("suns-mavericks.csv")
library(igraph)
g <- graph.data.frame(suns, directed = TRUE)
E(g)$weight = suns$Weight
edgelabel <- E(g)$weight
edgelabel[edgelabel == 1] <- NA
png("Suns-Mavericks.png", width = 200, height = 200, units = "mm", res = 300)
plot(g,
     layout = layout.fruchterman.reingold(g),
     vertex.size = degree(g) * 1.5,
     vertex.color = "#e45f1f",
     vertex.frame.color = NA,
     vertex.label.dist = -3,
     vertex.label.color = "#e45f1f",
     vertex.label.family = "Sans",
     edge.width = E(g)$weight * 2,
     edge.color = "lightgrey",
     edge.curved = .2,
     edge.label = edgelabel,
     edge.label.color = "black",
     edge.label.family = "Arial",
     edge.label.cex = 1.5,
     main = "How the Suns Players Assisted One Another",
     sub = "Mavericks vs. Suns")
dev.off()


