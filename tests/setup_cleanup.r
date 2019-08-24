cleanup = function(envir = .GlobalEnv){
    objects_list = c(ls(envir = envir))
    # objects_list
    selector = ( objects_list == "responses_reserved_copy" )
    # selector
    objects_list = objects_list[!selector]
    # objects_list
    rm(list = objects_list, envir = envir)
}