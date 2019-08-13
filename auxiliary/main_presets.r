library(dequer)


initialize() # from registar.r
MemberImember = rep(FALSE,length(Responses[,1]))
energy_has_not_stopped_decreasing = TRUE

appendRegistry("Main")

energies = queue()
register(energies)
count = 1
register(count)