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

CreateSentimentCorpusFromFolder <- function(folder){
  DataSet <- ReadMergedFromFolder(folder)
  DataSet$source <- folder
  corpus <- BuildCorpus2(DataSet)
  sentiment<- GetSentimentAnalysisDf(sapply(corpus, as.character))
  meta(corpus, "polarity", type="local") <-sentiment$polarity
  meta(corpus, "emotion", type="local") <-sentiment$emotion
  corpus
}

transformer<- CreateSentimentCorpusFromFolder("TwitterData/asusTransformer")
ipadPro<- CreateSentimentCorpusFromFolder("TwitterData/ipadPro")
surface4<- CreateSentimentCorpusFromFolder("TwitterData/surface4")
surfaceBook<- CreateSentimentCorpusFromFolder("TwitterData/surfacebook")


surface4DF <- readRDS("TwitterData/surface4/mergedWithSentiment.rda")
ipadProDF <- readRDS("TwitterData/ipadPro/mergedWithSentiment.rda")
surfaceBookDF <- readRDS("TwitterData/surfacebook/mergedWithSentiment.rda")
asusTransformerDF <- readRDS("TwitterData/asusTransformer/mergedWithSentiment.rda")
asusTransformerDF$source  <- c("asusTransformer")

combined <- rbind (surface4DF, ipadProDF, surfaceBookDF, asusTransformerDF)
combined <- readRDS("TwitterData/combined.rda")
saveRDS(combined, "TwitterData/combined.rda")



meta(corpus, "id", type="local") <-sapply(corpus, meta, "title")
termsMatrix <- TermDocumentMatrix(corpus)
termsDf <- as.data.frame(inspect(termsMatrix))

saveRDS(termsMatrix, "TwitterData/termsMatrix.rda")
saveRDS(termsDf, "TwitterData/termsDf.rda")
combined <- readRDS("TwitterData/combined.rda")


surface4Plot <- combined %>% filter(source == "surface4") %>% GetPolarityPlot("Surface 4 polarity")
ipadProPlot <- combined %>% filter(source == "ipadPro") %>% GetPolarityPlot("ipadPro polarity")
surfaceBookPlot <- combined %>% filter(source == "surfaceBook") %>% GetPolarityPlot("surface book polarity")
asusTransformerPlot <- combined %>% filter(source == "asusTransformer") %>% GetPolarityPlot("asus transformer polarity")
ggsave("plots/surface4Plot.png", surface4Plot, width = 10, height = 4)
ggsave("plots/ipadProPlot.png", ipadProPlot, width = 10, height = 4)
ggsave("plots/surfaceBookPlot.png", surfaceBookPlot, width = 10, height = 4)
ggsave("plots/asusTransformerPlot.png", asusTransformerPlot, width = 10, height = 4)

surface4PlotEmotion <- combined %>% filter(source == "surface4") %>% GetEmotionPlot("Surface 4 emotion")
ipadProPlotEmotion <- combined %>% filter(source == "ipadPro") %>% GetEmotionPlot("ipadPro emotion")
surfaceBookPlotEmotion <- combined %>% filter(source == "surfaceBook") %>% GetEmotionPlot("surface book emotion")
asusTransformerPlotEmotion <- combined %>% filter(source == "asusTransformer") %>% GetEmotionPlot("asus transformer emotion")
ggsave("plots/surface4PlotEmotion.png", surface4PlotEmotion, width = 10, height = 4)
ggsave("plots/ipadProPlotEmotion.png", ipadProPlotEmotion, width = 10, height = 4)
ggsave("plots/surfaceBookPlotEmotion.png", surfaceBookPlotEmotion, width = 10, height = 4)
ggsave("plots/asusTransformerPlotEmotion.png", asusTransformerPlotEmotion, width = 10, height = 4)

combinedMod <- combined
combinedMod$date <- as.Date(combinedMod$created)
countBySource <- combinedMod %>%
  group_by(source, date) %>%
  mutate(countBySourceDate = n())  %>%
  group_by(source, date, polarity) %>%
  summarize(pct = 100*n()/max(countBySourceDate) ) %>%
  arrange(source, date, polarity)


positive <- countBySource %>% filter(polarity=="positive")
positivePlotOverTime <- ggplot(positive, aes(x=date, y=pct, colour=source)) + geom_line() + ylab("% of positive of tweets per day") + xlab("Date") + ggtitle("Sentiment over time")
ggsave("plots/positivePlotOverTime.png", positivePlotOverTime, width = 10, height = 4)