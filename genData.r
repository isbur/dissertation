##############################
# Generate data
##############################
library(simstudy)
library(devtools)
source_gist(4676064)

#### FAIL ####
def = NULL
for (i in c(1:n_variables)) {
    def = defData(def, varname = names[i], dist = corrected_dists[i], formula = formulas[i])  # Alredy don't remember how "names" was got
}

Sigma = read.csv(file = "corr.csv", header = TRUE, row.names = 1)
Sigma = as.matrix(Sigma)
Sigma = unname(Sigma) # otherwise isSymmetric may be FALSE
dt = genCorFlex(n_individuals, def, corMatrix = Sigma)