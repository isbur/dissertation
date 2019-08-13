source("./improveSomeAnswer_low.r", local = TRUE, chdir=TRUE)
source("./look_for_variables_influencing_on_answer.r", local = TRUE)#, chdir = TRUE)


change_answer_generation_settings = function () {
    
    get_default_settings()
    determine_rules()
    modify_settings_according_to_(rules)
    
}


generate_answer = function() {
    
}


improve_answer_to_ = function(question) {
    
    look_for_variables_influencing_on_answer()
    checkout(variables_influencing_on_answer)
    for (influencing_variable in variables_influencing_on_answer) {
        register(influencing_variable)
        change_answer_generation_settings()
    }
    
    generate_answer()
    
    
    # answer = getRandomAnswer(c(1:length(probs)), probs)
    
    # Swap with some existing answer
    
    # Check somewhere here whether proportions are not broken?
    
    return()
}