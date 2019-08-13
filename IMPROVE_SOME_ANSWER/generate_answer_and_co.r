general_procedure_of_answer_generation = function() {
    create_local_storage() # somewhere up here
    select_individual() # -//-
    choose_question()
    set_or_get_defaults()
    look_for_dependencies()
    modify_probabilities_according_to_rules()
    generate_answer()
    
}