library(sets)


source("./auxiliary/myPush.r")


energies.append = function(new_energy){
    checkout(energies)
    energies = myPush(energies, new_energy)
    register(energies)
}


estimate_energy_drop = function (q) {
    print(q)
    q = unlist(as.list(q))
    print(q)
    q = sd(q)
    print(q)
    
    assign("estimate", q, envir = .GlobalEnv)
}