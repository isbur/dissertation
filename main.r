source("read_responses.r", chdir = TRUE)


Responses = read_responses()    # First letter is capitalized because Responses
                                # is an object in .GlobalEnv and I want to refer
                                # to this very object from inside every function;
                                # Passing this object with arguments has only specification
                                # purposes


source("try_to_decrease_energy.r", chdir = TRUE)
source("evaluate_energy.r")
source("estimate_energy_drop.r")
source("decide_whether_energy_has_stopped_decreasing_or_not.r")


source("./auxiliary/main_presets.r")


while(energy_has_not_stopped_decreasing) {
    
    try_to_decrease_energy(Responses)
    new_energy = evaluate_energy(Responses)
    energies.append(new_energy)
    estimate_energy_drop(energies)
    decide_whether_energy_has_stopped_decreasing_or_not()
    checkout(energy_has_not_stopped_decreasing)
    
}
