library(dequer)
library(zeallot)
library(sets) # for tuple function inside evaluate_energy


source("myPush.r")

source("./auxiliary/plusOverload.r")
# source("read_responses.r", chdir = TRUE)

source("./common/expected_corrs.r")
source("./common/constants.r")

source("evaluate_energy.r")
source("./DECREASE_ENERGY/decrease_energy.r", chdir = TRUE)
source("estimate_energy_drop.r")


# Investigate later how to make this values bound and how to make it possible to use either name
# energy_has_stopped_decreasing = FALSE
Bresponses = responses
memberImember = rep(FALSE,length(responses[,1]))
energy_has_not_stopped_decreasing = TRUE
last_energies = queue()
count = 1
while(energy_has_not_stopped_decreasing && count <= ENERGY_MINIMIZER_ITERATIONS_LIMIT){
    print(count)
    energy = evaluate_energy(Bresponses)
    last_energies = myPush(last_energies, energy)
    estimate = estimate_energy_drop(last_energies)
    if (count >= MYPUSH_QUEUE_DEPTH && estimate < ENERGY_DROP_LIMIT) { 
        energy_has_not_stopped_decreasing = FALSE
    }
    c(Bresponses, memberImember) %<-% decrease_energy(Bresponses, memberImember, expected_corrs_matrix)
    count = count + 1
}