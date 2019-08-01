##############################
# Get target probabilities
##############################

# install.packages("xlsx")
library("xlsx")

Postfices = c("A","K","U")
responses=data.frame()
for (postfix in Postfices) {
  file = read.xlsx(paste("responses", postfix, ".xlsx", sep=""), 1)
  file = as.data.frame(file)
  responses = rbind(responses,file)
}

n_individuals = length(responses[,1])

probs = list()
maxLen = 0
for (i in c(1:36)) {
    item = table(responses[,i])
    len = length(item)
    if (len > maxLen) {
        maxLen = len
    }
    probs[[i]] = item / n_individuals
    # probs[[i]] = item
}

for (i in c(1:36)) {
    item = table(responses[,i])
    len = length(item)
    item = c(item, rep(0, maxLen - len))
    probs[[i]] = item
}

