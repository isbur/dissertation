library("xlsx")

# persistent_source("./common/names.r")
source("../common/names.r")

read_responses = function(filename = NULL, path_to_dir = ""){
    
    
    if(!is.null(filename)){
       # return( custom_read_responses(file.path(path_to_dir, filename)) )
        return( custom_read_responses(filename) )
    }
    
    
    if(!exists("responses_reserved_copy")) {
        
        # cat("Hard way was chosen\n")
        Postfices = c("A","K","U")
        responses=NULL
        for (postfix in Postfices) {
            filename = paste("./data/responses", postfix, ".xlsx", sep="")
            file = read.xlsx(filename, 1)
            file = as.data.frame(file)
            responses = rbind(responses,file)
        }

        names(responses) = names


        assign("responses_reserved_copy", responses, envir = .GlobalEnv)
    } else {
        # cat("Easy way was chosen\n")
        responses = responses_reserved_copy

    }

    return(responses)
}


custom_read_responses = function(filename) {
    file = read.xlsx(filename, 1)
    file = as.data.frame(file)
}