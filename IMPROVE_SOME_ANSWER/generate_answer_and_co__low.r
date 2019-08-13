get_or_set_defaults = function(){
    #depends on variable existence/latency
    checkout(variable_name)
    
    check_whether_variable_exists() # it may be in Responses or 
                                    # already be generated in one of the previous calls
    checkout(variable_exists)
    if(variable_exists){
        get_defaults()
    } else {
        set_defaults()
    }
}