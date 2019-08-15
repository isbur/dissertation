context("Test the fourth question")


source("../../read_responses.r", chdir=TRUE)
setwd("../../")
Responses = read_responses()
assign("Responses", Responses, envir = .GlobalEnv)
#
source("./auxiliary/getQuestionById.r")
setwd("./tests/questionwise")


# Master_Registry is always created in .GlobalEnv, so
# here we are providing several ways to access _functions_ from "registar.r"
source("../../auxiliary/registar.r", chdir = TRUE)
source("../../meta/registar_provide_test_registry.r", chdir = TRUE)
# Registar = new.env()
# sys.source("../../meta/registar_provide_test_registry.r", envir = Registar, chdir = TRUE)
# print("Registar")
# print(ls(Registar))



source("../../IMPROVE_SOME_ANSWER/generateAnswer/general_procedure.r", chdir = TRUE)
# AnGen = new.env()
# sys.source("../../IMPROVE_SOME_ANSWER/generateAnswer/general_procedure.r", envir = AnGen, chdir = TRUE)
# attach(AnGen)
# print("Angen")
# print(ls(AnGen))


cat("\nCurrent environment:\n", ls(), "\n")


individual = 1
question_id = 4
question = getQuestionById(question_id)
answer = "tmp"

register(individual)
register(question)
register(answer)


test_that("Try via general_procedure()", {
    # 
    # general_procedure()
    # 
    # checkout(answer)
    # expect_true(answer %in% c(0:10) )
})


source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
test_that("Via improve_answer_to_()",{
    improve_answer_to_(question)
    
    checkout(answer)
    expect_true(answer %in% c(0:10) )
})
