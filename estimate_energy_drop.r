library(sets)


source("myPush.r")


energies.append = function(new_energy){
    energies = myPush(energies, new_energy)
}


estimate_energy_drop = function (q) {
    print(q)
    q = unlist(as.list(q))
    print(q)
    q = sd(q)
    print(q)
    
    assign("estimate", q, envir = .GlobalEnv)
}