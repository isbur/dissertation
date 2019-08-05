library("xlsx")

Postfices = c("A","K","U")
responses=data.frame()
for (postfix in Postfices) {
    file = read.xlsx(paste("responses", postfix, ".xlsx", sep=""), 1)
    file = as.data.frame(file)
    responses = rbind(responses,file)
}

n_individuals = length(responses[,1])