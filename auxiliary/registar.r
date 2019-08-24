library(rlang)
library(dequer)


# persistent_source("../meta/settings.r")
source("../meta/settings.r")
unpack(registar_settings)


initialize = function(){
    Master_Registry = env(
        registries_stack = stack()
    )
    assign("Master_Registry", Master_Registry, envir = .GlobalEnv)
}


appendRegistry = function(registry_name){
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
    
    object_contents = tryCatch({
        get(object_name, envir = Registry)
    }, error = checkoutErrorHandler)
    
    assign(object_name, object_contents, envir = parent.frame())
}


checkoutErrorHandler = function(error) {
    if (should_I_send_checkout_error_outside_registar == TRUE){
        externalCheckoutErrorHandler(error)
    } else {
        stop(error)
    }
}


if (should_I_send_checkout_error_outside_registar == TRUE) {
    source(paste0(externalCheckoutErrorHandler_location, externalCheckoutErrorHandler_name, ".r"))
}


externalCheckoutErrorHandler = function(error){
    function_name = externalCheckoutErrorHandler_name
    do.call(function_name, list(error))
}