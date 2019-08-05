##############################
# Get target probabilities
##############################
getTargetProbabilities = function(responses){
    probs = list()
    maxLen = 0
    for (i in c(1:36)) {
        item = table(responses[,i])
        len = length(item)
        if (len > maxLen) {
            maxLen = len
        }
        probs[[i]] = item / n_individuals
        # probs[[i]] = item
    }
    
    for (i in c(1:36)) {
        item = table(responses[,i])
        len = length(item)
        item = c(item, rep(0, maxLen - len))
        probs[[i]] = item
    }
    return(probs)
}

