args <- commandArgs(TRUE)
dir<-getwd()
setwd(dir)
# Load the package
library(TwitteR2Mongo)
library(mongolite)
collName<-args[1]
mydb <- mongo(collection=collName ,db="twitterDB", url = "mongodb://localhost:27017")
english <- mydb$find('{}','{"text" : 1,"_id":0}')#,'{}')#,"_id":{ $gt: count2}}')
C<-NULL
count<-nrow(english)
if(count>100)
{count<-count[1]-100} else {count=0}
for(i in count:nrow(english))
{
    C <- append(C,english[i,])
}

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

cleanset <- tm_map(cleanset, removeWords, c('cmomaharashtra'))

cleanset <- tm_map(cleanset, stripWhitespace)

# Term document matrix
tdm <- TermDocumentMatrix(cleanset)
tdm <- as.matrix(tdm)

# Bar plot
w <- rowSums(tdm)
w <- subset(w, w>=25)

# Word cloud
library(wordcloud)
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
#wordcloud(words = names(w), freq = w,max.words = 150,random.order = F, min.freq = 5,colors = brewer.pal(8, 'Dark2'),scale = c(5, 0.3),rot.per = 0.7)

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')

#LDA
library(topicmodels)
ap_lda<-LDA(DocumentTermMatrix(cleanset),k=2,control = list(seed=1234))
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



library(webshot)
library(htmlwidgets)
hw = wordcloud2(w,size = 0.4,shape = 'circle', rotateRatio = 0.5,minSize = 15)
output=paste(args[1],"html",sep=".")
saveWidget(hw,output,selfcontained = F)
#webshot::webshot(output,paste(args[1],"png",sep="."),vwidth = 1992, vheight = 1744, delay =10)
