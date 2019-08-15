# persistent_source("../common/expected_corrs.r")
# 
# persistent_source("../auxiliary/mygrepl.r", chdir = TRUE)
# persistent_source("./handlers/getOrdNom.r")
# persistent_source("./handlers/getNomNom.r")
# persistent_source("./getters_from_data/chooseAppropriateHandler.r", chdir = TRUE)


source("../common/expected_corrs.r")

source("../auxiliary/mygrepl.r", chdir = TRUE)
source("./handlers/getOrdNom.r")
source("./handlers/getNomNom.r")
source("./getters_from_data/chooseAppropriateHandler.r", chdir = TRUE)


source("./generateAnswer/general_procedure.r", chdir = TRUE)


get_default_settings = function() {
    get_defaults() # from general procedure
}


# persistent_source("./determine_rules.r")
source("./determine_rules.r")


modify_settings_according_to_ = function(rules) {
    checkout(appropriateHandler)
    checkout(filtered_M)
    checkout(influencing_variable)
    checkout(individual)
    checkout(question)
    
    influencing_var = influencing_variable
    question_name = question
    
    # probs = getProbabilities()
    
    rule = filtered_M[ (filtered_M[,1]==influencing_var),3] #indeed, fuck determine_rules!
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
        
        probs = c(1,0,0,0)
        # probs = do.call(appropriateHandler, list(Responses[individual, question_name], probs, decomposed_rule)) # maybe will be needed c() -> list() *dcmpsdrule*
        probs = do.call(appropriateHandler, list(Responses[individual, question_name], probs, decomposed_rule))
    }
    
    # # Let each variable have equal influence on target variable
    # target_factor = filtered_M[1,2]
    # influence_amount = 1 / length(filtered_M[,1])
    # And now let's see how every variable is going to deal with their power
    
    # for(influencing_var in influencing_vars){
}



