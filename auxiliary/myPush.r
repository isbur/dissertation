library(sets)


persistent_source("./common/constants.r")


myPush = function(q, item) {
    pushback(q, item)
    if (length(q) > MYPUSH_QUEUE_DEPTH) {
        pop(q)
    }
    return(q)
}