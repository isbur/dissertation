context("modify_settings_according_to_() function")


source("../setup_shorthand.r", chdir = TRUE)
source("../../IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)

individual = 1
register(individual)
# checkout(individual)
question_id = 4
question = getQuestionById(question_id)
register(question)
# checkout(question)
appropriateHandler = "getOrdNom"
register(appropriateHandler)
# checkout(appropriateHandler)
look_for_variables_influencing_on_answer()
checkout(variables_influencing_on_answer)
# checkout(filtered_M) & variables_influencing_on_answer
influencing_variable = sample(variables_influencing_on_answer, 1)
register(influencing_variable)
# checkout(influencing_variable)
n_options = length(table(Responses[,question]))
current_probs = rep(0, n_options)
current_probs[1] = 1
register(current_probs)

test_that("function changes probabilities vector somehow", {
    prev_current_probs = current_probs
    modify_settings_according_to_rules()
    expect_false(identical(prev_current_probs, current_probs))
})
