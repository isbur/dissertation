categorical_generator = function(){
    checkout(variables_influencing_on_answer)
    
    
    for (influencing_variable in variables_influencing_on_answer) {
        register(influencing_variable)
        change_answer_generation_settings() # OK
    }
    generateCatAnswer()
}


generateCatAnswer = function() {
    checkout(final_probs)
    probs = final_probs
    answer = getRandomAnswer(c(0:(length(probs) - 1)), probs)
    register(answer)
}