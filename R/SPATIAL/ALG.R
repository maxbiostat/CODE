#source("http://www.bioconductor.org/biocLite.R")
#biocLite("Ruuid")
#biocLite("graph")
#biocLite("Rgraphviz")
#install.packages("igraph")
###########################################################################
require(igraph);require(spdep)
bh = readShapePoly(system.file("etc/shapes/bhicv.shp",package="spdep")[1])
cn=poly2nb(bh,row.names =bh$Name)# contiguity neighborhood
im=nb2mat(cn,style="B")#creating the binary incidence matrix
data = data.frame(scale(bh@data[,5:8]))# scaling the data
m=dist(data,method="euclidean",diag=T,upper=T);M=as.matrix(m)#calculating the matrix of normalized euclidean distances 
#graphing
hist(m,main="Distribution of Normalized Euclidean Distances")
hist(rowSums(im),main="Degree Distribution of the Incidence Contiguity Graph")
##########
#setting the transition algorithm
trans<-function(M){
T=seq(0,1,by=.01)
TA=array(NA,dim=c(dim(M)[1],dim(M)[2],length(T)))
for (t in T){
tim=ifelse(M/max(M)>=t,1,0)
i=match(t,T) 
TA[,,i]=tim
}
return(TA)
}
##############
con=function(x){
MC=rep(NA,dim(x)[3])
for (i in 1:dim(x)[3]){
mc=mean(rowSums(x[,,i]))
MC[i]=mc
}
return(MC)
}
plot(seq(0,1,by=0.01),con(trans(M)),type="l",xlab="S_min",ylab="Mean Connected Edges")
##################
Tr=trans(M)
tM<- mat2listw(Tr[,,match("0.8",seq(0,1,by=.01))])
mbound=function(M,bM) 
tMb<-
plot(bh)
plot(tMb,coordinates(bh),add=T)
