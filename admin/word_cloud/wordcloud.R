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

library(webshot)
library(htmlwidgets)
hw = wordcloud2(w,size = 0.4,shape = 'circle', rotateRatio = 0.5,minSize = 15)
saveWidget(hw,"wordcloud.html",selfcontained = F)
#webshot::webshot(output,paste(args[1],"png",sep="."),vwidth = 1992, vheight = 1744, delay =10)
