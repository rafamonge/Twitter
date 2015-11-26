library(twitteR)
library(RCurl)
library(base64enc)
library(httr)
library(tm)
library(ggplot2)
library(SnowballC)
library(reshape2)
library(sentiment)
library(fpc)   
library(cluster) 
library(dplyr)
library(tm)
source("GetTweets.R")
source("BuildCorpus.R")
source("keywordChart.R")
source("Clusters.R")
source("Sentiment.R")

tweets <- GetTweetsFromFile()
corpus <- BuildCorpus(tweets)
# build a term-document matrix
termsMatrix <- TermDocumentMatrix(corpus)
# inspect most popular words
#findFreqTerms(termsMatrix, lowfreq=300)

obamaChart <- GetKeywordChart("obama", termsMatrix)
plot(obamaChart)


## keep only the top words
commonTermsMatrix <- removeSparseTerms(termsMatrix, sparse=0.98)
commonTermsDf <- as.data.frame(inspect(commonTermsMatrix))
commonTermsDf <- commonTermsDf[!rownames(commonTermsDf) %in% c('intel'),]
#inspect(commonTermsMatrix[1:30,1:10])
commonTermsDf.scale <- scale(commonTermsDf)
## H Cluster
d <- dist(commonTermsDf.scale, method = "euclidean") # distance matrix

fit <- GetHClust(commonTermsDf, d)
#groups <- cutree(fit, k=5) # cut tree into 5 clusters
plot(fit) # display dendogram?
rect.hclust(fit, k=5, border="red")

#K means cluster
kfit <- GetKMeans(commonTermsDf,6,d)
clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0)   
#clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0)   

## sentiment analysis
transformedText<- sapply(corpus, as.character)
sentimentDf <- GetSentimentAnalysisDf(transformedText)
polarityPlot <- GetPolarityPlot(sentimentDf)
plot(polarityPlot)

emotionPlot <- GetEmotionPlot(sentimentDf)
plot(emotionPlot)

