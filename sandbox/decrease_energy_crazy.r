library(seqinr) # just to use swap function!!!!111
library(zeallot)

NUMBER_OF_PERMUTATIONS = 5000


# returns named list of for integers
getIndices = function(responses){
    n_individuals = length(responses[,1])
    n_vars = length(responses[1,])
    i = sample(1:n_individuals,1)
    j = sample(1:n_vars,1)
    k = sample(1:n_individuals,1)
    l = j
    send = c(i,j,k,l)
    # print(send)
    return (send)
}


decrease_energy = function(responses) {
    for (number in 1:NUMBER_OF_PERMUTATIONS) {
        ret = getIndices(responses)
        # print(ret)
        c(i,j,k,l) %<-% getIndices(responses)
        swap(responses[i,j], responses[k,l])
    }
    return(responses)
}