source("getProbabilities.r", chdir = TRUE)
source("modifyProbabilities.r", chdir = TRUE)
source("getRandomAnswer.r", chdir = TRUE)


getCatCat = function(responses, rows_selector, question_name){
    initial_probs = getProbabilities(responses, rows_selector = rows_selector, col = question_name) 
    
    final_probs = modifyProbabilities(question_name, initial_probs, expected_corrs_matrix)
    
    answer = getRandomAnswer(c(1:length(initial_probs)), final_probs)
    
    return(answer)
}