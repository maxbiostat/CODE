graph.entropy<-function(adj){
  graph<-graph.adjacency(adj,mode=c("undirected"))
  Ks <- (igraph::degree(graph))
  mean.k<-mean(Ks)
  bins<-sort(unique(Ks))-1
  q.k<-table(Ks)/nrow(adj) 
  entropy<- -sum(q.k*log2(q.k))
return(entropy)}

