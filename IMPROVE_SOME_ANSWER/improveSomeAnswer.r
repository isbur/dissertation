source("improveSomeAnswer_low.r")
source("getRandomAnswer.r")
source("look_for_variables_influencing_on_answer.r")


improve_answer_to_ = function(question) {
    
    # get_default_settings() # OK (maybe some tests are needed cause call branch is rather long)
    look_for_variables_influencing_on_answer() # super!
    
    variable_to_generate = question
    register(variable_to_generate)
    general_answer_generator()
    
    # Maybe I ought to migrate this chunk of code to GAG
    # Swap with some existing answer
    choose_target_to_swap()
    swap()

    
    return()
}


general_answer_generator = function () {
    checkout(variable_to_generate)
    type_of_variable_to_generate = getVariableType(variable_to_generate)
    # I see... It also msut depend on rule type, i.e. there are at lesat 6 possibly totally different generators
    if (type_of_variable_to_generate == "continuous") {
        continual_generator()
    } else if (type_of_variable_to_generate == "categorical") {
        categorical_generator()
    }
}


categorical_generator = function(){
    checkout(variables_influencing_on_answer)


    for (influencing_variable in variables_influencing_on_answer) {
        register(influencing_variable)
        change_answer_generation_settings() # OK
    }
    generateCatAnswer()
}


generateCatAnswer = function() {
    checkout(final_probs)
    probs = final_probs
    answer = getRandomAnswer(c(0:(length(probs) - 1)), probs)
    register(answer)
}


# Should findNearestAnswer appear already here?


choose_target_to_swap = function(){
    checkout(individual)
    checkout(question)
    checkout(answer)
    checkout(MemberImember)
    
    numbers = c(1:length(Responses[,1]))
    A = MemberImember == FALSE
    # B = Responses[,question] == answer
    C = numbers != individual
    # selector = A & B & C
    selector = A & C
    
    target_index = findRandomNearestAnswer(answer, Responses[selector, question])
    register(target_index)
}


swap  = function() {
    checkout(individual)
    checkout(question)
    checkout(target_index)
    
    Responses = get("Responses")
    # I'm afraid it happens only locally;
    # Implemented get-assign workasround
    # Also see here: 
    # https://r-forge.r-project.org/scm/viewvc.php/pkg/R/swap.R?view=markup&revision=1620&root=seqinr
    seqinr::swap(Responses[individual, question], Responses[target_index, question])
    assign("Responses", Responses, envir = globalenv())
    
}