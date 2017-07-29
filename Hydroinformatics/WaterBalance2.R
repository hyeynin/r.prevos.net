# igraph water balance

# Define Network
library(igraph)
g <- graph_from_literal(A-+B:C:D, C-+E:F, D-+G, E:F-+H, G-+F)

# Randomised flows
set.seed(2017)
V(g)$flows <- c(sample(30:45, 1), sample(10:15, 3),
                sample(05:10, 2), sample(05:10, 1), 
                sample(10:15, 1))

# Visualise network
visualise <- function(x) {
    plot(x, layout = layout_as_tree, 
         vertex.color = NA, 
         vertex.label.color = "black",
         vertex.frame.color=NA,
         vertex.size =32,
         vertex.label = paste(V(x)$name, V(x)$flows),
         edge.color = "black",
         edge.arrow.size=.5)
}
par(mar=rep(0,4), mfrow=c(1,1))
visualise(g)

# Balance
balance <- function(x){
    upstream <- which(degree(x, mode="in")==0)
    downstream <- which(degree(x, mode="out")==0)
    total.balance <-  sum(V(g)$flows[downstream]) - sum(V(g)$flows[upstream])
    paste(paste(V(g)$flows[downstream], collapse=" + "), "-", paste(V(g)$flows[upstream], collapse=" + "), "=", total.balance)
}

balance(g)

h <- g
par(mar=rep(0,4), mfrow=c(2,3))
while(length(V(h)) > 0) {
    upstream <- V(h)[degree(h, mode = "in") == 0]
    nbours <- neighbors(h, upstream[1])
    if (any(degree(g, V(g)$name %in% V(h)[nbours]$name, mode="in") > 1)) {
        upstream <- nbours
        nbours <- neighbors(h, nbours, mode="all")
    }
    i <- induced.subgraph(h, c(upstream[1], nbours))
    visualise(i)
    balance(i)
    h <- delete_vertices(h, upstream[1])
    h <- delete_vertices(h, V(h)[degree(h)==0])
}
plot(h)


