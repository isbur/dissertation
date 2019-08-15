library(testthat)


#### My first test ####

source("./IMPROVE_SOME_ANSWER/handlers/findNearestAnswer.r")

test_dir("./tests/testthat", reporter="summary")

#### #### ####




#### Question processing tests ####
test_dir("./tests/questionwise")
# test_dir("./tests/questionwise", reporter = DebugReporter)
#### #### ####




#### Main.r ####
source("./auxiliary/clean_global_env.r", local = .GlobalEnv)
source("./auxiliary/clean_global_env.r", local = .GlobalEnv$PersistentEnv)
test_dir("./tests/main")
#### #### ####
