##############################
# Generate data
##############################


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


print("##################################################################################################")
print("##################################################################################################")
print("##################################################################################################")
print("##################################################################################################")
print("##################################################################################################")
names = rownames(A)
dists = list()
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
        formulas[i] = "0;1"
        # Changed my mind about this very two variables
        if ( grepl("Срок", name.split[2]) || grepl("Возраст", name.split[2])){
            dists[i] = "categorical"
            formulas[i] = probsToString(probs[[current_question]])
        }
    }
    
    
    if (dists[i] == "categorical") {
        if (is.dummy) {
            formulas[i] = makeBinaryFormula(probs[[current_question]][subquestion])
        } else {
            # Do nothing special cause probs are already given by probs.r
            formulas[i] = probsToString(probs[[current_question]])
        }
    }
    
    
    if(grepl("Религия", name.split[1])) {
        religion_counter = religion_counter + 1
        if (religion_counter == 1) {        # Armenian
            formulas[i] = makeBinaryFormula(probs[[1]][1])
        } else if (religion_counter == 2) { # Slav
            formulas[i] = makeBinaryFormula(probs[[1]][2])
        } else if (religion_counter == 3) { # Muslim
            formulas[i] = makeBinaryFormula(probs[[1]][3])
        } else if (religion_counter == 4) { # Sinners
            formulas[i] = makeBinaryFormula(0)
        }
    }
    print("Variable number:")
    print(i)
    print("Question number:")
    print(current_question)
    print(name.split)
    print(formulas[i])
    print(dists[i])
}


##############################
# FINALLY
# Generate fukin' data
##############################
library(simstudy)

#### FAIL ####
#def = NULL
#for (i in c(1:n_variables)) {
#    def = defData(def, varname = names[i], dist = dists[i], formula = formulas[i])  # Alredy don't remember how names was got
#}
#
#Sigma = read.csv("corr.csv", header = FALSE)
#dt = genCorFlex(n_individuals, def, corMatrix = Sigma)

# Another approach
Sigma = read.csv("corr.csv", header = FALSE)
dt = genData(n_individuals)
for (i in c(1:n_variables)) {
    sigma = Sigma[1:i,1:i]
    if (grepl("continuous", names[i])) {
        print("It's me!")
        def = defData(varname = names[i], dist = dists[i], formula = formulas[i])
        addCorFlex(dt, def, corMatrix = sigma)
        
    } else {
        print("Not, me!")
        genCorOrdCat(dt, baseprobs = stringToProbs(formulas[[i]]), corMatrix = sigma)
        
    }
}







