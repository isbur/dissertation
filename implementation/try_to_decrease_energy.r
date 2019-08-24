get_some_random_dude = function(){
    checkout(MemberImember)
    n = length(Responses[,1]) # get length of e.g. first row
    dude = sample(c(1:n)[!MemberImember], 1)
    Individuals_sample = dude
    register(Individuals_sample)
}


markBaconed = function(){
    checkout(Individuals_sample)
    numbers = c(1:length(Responses[,1]))
    selector = numbers %in% Individuals_sample
    
    checkout(MemberImember)
    MemberImember[selector] = TRUE
    
    register(MemberImember)
}


source("../auxiliary/mygrepl.r", chdir = TRUE)


improve_answer_to_ = function(question) {
    
    # get_default_settings() # OK (maybe some tests are needed cause call branch is rather long)
    look_for_variables_influencing_on_answer() # super!
    
    # variable_to_generate = question
    # register(variable_to_generate)
    
    determine_question_type()
    determine_generation_rule_view()
    
    checkout(influencing_variables)
    for (influencing_variable in influencing_variables){
        call_appropriate_rule_modifier() # depends both on rule_view and on influencing_var type
    }
    
    generate_answer()
    
    # Maybe I ought to migrate this chunk of code to GAG
    # Swap with some existing answer
    choose_target_to_swap()
    swap()
    
    
    return()
}


look_for_variables_influencing_on_answer = function(){
    #### and provide filtered_M matrix for next functions ####
    
    checkout(question)
    question_name = question
    
    
    # Determine source factors
    # whether variable is independent or not will be seen based on this information
    M = expected_corrs_matrix
    filtered_M = M[mygrepl(question_name, M[,2]),]
    if(!is.matrix(filtered_M)){
        filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
    }
    
    
    influencing_vars = filtered_M[,1]
    print("From expected_corrs_matrix we have:")
    print(filtered_M)
    
    variables_influencing_on_answer = influencing_vars
    register(variables_influencing_on_answer)
    register(filtered_M)
}


choose_appropriate_answer_generator = function(){
    checkout(variable_to_generate)
    type_of_variable_to_generate = getVariableType(variable_to_generate)
    # I see... It also msut depend on rule type, i.e. there are at lesat 6 possibly totally different generators
    if (type_of_variable_to_generate == "continuous") {
        continual_generator()
    } else if (type_of_variable_to_generate == "categorical") {
        categorical_generator()
    }
}


source("generators.r")


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