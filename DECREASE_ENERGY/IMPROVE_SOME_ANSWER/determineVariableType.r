determineVariableType = function(column) {
    if(is.integer(column)) {
        variableType = "categorical"
    } else if (is.double(column)) {
        variableType = "quantitive"
    } else {
        variableType = "unknown"
        print("WARNING! Variable type is unknown")
    }
    return(variableType)
}