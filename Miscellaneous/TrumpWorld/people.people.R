person.person <- read.csv("TrumpWorld/TrumpWorld Data person-person.csv", stringsAsFactors = FALSE)
person.org <- read.csv("TrumpWorld/TrumpWorld Data person-org.csv", stringsAsFactors = FALSE)
org.org <- read.csv("TrumpWorld/TrumpWorld Data org-org.csv", stringsAsFactors = FALSE)

nodes <- 

trumpworld <- data.frame(a = c(person.person[,1], person.org[,1], org.org[,1]),
                         b = c(person.person[,2], person.org[,2], org.org[,2]),
                         c = c(person.person[,3], person.org[,3], org.org[,3]))
library(igraph)
g <- graph.edgelist(as.matrix(trumpworld[,1:2]))
E(g)$connection

par(mar=rep(0,4))
plot(g, layout=layout.fruchterman.reingold, 
     vertex.size=2, 
     vertex.label.cex=.2,
     edge.arrow.size=.1)

nodes <- V(g)
links <- E(g)
    
library('visNetwork') 
visNetwork(nodes, links, width="100%", height="400px", main="Network!")
