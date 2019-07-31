##############################
# Get target probabilities
##############################

# install.packages("xlsx")
library("xlsx")
# install.packages("devtools")
library(devtools)
source_gist(4676064) # as.data.frame(some list) -> some data.frame

Postfices = c("A","K","U")
responses=data.frame()
for (postfix in Postfices) {
  file = read.xlsx(paste("responses", postfix, ".xlsx", sep=""), 1)
  file = as.data.frame(file)
  responses = rbind(responses,file)
}