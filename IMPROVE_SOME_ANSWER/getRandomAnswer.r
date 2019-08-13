getRandomAnswer = function(options, prob = NULL) {
    n = sample(options, 1, prob = prob)
    return(n)
}