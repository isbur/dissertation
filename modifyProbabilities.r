NUMBER_OF_PERMUTATIONS = 1


getRandomAnswer = function(options, prob = NULL) {
    n = sample(options, 1, prob = prob)
    return(n)
}


# Shorthand for agrepl() in current task
mygrepl = function(pattern, x){
    
    #########################################
    # Some experiments with mertic function #
    #########################################
    # distances = list (
    #     cost = 10,
    #     deletions = 10,
    #     insertions = 2,
    #     substitutions = 2
    # )
    
    return(agrepl(pattern, x, max = 5, ignore.case = TRUE))
}


modifyProbabilities = function(question_name, initial_probs, expected_corrs_matrix){
    M = expected_corrs_matrix
    # get infromation about the type of generated data
    filtered_M = M[mygrepl(question_name, M[,2]),]
    if(!is.matrix(filtered_M)){
        filtered_M = matrix(filtered_M, ncol = 3, byrow = TRUE)
    }
    print(filtered_M)
    
    # Let each variable have equal influence on target variable
    target_factor = filtered_M[1,2]
    influence_amount = 1 / length(filtered_M[,1])
    # And now let's see how every variable is going to deal with their power
    final_probs = initial_probs
    for (factor in filtered_M[,1]){
        rule = M[ (M[,1]==factor & M[,2] == target_factor),3]
        print("RULE:")
        print(rule)
        if (rule == ""){
            next
        }
        if (rule == "+" || rule == "-"){
            next
        }
        subrules = strsplit(rule, ";")[[1]]
        print("Subrules:")
        print(subrules)
        for (subrule in subrules) {
            print("Current subrule:")
            print(subrule)
            if (grepl("+", subrule, fixed = TRUE)){
                print("It seems like source factor is ordinal data...")
                
                decomposed_rule = strsplit(subrule, "[+:=]+")
                print(decomposed_rule)
                decomposed_rule = as.double(decomposed_rule[[1]])
                print(decomposed_rule)
                c(lower_bound, factor_to_influence, additive) %<-% decomposed_rule
                
                # Find source factor in table
                answer_selector = mygrepl(factor, names(answer))
                if (answer[1,answer_selector] >= lower_bound){
                    final_probs[factor_to_influence] = final_probs[factor_to_influence] + additive
                }
                
                final_probs = final_probs / norm(final_probs, type = "2")
            }
        }
    }
    
    return(final_probs)
}