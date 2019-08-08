source("./mygrepl.r", chdir = TRUE)
source("./determineVariableType.r", chdir = TRUE)
source("./getCatCat.r", chdir = TRUE)


improveSomeAnswer = function(responses, question_name, id, expected_corrs_matrix) {
    
    # Determine source factors
    # whether variable is independent or not will be seen based on this information
    M = expected_corrs_matrix
    filtered_M = M[mygrepl(question_name, M[,2]),]
    if(!is.matrix(filtered_M)){
        filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
    }
    source_factors = filtered_M[,1]
    print(filtered_M)
    
    
    #### We need to save picture per nation ####
    rows_selector = (responses[,2]==responses[id,2]) 
    
    
    # determine whether factor or not
    variableType = determineVariableType(responses[question_name])
    
    
    for(source_factor in source_factors){
        source_factor_type = determineVariableType(responses[question_name])
        if ( (source_factor_type == "categorical") && (variableType == "categorical") ){
            
            getCatCat(responses, rows_selector, question_name)

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