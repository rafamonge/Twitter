library(sentiment)
library(dplyr)
#library(syuzhet)
#library(qdap )

GetSentimentAnalysisDf <- function (text){
  # classify emotion
  class_emo <- classify_emotion(text, algorithm="bayes", prior=1.0)
  # get emotion best fit
  emotion <- class_emo[,7]
  # substitute NA's by "unknown"
  emotion[is.na(emotion)] <- "unknown"
  
  # classify polarity
  class_pol <- classify_polarity(text, algorithm="bayes")
  # get polarity best fit
  polarity <- class_pol[,4]
  
  
  # data frame with results
  sent_df <- data.frame(text=text, emotion=emotion,polarity=polarity, stringsAsFactors=FALSE)
  
  # sort data frame
  #sent_df <- within(sent_df,emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))
}

GetEmotionPlot <- function(sentimentDf, title = ""){
  # plot distribution of emotions
    ggplot(sentimentDf %>% filter(emotion != "unknown"), aes(x=emotion), environment = environment()) +
    geom_bar(aes(y=(..count..)/sum(..count..) * 100, fill=emotion)) +
    scale_fill_brewer(palette="Dark2") +
    labs(x="emotion categories", y="percentage") +
    ggtitle(title) + 
    scale_y_continuous(limits = c(0, 100))
}





GetPolarityPlot <- function(sentimentDf, title = ""){
  # plot distribution of polarity
    ggplot(sentimentDf, aes(x=polarity)) +
    geom_bar(aes(y=(..count..)/sum(..count..)* 100, fill=polarity)) +
    scale_fill_brewer(palette="RdGy") +
    labs(x="polarity categories", y="percentage")   +
    ggtitle(title) +
    scale_y_continuous(limits = c(0, 100))
  
}
