source("getVariableType.r", chdir = TRUE)


# Rewrite using mapping matrix)
chooseAppropriateHandler = function(influencing_var_name, influenced_var_name){
    
    influencing_var_type = getVariableType(influencing_var_name)
    influenced_var_type = getVariableType(influenced_var_name)
    
    appropriateHandler = "UnknownHandler"
    if ( (influencing_var_type == "ordinal") && (influenced_var_type == "nominal") ){
        
        appropriateHandler = "getOrdNom"
        
    } else if ( (influencing_var_type == "nominal") && (influenced_var_type == "nominal") ){
        
        appropriateHandler = "getNomNom"
        
    } else {
        print("WARNING!!! Couldn't find an appropriate handler")
    }
    
    
    # } else if (variableType == "continuous") {
    #     # Pick question for exchange
    #     # Do it
    
    
    return(appropriateHandler)
}


chooseAppropriateHandler2 = function(influencing_var_name, influenced_var_name){
    
    influencing_var_type = getVariableType(influencing_var_name)
    influenced_var_type = getVariableType(influenced_var_name)
    
    handlers_vector = c(
        "ordinal", "nominal", "getOrdNom",
        "nominal", "nominal", "getNomNom",
        "nominal", "continuous", "getNomCont",
        "ordinal", "ordinal", "getOrdOrd",
        "continuous", "ordinal", "getContOrd",
        "continuous", "continuous", "getContCont",
        "continuous", "nominal", "getContNom"
    )
    handlers_matrix = matrix(handlers_vector, ncol=3, byrow = TRUE)
    
    A = ( influencing_var_type==handlers_matrix[,1] )
    B = ( influenced_var_type==handlers_matrix[,2] )
    handlers_selector = A & B
    appropriateHandler = handlers_matrix[handlers_selector,3]
    
    # {
    #     print("WARNING!!! Couldn't find an appropriate handler")
    # }
    
    
    return(appropriateHandler)
}