library(ggplot2)

GetKeywordChart <- function(keyword, matrix){
  associations <- findAssocs(termsMatrix, 'obama', 0.20) 
  associations <- as.data.frame(associations)
  associations$words <- rownames(associations)
  rownames(associations) <- NULL 
  names(associations) <- c("association", "word")
  associations$word <- factor(associations$word, levels = associations$word[order(associations$association)])
  chart  <- ggplot(associations, aes(word, association)) + geom_bar(stat="identity")  + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  chart
}

