source("../common/expected_corrs.r")


source("../auxiliary/mygrepl.r", chdir = TRUE)


look_for_variables_influencing_on_answer = function(){
#### and provide filtered_M matrix for next functions ####
    
    checkout(question)
    question_name = question
    
    
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
    
    variables_influencing_on_answer = influencing_vars
    register(variables_influencing_on_answer)
    register(filtered_M)
}