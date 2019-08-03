# install.packages(c("FactoMineR", "factoextra"))
library("FactoMineR")
library("factoextra")
defC = c(2, "n",
        1, "n",
        1, "n",
        1, "n",
        5, "n",
        15, "n",
        2, "n",
        1, "n",
        2, "n",
        1, "n",
        3, "n",
        1, "c",
        1, "n")
defM = matrix(defC, ncol = 2, byrow=TRUE)
group = as.integer(defM[,1])
type = defM[,2]
Fresponses = data.frame(factor(responses[,1]))
print(Fresponses)
for (i in c(2:length(responses[1,]))){
    colToAdd = responses[,i]
    if(i==35){
        Fresponses = cbind(Fresponses, colToAdd, deparse.level = 2)
    } else {
        colToAdd = factor(colToAdd)
        Fresponses = cbind(Fresponses, colToAdd, deparse.level = 2)
    }
    #print(colToAdd)
}
res.mfa = MFA(base = Fresponses, group = group, type = type)



library("factoextra")
eig.val <- get_eigenvalue(res.mfa)
head(eig.val)
fviz_screeplot(res.mfa)
fviz_mfa_var(res.mfa, "group")