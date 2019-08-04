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


myGenCorContinuousData = function (base_vector, type = "+") {
    x = base_vector
    y = runif(1,x,x+1)
}


library(MASS)

Sresponses = responses[,-c(11:25)]

expected_corrs_vector = c("национальность", "планы на будущее", "",
                   "национальность", "религия", "",
                   "национальность", "создание семьи", "",
                   "национальность", "получение гражданства", "",
                   "национальность", "диаспоральность", "",
                   "национальность", "знание языка", "",
                   "национальность", "общение и досуг", "",
                   "срок проживания в РФ", "знание языка", "+",
                   #"срок проживания в РФ", "планы на будущее", "пофиг",
                   "срок проживания в РФ", "диаспоральность", "-",
                   "срок проживания в РФ", "общение и досуг", "+",
                   #"срок проживания в РФ", "способ решения проблем", "",
                   "этноцентричность", "общение и досуг", "",
                   "этноцентричность", "получение гражданства", "",
                   "этноцентричность", "религиозность", "",
                   "этноцентричность", "планы на будущее", "",
                   "этноцентричность", "диаспоральность", "",
                   "этноцентричность", "способ решения проблем", "",
                   "этноцентричность", "создание семьи", "",
                   "социальная проблемность", "диаспоральность", "",
                   "социальная проблемность", "способ решения проблем", "",
                   "социальная проблемность", "планы на будущее", "",
                   "социальная проблемность", "информированность", "",
                   "социальная проблемность", "общение и досуг", "",
                   "диаспоральность", "общение и досуг", "",
                   "диаспоральность", "способ решения проблем", "",
                   "диаспоральность", "информированность", "",
                   "диаспоральность", "создание семьи", "",
                   "религия", "диаспоральность", "",
                   "религия", "общение и досуг", "",
                   "религия", "создание семьи", "",
                   "образование","знание языка", "",
                   "образование","место жительства", "",
                   "образование","общение и досуг", "",
                   "образование","создание семьи", "",
                   "образование","планы на будущее", "",
                   "образование","информированность", "",
                   "образование","способ решения проблем", ""
                   # Нуждается в проверке
                   # "советскость"
                   # suddenly came in mind while typing
                   #"религия", "религиозность"
                   )
expected_corrs_matrix = matrix(expected_corrs_vector, ncol=3, byrow = TRUE)


expected_corrs_named_vector = expected_corrs_matrix[,2]
names(expected_corrs_named_vector) = expected_corrs_matrix[,1]


# По номеру вопроса
correspondence_raw_vector = c("национальность", 2,
                              "срок проживания в РФ", 3,
                              "планы на будущее", 5,
                              "знание языка", 6,
                              "способ решения проблем", 14,
                              "создание семьи", 18,
                              "получение гражданства", 19,
                              "религия", 101,
                              "диаспоральность", 102,
                              "общение и досуг", 103)

correspondence_matrix = matrix(correspondence_raw_vector, ncol=2, byrow = TRUE)

correspondence_named_vector = correspondence_matrix[,2]
names(correspondence_named_vector) = correspondence_matrix[,1]

correspondence = correspondence_named_vector

# Check correlations with "nationality"
k = 1
next_value = "национальность"
while (next_value != "этноцентричность") {
    print("Next iteration")
    
    first = expected_corrs_matrix[k,1]
    i = as.integer(correspondence[first])
    # print(first)
    # print(i)
    
    second = expected_corrs_matrix[k,2]
    j = as.integer(correspondence[second])
    # print(second)
    # print(j)
    
    k = k + 1
    next_value = expected_corrs_matrix[k,1]
    
    if (i > 100 || j > 100) { #Introduced variables; not implemented yet
        print(first)
        print(i)
        print(second)
        print(j)
        next
    } 
    if (first == "срок проживания в РФ") {
        x = Sresponses[,i]
        x[x>2] = 2
        tbl = table(x, Sresponses[,j])
    } else {
        tbl = table(Sresponses[,i], Sresponses[,j])
    }
    
    res = chisq.test(tbl)
    # print(tbl)
    # print(res)
    
}


nationalities_correspondence_vector = c("узбек", 0,
                                        "армянин", 1,
                                        "казах",2)
nationalities_correspondence_matrix = matrix(nationalities_correspondence_vector, ncol=2, byrow = TRUE)


religions_raw_vector = c("узбек", "ислам", 0.9,
                         "армянин", "христианство", 0.7,
                         "казах", "ислам", 0.7)
religions_matrix = matrix(religions_raw_vector, ncol=3, byrow = TRUE)
religions_variety = c("ислам", "христианство", "не религиозен")
religions_correspondence_vector = c("ислам", 0,
                                    "христианство", 1,
                                    "не религиозен", 2)
religions_correspondence_matrix = matrix(religions_correspondence_vector, ncol=2, byrow = TRUE)

x = religions_matrix
levels = religions_variety
A = getProbsMatrix(x, levels)


#myGenCorFactorialData(responses[1:20,1], M)
x = sample(responses[,1], 20)
y = myGenCorFactorialData(x,A,levels,nationalities_correspondence_matrix)
