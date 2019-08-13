source("../../common/variable_types.r")


getVariableType = function(question_name){
    M = variable_types_matrix
    return(M[M[,1]==question_name,2])
}