#' Dijkstra Algoritm
#'
#' @author Maria,Masinde,Omkar
#' @param graph as dataframe
#' @param init_node as numeric
#'
#' @return Shortest distance to all vertex from init_node.
#' @references <https://en.wikipedia.org/wiki/Dijkstra\%27s_algorithm>
#' @export dijkstra
#'
#' @examples dijkstra(graph = wiki_graph,init_node = 1)
#'
#'
dijkstra <- function(graph, init_node ){

  if(is.numeric(init_node)== F || is.data.frame(graph) ==F){
    stop("Please enter valid inputs")
  }
  if(ncol(graph)!= 3||!(all(colnames(graph) == c("v1", "v2" , "w")))){
    stop("Please enter the graph  with correct column names")
  }
  if(!(init_node %in% unique(c(graph$v1,graph$v2)))){
    stop("The initial node given does not exist in the graph")
  }


  dist <- c() # initializing an empty distance vector
  vertex = unique(c(graph$v1,graph$v2))  # getting the list of vertex from the input graph
  dist[1:length(vertex)] <- Inf  # setting distance as of all nodes as infinity
  dist[init_node] <- 0  # setting distance of init_node to 0
  Qset <- data.frame(vertex,dist)  # creating a Qset for keeping track of all unvisited nodes
  result <- data.frame(vertex,dist) # the result data frame for storing final results



  while(length(Qset$vertex) > 0){   # looping until uvisited set is empty
    mindistance <- min(Qset$dist)  # getting minimum distance in unvisited set
    nodeindex <- which(Qset$dist == mindistance)  # getting index of the minimum distance inorder to find the vertex
    previousnode <- Qset$vertex[nodeindex]   # getting the vertex to which we have the minimum distance
    Qset <- Qset[-c(nodeindex),]  # deleting the entry from qset which has minimum distance

    neighbours <- graph[graph$v1==previousnode,]$v2 # getting the neighbours for min distance entry that we got in the step above

    # in the loop below we are going through all the neighbour vertex and finding the
    # distance for each node from the previous node
    # then checks if the distance of the node which is already populated is less than the
    #distance that we calculated now and if so populate the new distance(which is the shortest)
    for (n in neighbours){
      g <- graph[graph$v1==previousnode,]
      g1 <- g[g$v2==n,] # filter the graph to have entries which corresponds to the previousnode and the current neighbour
      new_distance <- mindistance + g1$w  # calculate the distance of neighbour from mindisvertex
      # populate the distance if it is less that the distance already calculated for that vertex.
      if(new_distance < result[result$vertex==n,]$dist){
        result[result$vertex==n,]$dist <- new_distance
        Qset[Qset$vertex==n,]$dist <- new_distance
      }
    }
  }
  # r <- as.vector(result$dist)
  return(as.vector(result$dist))
}


