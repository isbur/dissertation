source("generate_answer_and_co__low.r")


general_procedure_of_answer_generation = function() {
    # create_local_storage() somewhere up here
    # select_individual() -//-
    checkout(individual)
    # choose_question() -//-
    checkout(question)
    get_or_set_defaults()
    look_for_dependencies()
    if (variable_is_dependent) {
        modify_probabilities_according_to_rules()
    }
    generate_answer()
    
}