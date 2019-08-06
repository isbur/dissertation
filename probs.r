##############################
# Get target probabilities
##############################
getTargetProbabilities = function(responses, cols = 1:length(responses)){
    probs = list()
    maxLen = 0
    for (i in cols) {
        item = table(responses[,i])
        len = length(item)
        if (len > maxLen) {
            maxLen = len
        }
        probs[[i]] = item / n_individuals
        # probs[[i]] = item
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

