library("xlsx")

Postfices = c("A","K","U")
responses=data.frame()
for (postfix in Postfices) {
    file = read.xlsx(paste("./data/responses", postfix, ".xlsx", sep=""), 1)
    file = as.data.frame(file)
    responses = rbind(responses,file)
}

# Script to verify whether fields from expected_corrs are in names list is needed

source("./common/names.r")
names(responses) = names


# n_individuals = length(responses[,1])