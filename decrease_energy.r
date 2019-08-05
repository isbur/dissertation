#library(seqinr) # just to use swap function!!!!111
library(zeallot)


NUMBER_OF_PERMUTATIONS = 10


getRandomIndividual = function(responses) {
    n = sample(1:length(responses[,1]), 1)
    return(n)
}


improveTheIndividual = function(responses, id) {
    answer = responses[id,]
    answer = sample(0:5, length(answer), replace = TRUE)
    return(answer)
}


decrease_energy_by_quant <- function(responses, memberImember) {
    id = getRandomIndividual(responses)
    rowToInsert = improveTheIndividual(responses, id)
    responses[i,] = rowToInsert
    memberImember[i] = TRUE
    return(list(responses, memberImember))
}


# returns two list-like objects
decrease_energy = function(responses, memberImember) {
    for (number in 1:NUMBER_OF_PERMUTATIONS) {
        c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember)
    }
    return(list(responses, memberImember))
}