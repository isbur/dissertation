library(MASS)


# Check correlations with "nationality"
k = 1
next_value = "национальность"
while (next_value != "этноцентричность") {
    print("Next iteration")
    
    first = expected_corrs_matrix[k,1]
    i = as.integer(correspondence[first])
    # print(first)
    # print(i)
    
    second = expected_corrs_matrix[k,2]
    j = as.integer(correspondence[second])
    # print(second)
    # print(j)
    
    k = k + 1
    next_value = expected_corrs_matrix[k,1]
    
    if (i == 101) {
        i = i - 78
    }
    if (j == 101) {
        j = j - 78
    }
    if (i > 101 || j > 101) { #Introduced variables; not implemented yet
        print(first)
        print(i)
        print(second)
        print(j)

        next
    } 
    if (first == "срок проживания в РФ") {
        x = Sresponses[,i]
        x[x>2] = 2
        tbl = table(x, SEresponses[,j])
    } else {
        tbl = table(SEresponses[,i], SEresponses[,j])
    }
    
    res = chisq.test(tbl)
    print(tbl)
    print(res)
    
}

# Please add Wilcoxon test somewhere
# wilcox.test(x,y)

