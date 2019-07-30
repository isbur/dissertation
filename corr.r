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