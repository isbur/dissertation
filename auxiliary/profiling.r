Rprof()
source("main.r")
Rprof(NULL)

pd <- readProfileData("Rprof.out")
ppd = plotProfileCallGraph(pd)
graph.par(list(nodes=list(cex = 0.5, textCol="black")))
renderGraph(ppd)