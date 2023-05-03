args <- commandArgs(TRUE)
dir<-getwd()
setwd(dir)
library(mongolite)
collName<-args[1]
mydb <- mongo(collection=collName ,db="fbDB", url = "mongodb://localhost:27017")
english <- mydb$find('{}','{"post" : 1,"_id":0}')#,'{}')#,"_id":{ $gt: count2}}')
C<-NULL
count<-nrow(english)
if(count>200)
    {count<-count[1]-100} else {count=0}
for(i in count:nrow(english))
{
    C <- append(C,english[i,])
}
# Read file
#apple <- read.csv(file.choose(), header = T)
#str(apple)

# Build corpus
library(tm)
#utf8text <- iconv(text, to='UTF-8', sub = "byte")
corpus <- iconv(C, to='UTF-8')
corpus <- Corpus(VectorSource(corpus))

# Clean text
corpus <- tm_map(corpus, tolower)

corpus <- tm_map(corpus, removePunctuation)

corpus <- tm_map(corpus, removeNumbers)

cleanset <- tm_map(corpus, removeWords, stopwords('english'))

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))

cleanset <- tm_map(cleanset, removeWords, c('aapl', 'apple'))
cleanset <- tm_map(cleanset, gsub, 
                   pattern = 'stocks', 
                   replacement = 'stock')

cleanset <- tm_map(cleanset, stripWhitespace)

# Term document matrix
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)

# Bar plot
w <- rowSums(tdm)
w <- subset(w, w>=25)
#barplot(w,
 #       las = 2,
  #      col = rainbow(50))

# Word cloud
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)

#LDA
library(topicmodels)
dtm<-DocumentTermMatrix(cleanset)
rowTotals <- apply(dtm , 1, sum) #Find the sum of words in each Document
dtm.new   <- dtm[rowTotals> 0, ]
ap_lda<-LDA(dtm.new,k=2,control = list(seed=1234))
ap_lda
library(tidytext)
ap_topics<-tidy(ap_lda,matrix="beta")
ap_topics
library(ggplot2)
library(dplyr)
output=paste(args[1],"png",sep=".")
png(filename=output,width=900,height = 600)

# most common ap_top_termss in topics:
ap_top_terms<- ap_topics %>%
    group_by(topic)%>%
    top_n(10,beta) %>%
    ungroup() %>%
    arrange(topic,-beta)
ap_top_terms %>%
    mutate(term=reorder(term,beta))%>%
    ggplot(aes(term,beta,fill=factor(topic))) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~topic,scales="free")+
    coord_flip()
dev.off()

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')

library(htmlwidgets)
hw = wordcloud2(w,size = 0.7, shape = 'square',rotateRatio = 0.5,minSize = 1)
output=paste(args[1],"html",sep=".")
saveWidget(hw,output,selfcontained = F)
#webshot::webshot(output,paste(args[1],"png",sep="."),vwidth = 1992, vheight = 1744, delay =10)
