library(proftools)
library(Rgraphviz)

Rprof(interval=0.005)
source("main.r")
Rprof(NULL)

pd <- readProfileData("Rprof.out")
ppd = plotProfileCallGraph(pd)
graph.par(list(nodes=list(cex = 0.5, textCol="black")))
renderGraph(ppd)


# # Another way
# library(CodeDepends)
# gg = makeCallGraph(main)
# if(require(Rgraphviz)) {
#     gg = layoutGraph(gg, layoutType = "circo")
#     graph.par(list(nodes = list(fontsize=55)))
#     renderGraph(gg) ## could also call plot directly
# }

# visualize = function(graphObject) {
#     gg = graphObject
#     if(require(Rgraphviz)) {
#         gg = layoutGraph(gg, layoutType = "circo")
#         graph.par(list(nodes = list(fontsize=55)))
#         renderGraph(gg) ## could also call plot directly
#     }
# }


rm(list=ls())

source("main.r")
traceback()

library(mvbutils)
foodweb(lwd = 2)



