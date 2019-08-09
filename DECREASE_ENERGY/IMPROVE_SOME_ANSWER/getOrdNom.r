source("getProbabilities.r", chdir = TRUE)
source("getRandomAnswer.r", chdir = TRUE)


getOrdNom = function(initial_probs, question_name, decomposed_rule){
    
    final_probs = initial_probs
    
    c(lower_bound, factor_to_influence, additive) %<-% decomposed_rule
    
    final_probs[factor_to_influence] = final_probs[factor_to_influence] + additive
    
    answer = getRandomAnswer(c(1:length(initial_probs)), final_probs)
    
    return(answer)
}