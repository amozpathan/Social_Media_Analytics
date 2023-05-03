dir<-getwd()
setwd(dir)
library(RMySQL)
mydb = dbConnect(MySQL(), user='root', password='', dbname='social_network', host='localhost')
rs1 = dbSendQuery(mydb, "select * from posts")
post = fetch(rs1, n=-1)
dbClearResult(rs1)
# Load the package
english <- post$post_content
english
C<-NULL
count<-NROW(english)
if(count>100)
{count<-count[1]-100} else {count=0}
for(i in count:NROW(english))
{
    C <- append(C,english[i])
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


#LDA
library(topicmodels)
ap_lda<-LDA(DocumentTermMatrix(cleanset),k=9,control = list(seed=1234))
ap_lda
library(tidytext)
ap_topics<-tidy(ap_lda,matrix="beta")
ap_topics
library(ggplot2)
library(dplyr)

png(filename="ldaGraph.png",width=900,height = 600)

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
