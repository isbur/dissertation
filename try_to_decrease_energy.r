library(sets)
library(zeallot)


source("./DECREASE_ENERGY/IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE)
source("./common/constants.r")
source("./common/expected_corrs.r")
source("main_presets.r") # definition of memberImember


improve_answers_of_the_ <- function(individual) {
    
    # improve the whole row calling improveSomeAnswer() function for each question
    #+ debug code
    count = 0
    #- debug code
    for (question in Set_of_questions) {
        #+ debug code
        QUESTION_TO_LEAVE = 5
        count = count + 1
        if( count < QUESTION_TO_LEAVE || QUESTION_TO_LEAVE < count){
            next
        }
        #- debug code
        print("Current question:")
        print(question)
        improve_answer_to_(question)
    }
    
    # memberImember[id] = TRUE
    
    # Check somewhere here whether proportions are not broken?
    return(list(responses, memberImember))
}


improve_their_answers = function() {
    for (individual in Individuals_sample) {
        improve_answers_of_the_(individual)
    }
}


get_some_random_dude = function(){
    n = length(Responses[,1]) # get length of e.g. first row
    dude = sample(1:n[!MemberImember])
    assign("Individuals_sample", dude, envir = .GlobalEnv)
}


choose_some_individuals = function(Responses) {
    get_some_random_dude()
}


try_to_decrease_energy = function(Responses) {
    
    choose_some_individuals(Responses)
    improve_their_answers()
    # for (number in 1:NUMBER_OF_ENERGY_QUANTS_TO_DECREASE) {
    #     c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember, expected_corrs_matrix)
    # }
    # assign("responses", responses, envir = .GlobalEnv)
    # assign("memberImember", memberImember, envir = .GlobalEnv)
    return(Responses)
}