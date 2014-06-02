####################################Coupled Dynamics############################
################################################################################
library(igraph)
K<-4 # number of nodes
M<-matrix(sample(0:1,K^2,prob=c(.5,.5),replace=T),ncol=K);diag(M)<-0;M<-conv.mat(M)
colnames(M) <- LETTERS[1:K];rownames(M) <-LETTERS[1:K]
G<-graph.adjacency(M,mode="undirected");is.connected(G)
G$name<-colnames(M);plot(G,vertex.label=G$name);windows()
hist(degree(G))
############################################
#population growth functions
f1<-function(p) .1*p
f2<-function(p) exp(4*(1-(p/1000)))
f3<-function(p) .3*p+10
f4<-function(p) 30*sin(.05*p)^2
func<-list(f1,f2,f3,f4)
w<-function(n) rgamma(n, .5, rate = .1, scale = .1)# gamma rate of migration
############################################
coupled.dynamics<-function(K,T,No,F){
 M<-matrix(sample(0:1,K^2,prob=c(.75,.25),replace=T),ncol=K);diag(M)<-0;M<-conv.mat(M)
 G<-graph.adjacency(M,mode="undirected");G$name<-colnames(M)
 S<-data.frame(matrix(NA,ncol=K,nrow=T));names(S)<-colnames(M);S[1,]<-No
  for(t in 2:T){#lets contruct the system and then run it T-1 times
  #grows -> migrates
   for (k in 1:K){
   S[k,
   }
  }
return(list(M,G,S)}
coupled.dynamics(K=5,T=100,No=10,F=func)
###
#f1=E,C
#f2=A
#f3=D
###
for (t in 2:T){
  S[t,1]<- f1(S[t-1,1])+w(1)*S[t-1,1]+w(1)*S[t-1,5]+w(1)*S[t-1,3]#A
  S[t,2]<- S[t-1,2]+w(1)*S[t-1,5]#B
  S[t,3]<- f1(S[t-1,3])+w(1)*S[t-1,1]+w(1)*S[t-1,4]+w(1)*S[t-1,5]#C
  S[t,4]<- f3(S[t-1,4])+w(1)*S[t-1,1]+w(1)*S[t-1,3]#D
  S[t,5]<- f1(S[t-1,5])+w(1)*S[t-1,1]+w(1)*S[t-1,3]+w(1)*S[t-1,2]#E
}
plot(1:T,rowSums(S),type="l",main="Total N",xlab="Time",ylab="Population Size");windows()
plot(1:T,S$A,type="l",lwd=2,ylab="N",xlab="Time",ylim=c(0,max(S)))
lines(1:T,S$B,col=2,lwd=2)
lines(1:T,S$C,col=3,lwd=2)
lines(1:T,S$D,col=5,lwd=2)
lines(1:T,S$E,col="blue",lwd=2)
legend(x="topright",horiz=T,cex=.85,legend=paste(LETTERS[1:K]),lwd=rep(2,5),col=c(1,2,3,5,"blue"))
