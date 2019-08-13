library(sets)
library(zeallot)


source("./auxiliary/registar.r")
source("./IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE, local = TRUE)
source("./common/constants.r")
source("./common/expected_corrs.r")


# Test needed: "individual" cannot be excluded so easily
improve_answers_of_the_ <- function(individual) {
    
    register(individual)
    # improve the whole row calling improveSomeAnswer() function for each question
    # #+ debug code
    # count = 0
    # #- debug code
    for (question in Set_of_questions) {
        # #+ debug code
        # QUESTION_TO_LEAVE = 4
        # count = count + 1
        # if( count < QUESTION_TO_LEAVE || QUESTION_TO_LEAVE < count){
        #     next
        # }
        # #- debug code
        print("Current question:")
        print(question)
        register(question)
        improve_answer_to_(question)
    }
    
    # memberImember[id] = TRUE
    
    # Check somewhere here whether proportions are not broken?
    return()
}


improve_their_answers = function() {
    for (individual in Individuals_sample) {
        improve_answers_of_the_(individual)
    }
}


get_some_random_dude = function(){
    n = length(Responses[,1]) # get length of e.g. first row
    dude = sample(1:n[!MemberImember], 1)
    assign("Individuals_sample", dude, envir = .GlobalEnv)
}


choose_some_individuals = function(Responses) {
    get_some_random_dude()
}


try_to_decrease_energy = function(Responses) {
    
    choose_some_individuals(Responses)
    improve_their_answers()

    return()
}