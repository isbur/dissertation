getNomCont = function(defining_answer, probs, decomposed_rule) {
    if(length(probs) != length(decomposed_rule)) {
        stop("length(probs) != length(decomposed_rule)")
    }
    decomposed_rule = decomposed_rule / norm(decomposed_rule, type = "2")
    final_probs = probs + decomposed_rule
    final_probs = final_probs / norm(final_probs, type = "2")
    return(final_probs)
}