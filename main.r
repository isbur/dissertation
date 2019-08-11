source("read_responses.r", chdir = TRUE)
source("try_to_decrease_energy.r", chdir = TRUE)
source("evaluate_energy.r")
source("estimate_energy_drop.r")
source("decide_whether_energy_has_stopped_decreasing_or_not.r")

source("main_presets.r")

Responses = read_responses()    # First letter is capitalized because Responses
                                # is an object in .GlobalEnv and I want to refer
                                # to this very object from inside every function;
                                # Passing this object with arguments has only specification
                                # purposes

while(energy_has_not_stopped_decreasing) {# && count <= ENERGY_MINIMIZER_ITERATIONS_LIMIT){
    
    Responses = try_to_decrease_energy(Responses)
    new_energy = evaluate_energy(Responses)
    energies.append(new_energy)
    estimate_energy_drop(energies)
    decide_whether_energy_has_stopped_decreasing_or_not()

}