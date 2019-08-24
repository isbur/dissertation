context("Tests focused from \"try_to_decrease_energy.r\" to generate single answer scripts")


source("../setup_shorthand.r", chdir = TRUE)
MemberImember = rep(FALSE, length(Responses[,1]))
register(MemberImember)


source("../../main.r", chdir = TRUE)
QUESTION_TO_LEAVE = 4
register(QUESTION_TO_LEAVE)
test_that("try_to_decrease_energy() produces any effect",{
    prev_Responses = Responses
    try_to_decrease_energy()
    expect_false(identical(prev_Responses, Responses))
})


QUESTION_TO_LEAVE = 5
register(QUESTION_TO_LEAVE)
test_that("try_to_decrease_energy() produces any effect",{
    prev_Responses = Responses
    try_to_decrease_energy()
    expect_false(identical(prev_Responses, Responses))
})