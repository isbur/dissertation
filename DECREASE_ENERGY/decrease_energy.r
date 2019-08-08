#library(seqinr) # just to use swap function!!!!111
library(zeallot)


source("./IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
source("../common/constants.r", chdir = TRUE)


decrease_energy_by_quant <- function(responses, memberImember, expected_corrs_matrix) {
    # id = getRandomIndividual(responses)
    id = 1
    
    # choose some question_name
    question_name = names(responses)[1]
    
    # improve a row calling improveSomeAnswer() function for each question
    improveSomeAnswer(responses, question_name, id, expected_corrs_matrix)
    
    # memberImember[i] = TRUE
    # Check somewhere here whether proportions are not broken
    return(list(responses, memberImember))
}


# returns two list-like objects
decrease_energy = function(responses, memberImember, expected_corrs_matrix) {
    for (number in 1:NUMBER_OF_ENERGY_QUANTS_TO_DECREASE) {
        c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember, expected_corrs_matrix)
    }
    return(list(responses, memberImember))
}