library("xlsx")

source("./common/names.r")

read_responses = function(){
    
    if(!exists("responses_reserved_copy")) {
    
        Postfices = c("A","K","U")
        responses=data.frame()
        for (postfix in Postfices) {
            file = read.xlsx(paste("./data/responses", postfix, ".xlsx", sep=""), 1)
            file = as.data.frame(file)
            responses = rbind(responses,file)
        }
        
        names(responses) = names
        
        
        assign("responses_reserved_copy", responses, envir = .GlobalEnv)
    } else {
        responses = responses_reserved_copy
        # cat("Easy way was chosen\n")
    }
    
    return(responses)
}