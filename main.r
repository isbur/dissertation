library(dequer)
library(zeallot)
library(sets) # for tuple function inside evaluate_energy


ITERATIONS_LIMIT = 1
ENERGY_DROP_LIMIT = 0.05


# Investigate later how to make this values bound and how to make it possible to use either name
# energy_has_stopped_decreasing = FALSE
Bresponses = responses
memberImember = rep(FALSE,length(responses[,1]))
energy_has_not_stopped_decreasing = TRUE
last_energies = queue()
count = 1
while(energy_has_not_stopped_decreasing && count <= ITERATIONS_LIMIT){
    print(count)
    energy = evaluate_energy(Bresponses)
    last_energies = myPush(last_energies, energy)
    estimate = estimate_energy_drop(last_energies)
    if (count >= REFERENCES_LIMIT && estimate < ENERGY_DROP_LIMIT) { # REFERENCES_LIMIT - see myPush.r
        energy_has_not_stopped_decreasing = FALSE
    }
    c(Bresponses, memberImember) %<-% decrease_energy(Bresponses, memberImember, expected_corrs_matrix)
    count = count + 1
}