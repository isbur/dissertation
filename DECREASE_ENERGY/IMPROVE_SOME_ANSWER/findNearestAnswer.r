library(DescTools)

findNearestAnswer = function(targetAnswer, column) {
    indicesToReturn = Closest(column, targetAnswer, which = TRUE)
    return (indicesToReturn)
}