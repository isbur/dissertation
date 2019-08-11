library(CodeDepends)
gg = makeCallGraph("package:CodeDepends")
if(require(Rgraphviz)) {
    gg = layoutGraph(gg, layoutType = "circo")
    graph.par(list(nodes = list(fontsize=200)))
    renderGraph(gg) ## could also call plot directly
} 


library(proftools)


# printProfileCallGraph(pd)

pd <- readProfileData("Rprof.out")
ppd = plotProfileCallGraph(pd)
graph.par(list(nodes=list(cex = 0.5, textCol="black")))
renderGraph(ppd)

