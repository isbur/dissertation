# library(DescTools)


findNearestAnswers = function(targetAnswer, column) { # column itself! not just name/index/etc
    indicesToReturn = DescTools::Closest(column, targetAnswer, which = TRUE)
    return (indicesToReturn)
}

findRandomNearestAnswer = function(targetAnswer, column) {
    res = findNearestAnswers(targetAnswer, column)
    target_index = sample(res, 1)
    return(target_index)
}