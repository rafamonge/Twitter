
GetHClust<-function(commonTerms, distanceMatrix){
  ##clustering
  
  ##hierarchy
  fit <- hclust(distanceMatrix, method="ward")
}


GetKMeans<- function(commonTerms, clusters, distanceMatrix){
  kfit <- kmeans(distanceMatrix, clusters)
}