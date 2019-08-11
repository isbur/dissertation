getOrdNom = function(decisive_answer, initial_probs, decomposed_rule){
    
    final_probs = initial_probs
    
    c(lower_bound, factor_to_influence, additive) %<-% decomposed_rule
    
    if (decisive_answer >= lower_bound) {
        final_probs[factor_to_influence] = final_probs[factor_to_influence] + additive
    }
    
    return (final_probs)
}