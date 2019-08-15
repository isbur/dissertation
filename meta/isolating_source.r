isolating_source = function(filename){
    env_name = basename(filename)
    assign(env_name, new.env(), envir = .GlobalEnv$PersistentEnv)
    target_env = get(env_name)
    sys.source(filename, envir = target_env, chdir=TRUE)
    return(target_env)
}