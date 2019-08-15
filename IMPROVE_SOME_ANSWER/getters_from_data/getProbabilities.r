############################
# Get target probabilities #
############################
# Ideally needs to compare number of options in "options" and in "item"
getProbabilities = function(){
    checkout(rows_selector)
    checkout(question)
    
    probs = vector()
    n_individuals = length(rows_selector[rows_selector == TRUE])
    item = table(Responses[rows_selector,question]) # counts every option
    default_probs = item / n_individuals
    register(default_probs)
}

