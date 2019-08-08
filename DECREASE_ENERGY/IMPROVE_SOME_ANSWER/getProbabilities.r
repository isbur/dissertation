############################
# Get target probabilities #
############################
# Ideally needs to compare number of options in "options" and in "item"
getProbabilities = function(responses, options = NULL, rows_selector = rep(TRUE, length(responses[,1])), col = 1){
    probs = vector()
    n_individuals = length(rows_selector[rows_selector == TRUE])
    item = table(responses[rows_selector,col]) # counts every option
    probs = item / n_individuals
    
    return(probs)
}

