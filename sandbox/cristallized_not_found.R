c =function() {
    cat("\nc:", get("individualышл"))
}

b = function() {
    c()
}

a = function(individual) {
    b()
}


main = function() {
    individuals = 1:3
    for (individual in individuals) {
        cat("\nmain:", individual)
        a(individual)
    }
}
main()