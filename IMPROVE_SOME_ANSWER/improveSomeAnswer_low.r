source("../common/expected_corrs.r")

source("../auxiliary/mygrepl.r", chdir = TRUE)
source("./handlers/getOrdNom.r")
source("./handlers/getNomNom.r")
source("./handlers/getNomCont.r")
source("./getters_from_data/chooseAppropriateHandler.r", chdir = TRUE)


source("./generateAnswer/general_procedure.r", chdir = TRUE)


get_default_settings = function() {
    get_defaults() # from general procedure
}


change_answer_generation_settings = function(){
    
    check_whether_influencing_variable_is_latent()
    

    checkout(influencing_var_name)
    checkout(question)
    appropriateHandler = chooseAppropriateHandler(influencing_var_name, question)
    # cat("Current influencing_var_name:\t",influencing_var_name,"\nCurrent influenced_var_name:\t",question_name,"\n")
    
    register(appropriateHandler)
    
    
    modify_settings_according_to_rules()
    
}



modify_settings_according_to_rules = function() {
    checkout(appropriateHandler)
    checkout(filtered_M)
    checkout(influencing_variable)
    checkout(individual)
    checkout(question)
    
    influencing_var = influencing_variable
    question_name = question
    
    checkout(current_probs) 

    
    rule = filtered_M[ (filtered_M[,1]==influencing_var),3] 
    print("RULE:")
    print(rule)
    
    if (rule == "") {
        return()
    }
    
    subrules = strsplit(rule, ";")[[1]]
    for (subrule in subrules) {
        print("Current subrule:")
        print(subrule)
        
        decomposed_rule = strsplit(subrule, "[+:=]+")
        print(decomposed_rule)
        decomposed_rule = as.double(decomposed_rule[[1]])
        print(decomposed_rule)
        
        # probs = c(1,0,0,0)
        # probs = do.call(appropriateHandler, list(Responses[individual, question_name], probs, decomposed_rule)) # maybe will be needed c() -> list() *dcmpsdrule*
        current_probs = do.call(appropriateHandler, list(Responses[individual, question_name], current_probs, decomposed_rule))
    }
    
    
    register(current_probs)
    
    
    # # Let each variable have equal influence on target variable
    # target_factor = filtered_M[1,2]
    # influence_amount = 1 / length(filtered_M[,1])
    # And now let's see how every variable is going to deal with their power
    
    # for(influencing_var in influencing_vars){
}


source("try_to_generate_required_data.r")


check_whether_influencing_variable_is_latent = function(){
    checkout(influencing_variable)
    checkout(question)
    influencing_var = influencing_variable
    question_name = question
    
    data_is_needed_to_be_generated = FALSE
    var_selector = tryCatch({mygrepl(influencing_var, names(Responses))},
                            error = function(e){
                                print(e) 
                                data_is_needed_to_be_generated = TRUE
                            })
    register(data_is_needed_to_be_generated) # for debugging purposes
    # if (data_is_needed_to_be_generated) {
    #     try_to_generate_required_data()
    #     checkout(Full_set_of_var_names)
    #     mygrepl(influencing_var, Full_set_of_var_names)
    #     warning("More data was generated")
    # } 
    
    
    # There is a certain error
    # all vars inside IVN:
    influencing_var_name = names(Responses)[var_selector]
    checkout(influencing_var_name)
}

