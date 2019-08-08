###############################
# Prepare for data generation #
###############################


customSplit = function(x) {
    tmp = strsplit(x, "_", fixed = TRUE)
    return(tmp[[1]])
}


# Try not to send x of length less than 2
probsToString = function(x) {
    answer = x[1]
    for (i in c(2:length(x))) {
        answer = paste(answer, x[i], sep = ";")
    }
    return(answer)
}


makeBinaryFormula = function(x) {
    current_probability = x
    completion = 1 - current_probability
    final_vector = c(completion, current_probability)
    formula = probsToString(final_vector)
    return(formula)
}


stringToProbs = function(x) {
    target = strsplit(x, ";")
    target = target[[1]]
    target = as.double(target)
    #sum = 0
    #for (i in c(1:length(target))) {
    #    target[i] = round(target[i], digits = 2)
    #    sum = sum + target[i]
    #}
    #target[1] = target[1] + 1 - sum
    target = matrix(target, nrow = 1)
    return(target)
}


A = pureData8   # see corr.r
n_individuals = length(responses[,1]) # see test.r
n_questions = length(responses) # 1...36
n_variables = length(A) # 1...76


names = rownames(A)
dists = list()
corrected_dists = list()
formulas = list()
current_question = 0
religion_counter = 0
for (i in c(1:n_variables)) {
    name = names[i]
    name.split = customSplit(name)
    
    # prevent out of range
    if (i > 1) {
        name_prev.split = customSplit(names[i-1])
    } else {
        name_prev.split = c("","")
    }
    
    if (i < n_variables) {
        name_next.split = customSplit(names[i+1])
    } else {
        name_next.split = c("","")
    }
    
    first = name_prev.split[1]
    second = name.split[1]
    third = name_next.split[1]
    
    if (first != second) {
        # at the beginning
        if ( grepl(".", name.split[1], fixed = TRUE) ) { # valid only for nonlatent varialbes
            current_question = current_question + 1
            latent = FALSE
        } else {
            latent = TRUE
        }
        subquestion = 1
    }
    if (first == second) {
        # in the middle
        subquestion = subquestion + 1
    }
    if (first == second && second != third) {
        # at the end
    }
    if (first != second && second != third) {
        # variable = question
    }
    
    ########################
    # Detect variable type #
    ########################
    if (name.split[1] == name_prev.split[1] || name.split[1] == name_next.split[1]){
        dists[i] = "categorical"
        is.dummy = TRUE
    } else {
        is.dummy = FALSE
    }
    
    if (grepl("ordinal", name.split[2])) {
        dists[i] = "categorical"
    }
    
    if (grepl("continuous", name.split[2])) {
        dists[i] = "uniform"
        # formulas[i] = "0;1"
    }
    
    # Changed my mind about this very two variables
    if ( grepl("Срок", name.split[1]) || grepl("Возраст", name.split[1])){
        dists[i] = "categorical"
        # formulas[i] = probsToString(probs[[current_question]])
    }
    
    
    ###############
    # Set formuli #
    ###############
    if (dists[i] == "uniform") {
        corrected_dists[i] = dists[i]
        formulas[i] = "0;1"
    }
    if (dists[i] == "categorical") {
        corrected_dists[i] = "uniform"
        if (is.dummy) {
            formulas[i] = "0;1"
        } else {
            start = 0
            end = length(probs[[current_question]]) - 1
            formulas[i] = paste(start, end, sep = ";")
        }
    }
    
    print("Variable number:")
    print(i)
    print("Question number:")
    print(current_question)
    print(name.split)
    print(dists[i])
    print(probs[[current_question]])
    print(formulas[i])
    
}