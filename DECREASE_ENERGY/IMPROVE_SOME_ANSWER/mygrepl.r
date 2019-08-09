# Shorthand for base::agrepl() 
mygrepl = function(pattern, x){
    # metrics = list(
    #     deletions = 5,
    #     substitutions = 5,
    #     insertions = 5
    # )
    # return(agrepl(pattern, x, max.distance = metrics, ignore.case = TRUE))
    
    count = 4
    trial = agrepl(pattern, x, max.distance = count)
    # print("Trying with count = "&count)
    # print(trial)
    while(identical(trial, rep(FALSE, length(x)))){
        count = count + 1
        trial = agrepl(pattern, x, max.distance = count)
        # print("Trying with count = ", count)
        # print(trial)
    }
    
    return(trial)
}