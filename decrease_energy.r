#library(seqinr) # just to use swap function!!!!111
library(zeallot)


improveTheIndividual = function(responses, id, expected_corrs_matrix) {
    
    answer = responses[id,]
    # dumb outupt for testing purposes
    # answer = sample(0:5, length(answer), replace = TRUE)
    
    count = 0
    for (question_name in names(responses)) {
        
        count = count + 1
        # Ignore first three question - these are totally independent values
        if(count <= 4) {
            # print("variable is independent; no modification needed")
            next
        }
        # for testing purposes
        if (count >= 6) {
            break
        }
        print(question_name)
        
        rows_selector = responses[,2]==responses[id,2] #### We need to save picture per nation ####
        initial_probs = getProbabilities(responses, rows_selector = rows_selector, cols = question_name) # See probs.r
        
        final_probs = modifyProbabilities(question_name, initial_probs, expected_corrs_matrix)
        
        old_answer = answer[question_name]
        answer[question_name] = getRandomAnswer(c(1:length(initial_probs)), final_probs)

        # Swap with some existing answer
    }
    return(answer)
}


decrease_energy_by_quant <- function(responses, memberImember, expected_corrs_matrix) {
    id = getRandomIndividual(responses)
    rowToInsert = improveTheIndividual(responses, id, expected_corrs_matrix)
    responses[i,] = rowToInsert
    memberImember[i] = TRUE
    # Check somewhere here whether proportions are not broken
    return(list(responses, memberImember))
}


# returns two list-like objects
decrease_energy = function(responses, memberImember, expected_corrs_matrix) {
    for (number in 1:NUMBER_OF_PERMUTATIONS) {
        c(responses, memberImember) %<-% decrease_energy_by_quant(responses, memberImember, expected_corrs_matrix)
    }
    return(list(responses, memberImember))
}