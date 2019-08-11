#library(seqinr) # just to use swap function!!!!111
library(zeallot)


source("./DECREASE_ENERGY/IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
source("./common/constants.r")
source("./common/expected_corrs.r")
source("main_presets.r") # definition of memberImember


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


try_to_decrease_energy = function(responses) {
    for (number in 1:NUMBER_OF_ENERGY_QUANTS_TO_DECREASE) {
        c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember, expected_corrs_matrix)
    }
    assign("responses", responses, envir = .GlobalEnv)
    assign("memberImember", memberImember, envir = .GlobalEnv)
}