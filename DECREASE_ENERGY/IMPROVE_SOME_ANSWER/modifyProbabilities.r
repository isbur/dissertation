library(zeallot)


source("mygrepl.r")
source("modifyProbabilities_helperFunctions.r")


NUMBER_OF_PERMUTATIONS = 1


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
    for (factor in filtered_M[,1]){
        rule = M[ (M[,1]==factor & M[,2] == target_factor),3]
        print("RULE:")
        print(rule)
        if (rule == ""){
            print("Everything is perfect!")
            next
        }
        if (rule == "+" || rule == "-"){
            final_probs = From_Ordered_To_Ordered(initial_probs, rule)
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
                
                final_probs = From_Ordinal_To_Factorial(initial_probs, subrule)
                next
            }
        }
    }
    
    final_probs = final_probs / norm(final_probs, type = "2")
    return(final_probs)
}