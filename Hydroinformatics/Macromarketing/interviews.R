#Load and transform data
library(RQDA)
openProject("Hydroinformatics/Macromarketing/stakeholders.rqda")
codings <- getCodingTable()[,4:5]
categories <- RQDAQuery("SELECT filecat.name AS category, source.name AS filename 
                         FROM treefile, filecat, source 
                         WHERE treefile.catid=filecat.catid AND treefile.fid=source.id AND treefile.status=1")
codings <- merge(codings, categories, all.y = TRUE)

head(codings)

# Open coding
library(ggplot2)
reorder_size <- function(x) {
    factor(x, levels = names(sort(table(x))))
}
ggplot(codings, aes(reorder_size(codename), fill=category)) + geom_bar(stat="count") + 
    facet_grid(~filename) + coord_flip() + 
    theme(legend.position="bottom", legend.title=element_blank()) + 
    ylab("Code frequency in interviews") + xlab("Code")

ggsave("Images/rqda_codes.png", width=9, height=11)

# Axial coding
edges <- RQDAQuery("SELECT codecat.name, freecode.name FROM codecat, freecode, treecode 
          WHERE codecat.catid=treecode.catid AND freecode.id=treecode.cid")

library(igraph)
g <- graph_from_edgelist(as.matrix(edges), directed=FALSE)
V(g)$name <- gsub(" ", "\n", V(g)$name)

c <- spinglass.community(g)
par(mar=rep(0,4))
set.seed(666)
plot(c, g, 
     vertex.size=10,
     vertex.color=NA,
     vertex.frame.color=NA,
     edge.width=E(g)$weight,
     layout=layout.drl)



library(tm)
interviews <- RQDAQuery("SELECT file FROM source")
interviews <- Corpus(VectorSource(interviews$file))
interviews <-  tm_map(interviews, stripWhitespace)
interviews <-  tm_map(interviews, content_transformer(tolower))
interviews <-  tm_map(interviews, removeWords, stopwords("english"))
interviews <-  tm_map(interviews, removePunctuation)
interviews <-  tm_map(interviews, removeNumbers)
interviews <-  tm_map(interviews, removeWords, c("interviewer", "interviewee"))

library(wordcloud)
pdf("Data files/Images/wordcloud.pdf")
set.seed(1234)
wordcloud(interviews, min.freq = 10, max.words=200, random.order=FALSE, 
          rot.per=0.35, colors=brewer.pal(8, "Dark2"))
dev.off()
