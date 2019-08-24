# persistent_source("../getters_from_data/getProbabilities.r", local = TRUE)
source("../getters_from_data/getProbabilities.r", local = TRUE)
# source("../../meta/isolating_source.r")


# print(environment())
# if (exists("checkout", envir = environment(), inherits = FALSE)) {
#     stop("\"checkout\" already exists in current environment. Possibly file was sourced() without \"local=TRUE\"")
# }


#depends on variable existence/latency
# get_or_set_defaults = function(){
#     
#     checkout(question)
#     
#     check_whether_variable_exists() # it may be in Responses or 
#                                     # already be generated in one of the previous calls
#     # checkout(variable_exists)
#     # if(variable_exists){
#     #     get_defaults()
#     # } else {
#     #     set_defaults()
#     # }
# }


get_defaults = function(){
    checkout(individual)
    id = individual
    #### We need to save picture per nation ####
    rows_selector = (Responses[,2]==Responses[id,2]) 
    register(rows_selector)
    getProbabilities()
}


set_defaults = function(){
    
}


check_whether_variable_exists = function() {
    
}


look_for_dependencies = function () {
    
}


# get one from improveSomeAnswer
modify_probabilities_according_to_rules = function() {
    
}


# get good one from improveSomeAnswer
generate_answer = function() {
    
}


# Overload only for the current scope
# checkout = function(object) {
#     object_expr = substitute(object)
#     object_name = deparse(substitute(object))
#     if(identical(object_expr, expr(variable_name))){
#         object_expr = expr(question) # ideally search for something inside Registry, but screw it
#     }
#     Registar = get("Registar")
#     Registar$checkout(eval(object_expr))
# }


# checkout = function(object) {
#     object_name = deparse(substitute(object))
#     Registar = get("Registar")
#     if(object_name == "variable_name"){
#         Registar$checkout(question) # ideally search for something inside Registry, but screw it
#     }else{
#         stop("Fuck, at the end, something more clever was needed...")
#     }
#     
#     Registar$checkout(eval(object_expr))
# }