if(!exists("source", inherits = FALSE)){
    source("./meta/custom_source.r")
}

source("./auxiliary/registar.r", chdir = TRUE)

source("./implementation/read_responses.r", chdir = TRUE)
source("./auxiliary/getQuestionById.r", chdir = TRUE)


Responses = read_responses()    # First letter is capitalized because Responses
                                # is an object in .GlobalEnv and I want to refer
                                # to this very object from inside every function;
                                # Passing this object with arguments has only specification
                                # purposes


source("./implementation/evaluate_energy.r")
source("./implementation/estimate_energy_drop.r")
source("./implementation/decide_whether_energy_has_stopped_decreasing_or_not.r")


source("./auxiliary/main_presets.r")


main = function(){
    while(energy_has_not_stopped_decreasing) {
        
        try_to_decrease_energy()
        new_energy = evaluate_energy(Responses) # well-isolated
        energies.append(new_energy) # well-isolated
        estimate_energy_drop(energies) # well-isolated
        decide_whether_energy_has_stopped_decreasing_or_not() # well-isolated
        checkout(energy_has_not_stopped_decreasing)
        
    }
}


library(sets)
library(zeallot)



source("./IMPROVE_SOME_ANSWER/improveSomeAnswer.r", chdir = TRUE, local = TRUE)
source("./common/constants.r")
register(QUESTION_TO_LEAVE)
source("./common/expected_corrs.r")
source("./implementation/try_to_decrease_energy.r", chdir = TRUE)


try_to_decrease_energy = function() {
    
    choose_some_individuals()
    improve_their_answers()
    markBaconed()
    
    return()
}


choose_some_individuals = function() {
    get_some_random_dude()
}


improve_their_answers = function() {
    checkout(Individuals_sample)
    for (individual in Individuals_sample) {
        improve_answers_of_the_(individual)
    }
    
}


# Test needed: "individual" cannot be excluded so easily
improve_answers_of_the_ <- function(individual) {
    
    register(individual)
    # improve the whole row calling improveSomeAnswer() function for each question
    #+ debug code
    count = 0
    #- debug code
    for (question in Set_of_questions) {
        #+ debug code
        checkout(QUESTION_TO_LEAVE)
        count = count + 1
        if( count < QUESTION_TO_LEAVE || QUESTION_TO_LEAVE < count){
            next
        }
        #- debug code
        print("Current question:")
        print(question)
        register(question)
        improve_answer_to_(question)
    }
    
    
    # Check somewhere here whether proportions are not broken?
    return()
}


improve_answer_to_ = function(question) {
    
    based_on = list(
        question_type = "",
        influencing_variables_types = "",
        expected_correlations_betweeen_them = ""
    )
    generate_answer_to_question()
    
    
    find_generated_answer_among_existing()
    swap()
    
}



