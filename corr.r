#################
# Corr table
#################


#file = read.xlsx("corr.xlsx",1, header=FALSE)
file = read.xlsx("corr.xlsx",1, header=FALSE, stringsAsFactors = FALSE)
pureData = file[,-1] # Delete "Latency"
pureData = pureData[-79,] #Delete last row of NAs


########################
# Merge header rows ####
########################


nCols = length(pureData[1,])
rowToAppend=rep(NA,nCols)
pureData2 = rbind(rowToAppend, pureData)


#pureData3 = data.frame(pureData2, stringsAsFactors = FALSE)
pureData3 = pureData2
for (i in c(1:nCols)){
  #    first = gsub(" ", "-", pureData3[2,i])
  #    pureData3[1,i] = paste(first,pureData3[3,i],sep="_")
  #print("#########################Before")
  zero = pureData3[1,i]
  #print(zero)
  first = pureData3[2,i]
  #print(first)
  second = pureData3[3,i]
  #print(second)
  
  if(is.na(second)){
    next
  }
  if(is.na(first)){
    #print(is.na(first))
    j = i
    #print(j)
    item = NA
    while(is.na(item)){
      item = pureData3[2,j]
      j = j - 1
    }
    first = item
#    print("After")
#    print(first)
  }
  
  
#  print("After")
#  print(zero)
#  print(first)
#  print(second)
  
  pureData3[1,i] = paste(first,second,sep="_")
}
pureData4 = pureData3[-c(2,3),]


###########################
# Merge header columns ####
###########################


nRows = length(pureData4[,1])
colToAppend=rep(NA,nRows)
pureData5 = cbind(colToAppend, pureData4, stringsAsFactors = FALSE)


pureData6 = pureData5
for (i in c(1:nRows)){
    zero = pureData6[i,1]
    first = pureData6[i,2]
    second = pureData6[i,3]
    
    if(is.na(second)){
      next
    }
    
    if(is.na(first)){
        j = i
        item = NA
        while(is.na(item)){
          item = pureData6[j,2]
          j = j - 1
        }
        first = item
    }
    
    pureData6[i,1] = paste(first,second,sep="_")
}
pureData7 = pureData6[,-c(2,3)]


######################
# Values to names ####
######################
pureData8 = pureData7[-1,-1]
rownames(pureData8) = pureData7[-1,1]
colnames(pureData8) = pureData7[1,-1]


#####################################
# Symmetrize and fill with zeros ####
#####################################
pureData9=pureData8
nRows = length(pureData9)
nCols = length(pureData9[1,])
for (i in c(1:nRows)){
    for (j in c(1:nCols)) {
        item = pureData9[i,j]
        oppose = pureData[j,i]
        if (is.na(item)) {
            pureData9[i,j] = 0
        } else if (is.na(oppose)){
            pureData9[j,i] = item
        } else if (item != oppose && item != 0) {
            pureData9[j,i] = item
        } 
    }
}


#####################################
# Matrizise ####
#####################################
pureData10 = data.matrix(pureData9)
for (i in c(1:nRows)){
    for (j in c(1:nCols)) {
        item = pureData10[i,j]
        if (is.na(item)) {
            pureData10[i,j] = 0
        } 
    }
}


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
