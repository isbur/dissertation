library(sets)

evaluate_energy = function(responses) {
    p_energy = 0
    # Check please is there sufficient amount of names
    for (pair in combn(names(responses),2, tuple) ) {
        # print(pair)
        tbl = table(responses[,pair[1]], responses[,pair[2]])
        res = chisq.test(tbl)
        # print(res$p.value)
        p_energy = p_energy + res$p.value
    }
    return(p_energy)
}

# print(evaluate_energy(responses))