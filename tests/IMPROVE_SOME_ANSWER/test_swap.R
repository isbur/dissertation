context("Swap around")
library(rlang)

#
# print(ls(globalenv()))
# print(env())
# print(search())
# print(get("b", envir = globalenv(), inherits = TRUE))


# print(ls(globalenv()))
source("../setup_cleanup.r", chdir = TRUE)
cleanup()
# print(ls(globalenv()))
source("../setup_readResponses.r", chdir = TRUE)
# print(ls(globalenv()))
source("../setup_testRegistry.r", chdir = TRUE)
######
source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
# print(ls())
source("../../auxiliary/getQuestionById.r", chdir = TRUE)


# print(head(Responses))
# print(head(.GlobalEnv$Responses))
# print(.GlobalEnv)
# print(ls(.GlobalEnv))
# env_print(.GlobalEnv)
##################

test_that("data-frames are being assigned by values",{
    prevResponses = Responses
    Responses[1] = 100
    expect_false( identical(prevResponses, Responses ) )
})
test_that("swap() is working",{
    prevResponses = Responses
    
    individual = 1
    register(individual)
    target_index = 2
    register(target_index)
    question = getQuestionById(5)
    register(question)
    
    swap()
    expect_false(identical(prevResponses, Responses))
})