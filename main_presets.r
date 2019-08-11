library(dequer)


Bresponses = responses
memberImember = rep(FALSE,length(responses[,1]))
energy_has_not_stopped_decreasing = TRUE
energies = queue()
count = 1