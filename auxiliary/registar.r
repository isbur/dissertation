library(rlang)


initialize = function(){
    Registry = env()
    assign("Registry", Registry, envir = .GlobalEnv)
}


register = function(object) {
    assign(deparse(substitute(object)), object, envir = Registry)
}


checkout = function(object) {
    object_name = deparse(substitute(object))
    object_contents = get(object_name, envir = Registry)
    assign(object_name, object_contents, envir = parent.frame())
}