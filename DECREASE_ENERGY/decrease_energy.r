#library(seqinr) # just to use swap function!!!!111
library(zeallot)


source("./IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
source("../common/constants.r")


decrease_energy_by_quant <- function(responses, memberImember, expected_corrs_matrix) {
    
    id = sample(1:length(responses[,1]), 1)
    print("Chosen id:")
    print(id)
    # Better to reduce sample vector only to those number for which memeberImember[id] == TRUE
    if(memberImember[id] == TRUE) {
        return(list(responses, memberImember)) # as is
    }
    
    # improve the whole row calling improveSomeAnswer() function for each question
    count = 0
    for (question_name in names(responses)) {
        ANSWER_TO_EXCLUDE = 5
        count = count + 1
        if( count < ANSWER_TO_EXCLUDE || ANSWER_TO_EXCLUDE < count){
            next
        }
        print("Current question:")
        print(question_name)
        improveSomeAnswer(responses, question_name, id, expected_corrs_matrix)
    }
    
    memberImember[id] = TRUE
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