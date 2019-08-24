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


source("./tests/setup_cleanup.r")
cleanup()

source("main.r")

source("./tests/setup_shorthand.r", chdir = TRUE)
source("try_to_decrease_energy.r")
traceback()

library(mvbutils)
foodweb(lwd = 2)


# library(mvbutils)
# fw = foodweb(lwd = 2)
# library(DiagrammeR)
# dg = from_adj_matrix(fw$funmat)
# n = length(dg$nodes_df$id)
# render_graph(dg, output = "visNetwork")
# for(i in c(1:n)){
#     node_id = i
#     node_label = dg$nodes_df$label[i]
#     node_x = fw$x[i] * 1000
#     node_y = fw$level[i] * 100
#     set_node_position(dg, node_id, node_x, node_y)
# }
# render_graph(dg, output = "visNetwork")
# render_graph(dg)


library(mvbutils)
fw = foodweb(lwd = 2)
library(DiagrammeR)
dg = from_adj_matrix(fw$funmat)
library(visNetwork)
visNetwork(data.frame(id = dg$nodes_df$id,
                      label = dg$nodes_df$label,
                      level = fw$level), 
           data.frame(from = dg$edges_df$from, 
                      to = dg$edges_df$to)) %>%
    visHierarchicalLayout()


# Provided with RStudio as far as I understand
source("./auxiliary/clean_global_env.r", local = .GlobalEnv)
source("main.r")
traceback()

library(profvis)
profvis({source("main.r")})
profvis({try_to_decrease_energy()})
profvis({test_dir("./tests/IMPROVE_SOME_ANSWER/")})


############################
source("./tests/setup_shorthand.r", chdir = TRUE)
source("try_to_decrease_energy.r")

library(mvbutils)
fw = foodweb(lwd = 2)
library(DiagrammeR)
dg = from_adj_matrix(fw$funmat)
library(visNetwork)
visNetwork(data.frame(id = dg$nodes_df$id,
                      label = dg$nodes_df$label,
                      level = fw$level), 
           data.frame(from = dg$edges_df$from, 
                      to = dg$edges_df$to)) %>%
    visHierarchicalLayout() %>%
    visEvents(type = "once", 
    stabilizationIterationsDone = "function(e){
        alert(\"Hello\");
        //stopSimulation();
        physics.stabilization = FALSE;
        startSimulation();
    }") 



