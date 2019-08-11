source("read_responses.r", chdir = TRUE)
source("try_to_decrease_energy.r", chdir = TRUE)
source("evaluate_energy.r")
source("estimate_energy_drop.r")
source("decide_whether_energy_has_stopped_decreasing_or_not.r")

source("main_presets.r")

responses = read_responses()
while(energy_has_not_stopped_decreasing) {# && count <= ENERGY_MINIMIZER_ITERATIONS_LIMIT){
    
    responses = try_to_decrease_energy(responses)
    new_energy = evaluate_energy(responses)
    energies.append(new_energy)
    estimate_energy_drop(energies)
    decide_whether_energy_has_stopped_decreasing_or_not()

}