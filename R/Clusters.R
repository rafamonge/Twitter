
GetHClust<-function(commonTerms){
  ##clustering
  commonTermsDf.scale <- scale(commonTerms)
  d <- dist(commonTermsDf.scale, method = "euclidean") # distance matrix
  ##hierarchy
  fit <- hclust(d, method="ward")
}


GetKMeans<- function(commonTerms, clusters){
  ##clustering
  commonTermsDf.scale <- scale(commonTerms)
  d <- dist(commonTermsDf.scale, method = "euclidean") # distance matrix

  kfit <- kmeans(d, clusters)   
}