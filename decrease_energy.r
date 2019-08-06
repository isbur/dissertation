#library(seqinr) # just to use swap function!!!!111
library(zeallot)


NUMBER_OF_PERMUTATIONS = 1


getRandomIndividual = function(responses) {
    n = sample(1:length(responses[,1]), 1)
    return(n)
}


########################################
# IMO MOST COMPLEX FUNCTION IS HERE!!! #
########################################
improveTheIndividual = function(responses, id, expected_corrs_matrix) {
    M = expected_corrs_matrix
    answer = responses[id,]
    # dumb outupt for testing purposes
    # answer = sample(0:5, length(answer), replace = TRUE)
    
    count = 0
    for (question_name in names(responses)) {
        print(question_name)
        count = count + 1
        # Ignore first three question - these are totally independent values
        if(count <= 3) {
            print("variable is independent; no modification needed")
            next
        }
        # get infromation about the type of generated data -> not here
        #res = agrep(question_name, M[,2], ignore.case = TRUE, value = TRUE)
        distances = list (
                          cost = 10,
                          deletions = 10,
                          insertions = 2,
                          substitutions = 2
                          )
        #res = M[agrepl(question_name, M[,2], max = distances, ignore.case = TRUE),1]
        filtered_M = M[agrepl(question_name, M[,2], max = 5, ignore.case = TRUE),]
        if(!is.matrix(filtered_M)){
            filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
        }
        print(filtered_M)
        probs = getTargetProbabilities(responses, question_name) # See probs.r
        # print(probs)
        # Let each variable have equal influence on target variable
        influence_amount = 1 / length(filtered_M[,1])
        # And now let's see how every variable is going to deal with their power
        for (row in filtered_M){
            rule = row[3]
            print(rule)
        }
        # get expected corrs information -> not here
        # just do it
    }
    return(answer)
}


decrease_energy_by_quant <- function(responses, memberImember, expected_corrs_matrix) {
    id = getRandomIndividual(responses)
    rowToInsert = improveTheIndividual(responses, id, expected_corrs_matrix)
    responses[i,] = rowToInsert
    memberImember[i] = TRUE
    return(list(responses, memberImember))
}


# returns two list-like objects
decrease_energy = function(responses, memberImember, expected_corrs_matrix) {
    for (number in 1:NUMBER_OF_PERMUTATIONS) {
        c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember, expected_corrs_matrix)
    }
    return(list(responses, memberImember))
}