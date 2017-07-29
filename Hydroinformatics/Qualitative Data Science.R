#Load data
library(RQDA)
openProject("Hydroinformatics/Macromarketing/stakeholders.rqda")

# Word frequency diagram
library(tm)
interviews <- RQDAQuery("SELECT file FROM source")
interviews <- Corpus(VectorSource(interviews$file))
interviews <- tm_map(interviews, stripWhitespace)
interviews <- tm_map(interviews, content_transformer(tolower))
interviews <- tm_map(interviews, removeWords, stopwords("english"))
interviews <- tm_map(interviews, removePunctuation)
interviews <- tm_map(interviews, removeNumbers)
interviews <- tm_map(interviews, removeWords, c("interviewer", "interviewee"))

library(wordcloud)
set.seed(1234)
wordcloud(interviews, min.freq = 10, max.words=200, random.order=FALSE, 
          rot.per=0.35, colors=brewer.pal(8, "Dark2"))

# Topic Analysis
library(topicmodels)
dtm <- DocumentTermMatrix(interviews)
ldaOut <-LDA(dtm, k = 4)
terms(ldaOut,6)


