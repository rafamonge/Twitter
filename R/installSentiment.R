library(ggplot2)

## Note: sentimente package has been deprecated. Therefore, manual install is needed. There doesn't seem to be a good alternative to it (but my research wasn't extensive)

if (!require("pacman")) install.packages("pacman")
pacman::p_load(devtools, installr)
install.Rtools()
download.file("http://cran.cnr.berkeley.edu/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz", "Rstem_0.4-1.tar.gz")
install.packages("Rstem_0.4-1.tar.gz", repos=NULL, type="source")

download.file("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz", "sentiment_0.2.tar.gz")
install.packages("sentiment_0.2.tar.gz", repos=NULL, type="source")

library(sentiment)
