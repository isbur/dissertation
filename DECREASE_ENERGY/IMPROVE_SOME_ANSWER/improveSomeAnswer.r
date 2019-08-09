source("./mygrepl.r", chdir = TRUE)
source("./getVariableType.r", chdir = TRUE)
source("./getOrdNom.r", chdir = TRUE)


chooseAppropriateHandler(influencing_var_name, influenced_var_name){
    
    influencing_var_type = getVariableType(influencing_var_name)
    influenced_var_type = getVariableType(influenced_var_name)
    
    appropriateHandler = "UnknownHandler"
    if ( (influencing_var_type == "ordinal") && (influenced_var_type == "nominal") ){
        
        appropriateHandler = "getOrdNom"
        
    # } else if ( (influencing_var_type == "nominal") && (influenced_var_type == "nominal") ){
    #     
    #     appropriateHandler = "getNomNom"
    #     
    # }
    # } else if (variableType == "continuous") {
    #     # Pick question for exchange
    #     # Do it
    }else {
        print("WARNING!!! Couldn't find an appropriate handler")
    }
}


improveSomeAnswer = function(responses, question_name, id, expected_corrs_matrix) {
    
    # Determine source factors
    # whether variable is independent or not will be seen based on this information
    M = expected_corrs_matrix
    filtered_M = M[mygrepl(question_name, M[,2]),]
    if(!is.matrix(filtered_M)){
        filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
    }
    influencing_vars = filtered_M[,1]
    print("From expected_corrs_matrix we have:")
    print(filtered_M)
    
    
    #### We need to save picture per nation ####
    rows_selector = (responses[,2]==responses[id,2]) 
    
    
    # Since (almost) every variable is of categorical type...
    initial_probs = getProbabilities(responses, rows_selector = rows_selector, col = question_name) 
    
    
    # # Let each variable have equal influence on target variable
    # target_factor = filtered_M[1,2]
    # influence_amount = 1 / length(filtered_M[,1])
    # And now let's see how every variable is going to deal with their power
    for(influencing_var in influencing_vars){

        influencing_var_name = names(responses)[mygrepl(source_var, names(responses))]
        
        appropriateHandler = chooseAppropriateHandler(influencing_var_name, question_name)
        
        rule = filtered_M[ (filtered_M[,1]==source_var),3]
        print("RULE:")
        print(rule)
        
        if (rule == "") {
            next
        }
        
        subrules = strsplit(rule, ";")[[1]]
        for (subrule in subrules) {
            print("Current subrule:")
            print(subrule)
            
            decomposed_rule = strsplit(subrule, "[+:=]+")
            print(decomposed_rule)
            decomposed_rule = as.double(decomposed_rule[[1]])
            print(decomposed_rule)
            
            do.call(appropriateHandler, decomposed_rule) # maybe will be needed c() -> list() *dcmpsdrule*
        }
        
    }
    
    
    
    # Swap with some existing answer
    
    # Or check somewhere here whether proportions are not broken?
    
    return(responses)
}