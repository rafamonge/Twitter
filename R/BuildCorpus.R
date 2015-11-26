library(tm)

BuildCorpus<- function(tweetsDf){
  # build a corpus
  corpus <- Corpus(VectorSource(tweetsDf$text))
  corpus <-tm_map(corpus, function(x) iconv(x, to='UTF-8', sub='byte'))
  # make each letter lowercase
  corpus <- tm_map(corpus, tolower) 
  # remove punctuation 
  corpus <- tm_map(corpus, removePunctuation)
  # strip white space
  corpus <- tm_map(corpus, stripWhitespace)
  # Stem
  # "run", "runs" and "running" all become "run").
  corpus <- tm_map(corpus, stemDocument)
  # remove stopwords
  stopWords <- c(stopwords('english'))
  corpus <- tm_map(corpus, removeWords, stopWords)
  corpus <- tm_map(corpus, PlainTextDocument)
  corpus
}
