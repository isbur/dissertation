# Shorthand for base::agrepl() 
mygrepl = function(pattern, x){
    # metrics = list(
    #     deletions = 5,
    #     substitutions = 5,
    #     insertions = 5
    # )
    # return(agrepl(pattern, x, max.distance = metrics, ignore.case = TRUE))
    
    return(agrepl(pattern, x, max.distance = 4))
}