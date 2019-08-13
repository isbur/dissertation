library(rlang)
library(dequer)


initialize = function(){
    Master_Registry = env(
        registries_stack = stack()
    )
    assign("Master_Registry", Master_Registry, envir = .GlobalEnv)
}


appendRegistry = function(registry_name){
    # registry_name = deparse(substitute(registry))
    Master_Registry = get("Master_Registry", envir = .GlobalEnv)
    registries_stack = get("registries_stack", envir = Master_Registry)
    
    push(registries_stack, registry_name)
    assign(registry_name, env(), envir = Master_Registry)
    assign("registries_stack", registries_stack, envir = Master_Registry)
    assign("Master_Registry", Master_Registry, envir = .GlobalEnv)
}


popRegistry = function(){
    Master_Registry = get("Master_Registry", envir = .GlobalEnv)
    registries_stack = get("registries_stack", envir = Master_Registry)
    
    pop(registries_stack)
    assign(registry_name, env(), envir = Master_Registry)
    assign("registries_stack", registry_stack, envir = Master_Registry)
    assign("Master_Registry", Master_Registry, envir = .GlobalEnv)
}


register = function(object) {
    Master_Registry = get("Master_Registry", envir = .GlobalEnv)
    registries_stack = get("registries_stack", envir = Master_Registry)
    registry_name = as.list(registries_stack)[[1]]
    # print(registry_name)
    Registry = get(registry_name, envir = Master_Registry)
    
    assign(deparse(substitute(object)), object, envir = Registry)
    assign(registry_name, Registry, envir = Master_Registry)
    assign("Master_Registry", Master_Registry, envir = .GlobalEnv)
}


checkout = function(object) {
    object_name = deparse(substitute(object))
    Master_Registry = get("Master_Registry", envir = .GlobalEnv)
    registries_stack = get("registries_stack", envir = Master_Registry)
    registry_name = as.list(registries_stack)[[1]]
    Registry = get(registry_name, envir = Master_Registry)
    object_contents = get(object_name, envir = Registry)
    
    assign(object_name, object_contents, envir = parent.frame())
}