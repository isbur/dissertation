getProbsMatrix = function(x, levels) {
    m = length(x[,1])
    n = length(levels)
    y = matrix(rep(levels, m), ncol = n, byrow = TRUE)
    colnames(y) = levels
    rownames(y) = x[,1]
    for (i in c(1:m)) {
        first = x[i,1]
        second = x[i,2]
        third = x[i,3]
        # print(first)
        # print(second)
        # print(third)
        y[first,second] = third
        y[i,] = ifelse(
            !is.na(as.double(y[i,])), 
            y[i,], 
            ( 1 - as.double(y[i,!is.na(as.double(y[i,]))]) ) / (n-1)
        )
    }
    return(y)
}


getWeightedFactor = function (x, probs_matrix, levels, factor_correspondence_matrix) {
    M = factor_correspondence_matrix
    current_factor = M[M[,2]==x,1]
    probs = A[current_factor,]
    y = sample(levels, 1, prob = probs)
    return(y)
}


myGenCorFactorialData = function (base_vector, matrix_of_probs_for_factors_from_base, levels, factor_correspondence_matrix) {
    print("Next run")
    x = base_vector
    A = matrix_of_probs_for_factors_from_base
    y = c()
    for (i in c(1:length(x))) {
        y[i] = getWeightedFactor(x[i], A, levels, factor_correspondence_matrix)
    }
    return (y)
}


getSpecificNumber = function(current_factor, levels, type = "+") {
    x = current_factor
    n = length(levels)
    if (type == "-") {
        x = n - x - 1
    }
    return(runif(1,x,x+1)/n)
}


myGenCorContinuousData = function (base_vector, type = "+") {
    x = base_vector
    y = runif(1,x,x+1)
}


Sresponses = responses[,-c(12:25)]


# Generate religious data
religions_raw_vector = c("узбек", "ислам", 0.9,
                         "армянин", "христианство", 0.7,
                         "казах", "ислам", 0.7)
religions_matrix = matrix(religions_raw_vector, ncol=3, byrow = TRUE)
religions_variety = c("ислам", "христианство", "не религиозен")


X = religions_matrix
levels = religions_variety
A = getProbsMatrix(X, levels)
x = responses[,1]
y = myGenCorFactorialData(x,A,levels,nationalities_correspondence_matrix)
SEresponses = cbind(Sresponses, y)


# Try to add diasporalic data
#x = sample(responses[,1], 20)
x = responses[,1]
y = mapply(getSpecificNumber, x, MoreArgs = list(nationalities_correspondence_matrix[,1], "-"))
SEresponses = cbind(SEresponses, y)

# And sociability
y = mapply(getSpecificNumber, x, MoreArgs = list(nationalities_correspondence_matrix[,1], "+"))
SEresponses = cbind(SEresponses, y)


# Balance language knowledge
# 1. What influences (does influence?) on language knowledge?
M = expected_corrs_matrix
target_factor = "знание языка"
start_factors = M[M[,2]==target_factor,1]
start_factors
# Let each variable have equal influence on target variable
influence_amount = 1 / length(start_factors)
# And now let's see how every variable is going to deal with their power
for (factor in start_factors) {
    rule = M[ (M[,1]==factor & M[,2] == target_factor),3]
    if (rule == "") {
        next
    }
    if (rule == "+" || rule == "-") {
        
    }
}

