context("Test the fourth question")

source("../setup_cleanup.r", chdir = TRUE)
cleanup()
source("../setup_readResponses.r", chdir = TRUE)
source("../setup_testRegistry.r", chdir = TRUE)
# source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
source("../../auxiliary/getQuestionById.r", chdir = TRUE)

source("../../IMPROVE_SOME_ANSWER/generateAnswer/general_procedure.r", chdir = TRUE)


# cat("\nCurrent environment:\n", ls(), "\n")
#

individual = 1
question_id = 4
question = getQuestionById(question_id)
answer = "tmp"

register(individual)
register(question)
register(answer)


test_that("Try via general_procedure()", {

    general_procedure()

    checkout(answer)
    expect_true(answer %in% c(0:10) )
})


# source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
# test_that("Via improve_answer_to_()",{
#     improve_answer_to_(question)
#     
#     checkout(answer)
#     expect_true(answer %in% c(0:10) )
# })
