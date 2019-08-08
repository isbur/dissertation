# Shorthand for base::agrepl() 
mygrepl = function(pattern, x){
    return(agrepl(pattern, x, max = 5, ignore.case = TRUE))
}