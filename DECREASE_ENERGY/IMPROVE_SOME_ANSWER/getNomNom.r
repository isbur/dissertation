getNomNom = function(decisive_answer, probs, decomposed_rule){
    
    c(source_factor, factor_to_influence, additive) %<-% decomposed_rule
    
    if (decisive_answer == source_factor) {
        probs[factor_to_influence] = probs[factor_to_influence] + additive
    }
    
    return (probs)
}