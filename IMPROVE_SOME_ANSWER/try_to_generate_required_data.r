source("try_to_generate_required_data__low.r")


# must be similar to "improve_answer_to" function
try_to_generate_required_data = function() {
    checkout(influencing_variable)
    influenced_variable <- influencing_variable
    
    set_default_rules()
    add_additional_rules()
    
    checkout(variables_influencing_on_answer)
    for (influencing_variable in variables_influencing_on_answer) {
         register(influencing_variable)
         change_answer_generation_settings()
    }
    
    generate_answer()
}