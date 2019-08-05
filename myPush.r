library(sets)


REFERENCES_LIMIT = 5


myPush = function(q, item) {
    pushback(q, item)
    if (length(q) > REFERNCES_LIMIT) {
        pop(q)
    }
    return(q)
}