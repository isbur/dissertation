


##########################################
# -1 for each other excluding dummies ####
##########################################
pureData11 = pureData10
# D = pureData11
# for (i in c(1:nRows)){
#   for (j in c(1:nCols)) {
#     item = D[i,j]
#     
#     item.x = rownames(D)[i]
#     if (grepl("_", item.x, fixed = TRUE)) {
#         item.x.first = strsplit(item.x, split = "_")[[1]][1]
#         item.x.second = strsplit(item.x, split = "_")[[1]][2]
#     } else {
#       next
#     }
#     item.y = colnames(D)[j]
#     if (grepl("_", item.y, fixed = TRUE)) {
#       item.y.first = strsplit(item.y, split = "_")[[1]][1]
#       item.y.second = strsplit(item.y, split = "_")[[1]][2]
#     } else {
#       next
#     }
#     
#     if (item.x.first == item.y.first) {
#         if (i != j) {
#           pureData11[i,j] = -1
#         }
#     }
#     
#   }
# }


#####################################
# Get corr matrix ####
#####################################
pureData12 = pureData11
D = pureData12

# First, generate some corr matrix
# install.packages("clusterGeneration")
n = sqrt(length(D))
library(clusterGeneration)
B = rcorrmatrix(n)

# Second, incorporate needed information to this matrix
incorporate = function(n, B, D) {
  nRows = n
  nCols = n
  for (i in c(1:nRows)){
    for (j in c(1:nCols)) {
      item = D[i,j]
      if (item != 0) {
        B[i,j] = D[i,j]
      } 
    }
  }
  return(B)
}
B = incorporate(n, B, D)


# Third, approximate it with near PD matrix
# install.packages("Matrix")
library(Matrix)
positify = function(B){
    A = nearPD(B, corr = TRUE)
    A = A[[1]]
    D = A@x
    n = sqrt(length(D))
    D = matrix(D, nrow = n, ncol = n)
    return(D)
}

library(matrixcalc)
# Some mad attempts

m = 100
B = unname(B)
B = incorporate(n, B, D)
isPD = FALSE
#i = 0
#iterations_limit = 1000000
#while (isPD || i < iterations_limit) {
#    B = positify(B)
#    B = incorporate(n, B, D)
#    B = round(B, digits = 4)
#    print(det(B))
#    isPD = is.positive.definite(B)
#    i = i + 1
#}

# Complexify
initial_conditions_number = 0
while(!isPD) {
    B = rcorrmatrix(n)
    i = 0
    iterations_limit = 30
    while (i < iterations_limit) {
        B = positify(B)
        B = incorporate(n, B, D)
        B = round(B, digits = 4)
        print(det(B))
        isPD = is.positive.definite(B)
        i = i + 1
    }
}

#if (i == iterations_limit) {
#    print("WARNING!!!")
#}

pureData12 = B




#####################################
# Determinant ####
#####################################
myDet = det(pureData12)

write.csv(pureData12, file = "corr.csv")
