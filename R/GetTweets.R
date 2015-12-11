library(twitteR)
library(RCurl)
library(base64enc)
library(httr)
library(base)

#############################   RUN THIS THE FIRST TIME WITH YOUR CREDENTIALS ###############
#consumerKey <- "consumer"
#consumerSecret <- "secret"
#accessToken <- "token"
#accessSecret <- "secret!"

#server<-  "proxy!"
#port <- 911
#save(consumerKey, consumerSecret, accessToken, accessSecret, server, port, file = "twitterApiInformationAndProxy.rda")
#############################################################################################


ReadMergedFromFolder<- function (folder){
  readRDS(paste(folder, "/merged.RDA", sep=""))
}

GetTweetsFromTwitter <- function(keyword, fileDestination, qty = 15000) {
  load(file = "twitterApiInformationAndProxy.rda")
  set_config(use_proxy(url=server,port)  )
  
  
  setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)
  intelTweets <- searchTwitter(keyword, qty=15000, lang="en")
  dataFrame <- twListToDF(intelTweets)
  
  saveRDS(dataFrame, file <- fileDestination)
  
}

ConnectToTwitter <- function(){
  load(file = "twitterApiInformationAndProxy.rda")
  set_config(use_proxy(url=server,port)  )
  setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)
}

GetTweetsOverTime <- function(keyword, qty, since, until){
  dateSequence <- rev(seq(as.Date(since), as.Date(until), by = "day"))
  sapply(dateSequence, function(x)GetTweetForDay(keyword, qty, x))
}

GetTweetForDay<- function(keyword, qty, day){
  since <- format(day, "%Y-%m-%d")
  untl <- format(day+1, "%Y-%m-%d")
  filename <- paste(paste("TwitterData/",since, keyword, sep="---"), ".rda", sep="")
  tweets <- twListToDF(searchTwitter(keyword, n=qty, since=since, until=untl,lang="en"))
  saveRDS(tweets, file= filename)
  filename
}

GetTweetsFromTwitter <- function(keyword, fileDestination, date, qty = 15000) {

  intelTweets <- searchTwitter(keyword, qty=qty, lang="en")
  dataFrame <- twListToDF(intelTweets)
  
  saveRDS(dataFrame, file <- fileDestination)
  
}


GetTweetsFromFile <- function(){
  readRDS("tweets.rda")
}

mergeRDAS<- function(folder){
  file_list <- list.files(folder, full.names= T)
  
  for (file in file_list){
    print(file)
    # if the merged dataset doesn't exist, create it
    if (!exists("dataset")){
      dataset <- readRDS(file)
      print(nrow(dataset))
    }
    
    # if the merged dataset does exist, append to it
    if (exists("dataset")){
      temp_dataset <-readRDS(file)
      print(nrow(temp_dataset))
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
    }
    
  }
  print(nrow(dataset))
  saveRDS(dataset, paste(folder,"merged.RDA", sep="/"))
  dataset
}

