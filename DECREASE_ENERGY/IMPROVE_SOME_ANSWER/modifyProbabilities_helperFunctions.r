library(zeallot)


From_Ordered_To_Ordered = function(probs, rule){
    # Pick nearest
    # Swap
    return(probs)
}


From_Continuous_To_Continuous = function(rule){
    
}


From_Ordinal_To_Factorial = function(probs, rule){
    decomposed_rule = strsplit(rule, "[+:=]+")
    print(decomposed_rule)
    decomposed_rule = as.double(decomposed_rule[[1]])
    print(decomposed_rule)
    c(lower_bound, factor_to_influence, additive) %<-% decomposed_rule
    
    # Find source factor in table
    answer_selector = mygrepl(factor, names(answer))
    if (answer[1,answer_selector] >= lower_bound){
        probs[factor_to_influence] = probs[factor_to_influence] + additive
    }
    return(probs)
}