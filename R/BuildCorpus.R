library(tm)
library(qdap)

BuildCorpus<- function(tweetsDf){
  m <- list(content = "text", author = "screenName", title = "id", favorited="favorited", isRetweet= "isRetweet",retweeted= "retweeted", favorited="favorited", replyToUID="replyToUID", source="source", created="created")
  myReader <- readTabular(mapping = m)
  tweetsDf$text <- sapply(tweetsDf$text, function(x) iconv(x, to='UTF-8', sub='byte'))
  ds <- DataframeSource(tweetsDf)
  # build a corpus
  corpus <- Corpus(ds, readerControl = list(reader= myReader))
  # make each letter lowercase
  corpus <- tm_map(corpus, content_transformer(tolower))
  # remove punctuation 
  corpus <- tm_map(corpus, removePunctuation)
  # strip white space
  corpus <- tm_map(corpus, stripWhitespace)
  # Stem
  # "run", "runs" and "running" all become "run").
  corpus <- tm_map(corpus, stemDocument)
  # remove stopwords
  #stopWords <- c(stopwords('english'))
  #corpus <- tm_map(corpus, removeWords, stopWords)
  corpus
}


BuildCorpusFromFolder <- function (folder){
  
}



