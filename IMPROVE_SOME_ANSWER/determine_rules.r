source("try_to_generate_required_data.r")


determine_rules = function(){
    checkout(influencing_variable)
    checkout(question)
    influencing_var = influencing_variable
    question_name = question
    
    var_selector = mygrepl(influencing_var, names(Responses))
    if (var_selector == "More data is needed to be generated") {
        try_to_generate_required_data()
        warning("More data is needed to be generated")
    } else {
        influencing_var_name = names(Responses)[var_selector]
    }
    cat("Current influencing_var_name:\t",influencing_var_name,"\nCurrent influenced_var_name:\t",question_name,"\n")
    
    appropriateHandler = chooseAppropriateHandler(influencing_var_name, question_name)
    register(appropriateHandler)
    
}