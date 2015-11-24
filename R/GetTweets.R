library(twitteR)
library(RCurl)
library(base64enc)
library(httr)


#consumerKey <- "consumer"
#consumerSecret <- "secret"
#accessToken <- "token"
#accessSecret <- "secret!"

#server<-  "proxy!"
#port <- 911
#save(consumerKey, consumerSecret, accessToken, accessSecret, server, port, file = "twitterApiInformationAndProxy.rda")


GetTweetsFromTwitter <- function(keyword, fileDestination) {
  load(file = "twitterApiInformationAndProxy.rda")
  set_config(use_proxy(url=server,port)  )
  
  setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)
  
  intelTweets <- searchTwitter(keyword, n=15000, lang="en") 
  dataFrame <- twListToDF(intelTweets)
  saveRDS(dataFrame, file <- fileDestination)
  
}


GetTweetsFromFile <- function(){
  readRDS("tweets.rda")
}