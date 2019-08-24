context("generate_answer() function")


source("../setup_shorthand.r", chdir = TRUE)
source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)


test_that("categorical answer is generated properly based on given probabilities", {
    final_probs = c(1,0,0,0)
    register(final_probs)
    generateCatAnswer()
    checkout(answer)
    expect_equal(answer, 0)
})