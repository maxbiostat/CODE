###########################################################################
###########################Coupled Dynamic Systems ########################
###########################################################################
#written by Carvalho, LMF (2012)
######
# Preliminaries
######
library(igraph)
######
#function to convert any adjacency matrix to a full connected graph
conv.mat<-function(M)
{
 for (i in 1:nrow(M)){
  if(sum(M[i,])<1){M[i,sample(which(1:ncol(M)!=i),1,replace=F)]<-1}
  else M[i,]<-M[i,]
 }
return(M)
}
######
# Main Function
#should return a list with the matrix, the graph and a data.frame with the dynamics
#if plot=TRUE, plots the graph and the dynamics

coupled.dynamics<-function(K,prob,T,f,No,plot=TRUE)
{
 M<-matrix(sample(0:1,K^2,prob=prob,replace=T),ncol=K);diag(M)<-0;M<-conv.mat(M)
 colnames(M) <- LETTERS[1:K];rownames(M) <-LETTERS[1:K]
 G<-graph.adjacency(M,mode="undirected");G$name<-colnames(M)
#
 S<-data.frame(matrix(NA,ncol=K,nrow=T));names(S)<-colnames(M);S[1,]<-No
   for(t in 2:T){#lets contruct the system and then run it T-1 times
   #grows -> migrates
    for (k in 1:K){
    S[k,
    }
   }
return(list(M,G,S))
}
coupled.dynamics(K=7,prob=c(.25,.75),T=100,f=f1,No=10,plot=TRUE)