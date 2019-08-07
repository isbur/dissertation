##############################
# Get target probabilities
##############################
getProbabilities = function(responses, rows_selector = rep(TRUE, length(responses[,1])), cols = 1:length(responses)){
    probs = vector()
    n_individuals = length(rows_selector[rows_selector == TRUE])
    # maxLen = 0
    for (i in cols) {
        item = table(responses[rows_selector,i])
        # len = length(item)
        # if (len > maxLen) {
        #     # maxLen = len
        # }
        probs[i] = item / n_individuals
    }
    
    # Was necessary for the previous way of data generation
    # for (i in cols) {
    #     item = table(responses[,i])
    #     len = length(item)
    #     item = c(item, rep(0, maxLen - len))
    #     probs[[i]] = item
    # }
    return(probs)
}

