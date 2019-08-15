findSomeVariableNameInRegistry = function(error) {
    Master_Registry = get("Master_Registry", envir = .GlobalEnv)
    registries_stack = get("registries_stack", envir = Master_Registry)
    registry_name = as.list(registries_stack)[[1]]
    Registry = get(registry_name, envir = Master_Registry)
    
    objects_list = ls(Registry)
    res = grep("question", objects_list)
    if (!identical(res, character(0))) {
        return (res)
    } else {
        stop("Couldn't solve the problem :(")
    }
}