# source("./meta/persistent_source.r")
# create_persistent_environment()

options(warn = 2)


library(rstudioapi)
jobRunScript("./tests/autotest_IMPPROVE_SOME_ANSWER.r",
             workingDir = getwd()) # Assuming it returns project root folder
jobRunScript("./tests/autotest_main.r",
             workingDir = getwd())
jobRunScript("./tests/autotest_generalProcedure.r",
             workingDir = getwd())
