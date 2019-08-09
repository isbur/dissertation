source("./mygrepl.r", chdir = TRUE)
source("./getVariableType.r", chdir = TRUE)
source("./getOrdToNom.r", chdir = TRUE)


improveSomeAnswer = function(responses, question_name, id, expected_corrs_matrix) {
    
    # Determine source factors
    # whether variable is independent or not will be seen based on this information
    M = expected_corrs_matrix
    filtered_M = M[mygrepl(question_name, M[,2]),]
    if(!is.matrix(filtered_M)){
        filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
    }
    source_vars = filtered_M[,1]
    print("From expected_corrs_matrix we have:")
    print(filtered_M)
    
    
    #### We need to save picture per nation ####
    rows_selector = (responses[,2]==responses[id,2]) 
    
    
    variableType = getVariableType(question_name)
    print("Current variable type:")
    print(variableType)
    
    
    # # Let each variable have equal influence on target variable
    # target_factor = filtered_M[1,2]
    # influence_amount = 1 / length(filtered_M[,1])
    # And now let's see how every variable is going to deal with their power
    for(source_var in source_vars){
        print("Current source factor:")
        print(source_var)
        source_var_name = names(responses)[mygrepl(source_var, names(responses))]
        print(source_var_name)
        source_var_type = getVariableType(source_var_name)
        print("...of type:")
        print(source_var_type)
        if ( (source_var_type == "ordinal") && (variableType == "nominal") ){
            
            rule = filtered_M[ (filtered_M[,1]==source_var),3]
            print("RULE:")
            print(rule)
            getOrdToNom(responses, rows_selector, question_name, rule)

        } else if (variableType == "continuous") {
            # Pick question for exchange
            # Do it
        } else {
            print("I DON'T KNOW WHAT TO DO")
        }
    }
    
    
    
    # Swap with some existing answer
    
    # Or check somewhere here whether proportions are not broken?
    
    return(responses)
}