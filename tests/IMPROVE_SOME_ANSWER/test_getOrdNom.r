context("test handlers")


source("../setup_shorthand.r", chdir = TRUE)
source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE) # all handlers are among others sourced here


# getOrdNom
decisive_answer = 3
initial_probs = c(0,0,0,0,0)
decomposed_rule = c(1,2,1)
test_that("getOrdNom() works properly",{
    final_probs = getOrdNom(decisive_answer, initial_probs, decomposed_rule)
    expect_equal(final_probs, c(0,1,0,0,0))
})


#getNomNom
source_answer = 3
initial_probs = c(0,0,0,0,0)
decomposed_rule = c(3,4,1)
test_that("getNomNom() works properly",{
    final_probs = getNomNom(source_answer, initial_probs, decomposed_rule)
    expect_equal(final_probs, c(0,0,0,1,0))
})


#getNomCont
source_answer = 2
initial_probs = c(0,0,0)
decomposed_rule = c(0,1,0)
test_that("getNomNom() works properly",{
    final_probs = getNomCont(defining_answer, initial_probs, decomposed_rule)
    expect_equal(final_probs, c(0,1,0))
})