context("Check consisntency of main.r source() statements and verify state of .GlobalEnv")

library(rlang)
library(pryr)

# env_print(.GlobalEnv$PersistentEnv)

source("../../main.r", chdir = TRUE)


test_that("Bonus empty test for successful sourcing passing",{
    
})
test_that("Check location of the current environment",{
    # cat("\n")
    # print(trace_back())
    # cat("\n")
})
test_that("Check some objects existence within PersistentEnv",{
    # cat("\nCurrent Environment:\n", ls(), env_print(), "\n")
})
test_that("Check ability of main() to be executed without any errors", {
    main()
})

