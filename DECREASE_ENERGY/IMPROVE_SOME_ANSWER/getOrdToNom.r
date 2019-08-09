source("getProbabilities.r", chdir = TRUE)
source("getRandomAnswer.r", chdir = TRUE)


getOrdToNom = function(responses, rows_selector, question_name, rule){
    initial_probs = getProbabilities(responses, rows_selector = rows_selector, col = question_name) 
    final_probs = initial_probs
    
    subrules = strsplit(rule, ";")[[1]]
    for (subrule in subrules) {
        print("Current subrule:")
        print(subrule)
        
        decomposed_rule = strsplit(subrule, "[+:=]+")
        print(decomposed_rule)
        decomposed_rule = as.double(decomposed_rule[[1]])
        print(decomposed_rule)
        c(lower_bound, factor_to_influence, additive) %<-% decomposed_rule
        
        final_probs[factor_to_influence] = final_probs[factor_to_influence] + additive
    }
    
    answer = getRandomAnswer(c(1:length(initial_probs)), final_probs)
    
    return(answer)
}