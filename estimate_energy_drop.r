library(sets)

estimate_energy_drop = function (q) {
    print(q)
    q = unlist(as.list(q))
    print(q)
    q = sd(q)
    print(q)
    return(q)
}