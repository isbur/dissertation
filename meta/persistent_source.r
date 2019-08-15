create_persistent_environment = function(){
    assign("PersistentEnv", new.env(), envir = .GlobalEnv)
}

persistent_source <- function(..., local = .GlobalEnv$PersistentEnv) {
    # cat("\n")
    # print(...)
    # env_print(parent.frame(n = 2))
    base::source(..., local = local)
    attach(.GlobalEnv$PersistentEnv)
}