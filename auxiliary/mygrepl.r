# Shorthand for base::agrepl() 
mygrepl = function(pattern, x){
    
    MYGREPL_ITERATIONS_LIMIT = 8
    
    cat("Pattern to search:\t", pattern, "\n")
    
    count = 4
    trial = agrepl(pattern, x, max.distance = count)
    cat("Trying with count = ", count, "\n")
    print(trial)
    iterations_limit_has_been_reached = FALSE
    while( identical(trial, rep(FALSE, length(x))) && !iterations_limit_has_been_reached ) { # Second condition is needed to avoid whole-name matching (not sure it is effective)
        count = count + 1
        trial = agrepl(pattern, x, max.distance = count)
        cat("Trying with count = ", count, "\n")
        print(trial)
        if (count >= MYGREPL_ITERATIONS_LIMIT) {
            iterations_limit_has_been_reached = TRUE
        }
    }
    
    if (iterations_limit_has_been_reached) {
        cat("More data is needed to be generated\n\n")
        return("More data is needed to be generated")
    }
    
    return(trial)
}