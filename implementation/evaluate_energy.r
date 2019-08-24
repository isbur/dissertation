library(sets)

evaluate_energy = function(responses) {
    
    p_energy = 0
    # Check please is there sufficient amount of names
    # count = 0
    for (pair in combn(names(responses),2, tuple) ) {
        # count = count + 1
        # cat("pair", count, "\n")
        tbl = table(responses[,pair[1]], responses[,pair[2]])
        res = tryCatch({chisq.test(tbl)},
                       warning = function(w){})
        # print(res$p.value)
        p_energy = p_energy + res$p.value
    }
    
    return(p_energy)
}

# print(evaluate_energy(responses))