# persistent_source("low_level.r", local = TRUE)
# persistent_source("low_level.r")
source("low_level.r")
source("low_level.r", local = TRUE)###


general_procedure = function() {
    # create_local_storage() somewhere up here
    # select_individual() -//-
    checkout(individual)
    # choose_question() -//-
    # print("Inside general_procedure()")
    # print(ls())
    # print(getAnywhere("checkout"))
    checkout(question) # "variable_name" is semantically more appropriate
    get_or_set_defaults()
    look_for_dependencies()
    # if (variable_is_dependent) {
    #     modify_probabilities_according_to_rules()
    # }
    generate_answer()
    answer = 1
    register(answer)
}