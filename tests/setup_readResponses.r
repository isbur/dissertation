library(rlang)


# print(env_parents())
ROOT_WD = "/home/Igor/dissertation"
source("../implementation/read_responses.r", chdir=TRUE)

cur_wd = getwd()
setwd(ROOT_WD)
Responses = read_responses()
# print(ls())
# assign("Responses3", read_responses(), envir = parent.frame)
setwd(cur_wd)
