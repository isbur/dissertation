n <- 1000
marginal <- list(c(0.5), c(0.5))
Sigma <- matrix(c(1,0.9,0.9,1),2,2)
m <- ordsample(n, marginal, Sigma)
(spineplot(factor(m[,2]) ~ factor(m[,1])))

# https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
# https://cran.r-project.org/web/packages/xlsx/xlsx.pdf
# system.file() is unnecessary and moreover harmful

install.packages("xlsx")
library("xlsx")


#    file = read.xlsx(paste("responses", postfix, ".xlsx", sep=""), 1)


library(devtools)
source_gist(4676064) # as.data.frame(some list) -> some data.frame

Postfices = c("A","K","U")
responses=data.frame()
for (postfix in Postfices) {
    file = read.xlsx(paste("responses", postfix, ".xlsx", sep=""), 1)
    file = as.data.frame(file)
    
    responses = rbind(responses,file)
}
