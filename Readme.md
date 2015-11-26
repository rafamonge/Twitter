# Twitter #

This repository contains C# and R code to extract and analyze twitter data.

## R ##

Uses TwitteR library to extract the tweets. The uses the tm library to perform text mining. This includes performing data transformations such as removing punctuation, converting all words to lower case, removing whitespaces, stemming words (e.g. running -> run) etc.

After that, a Terms Document Matrix is created (essentially a matrix with words in the rows, tweets in the columns and counts in the intersection).

This is then used to create plots, clusters and sentiment analysis.

Note: the code to connect to twitter assumes that you're behind a proxy. Remove the  set_config(use_proxy(url=server,port)) line if that's not your case.

## Getting twitter keys ##

1. Create a twitter account
2. Go to https://apps.twitter.com/app/new
3. Fill in the form sample values: Name = TwitterDemoForCOP, description = "test", website = "test.intel.com" and create the app.
4. Get/generate the access tokens.
5. You'll need several values for connecting to twitter.  
	-  Consumer Key (API Key)
	-  Consumer Secret (API Secret)
	-  Access Token
	-  Access Token Secret
6. Go to GetTweets.R and run  "RUN THIS THE FIRST TIME WITH YOUR CREDENTIALS " section with the credentials you got on the step above
7. The sentiment library in R has been archived. However, there doesn't seem to be a good alternative. Run the code on installSentiment.R to install it from the included tar.gz files
8. install any other R libraries you do not have. This include
	- ggplot2
	- dplyr
	- tm
	- reshape2
	- RCurl
	- twitterR
	- base64enc
	- httr
	- SnowballC
	- fpc
	- cluster
	- any other found in a library(XYZ) statement
 
## C# ##

Requirements
- Visual Studio 2013
- .Net 4.5

It's POC using the BoxKite libraty to extract the tweets. The tweets are then stored on a folder in json format. By deserializing the tweets, you can then use LINQ in order to perform queries on them. However, the analysis capabilities in c# were rather limited, so the R side of this repo was born. The c# code is mostly included for reference