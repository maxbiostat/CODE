quant.exp<-function(x,by){
q<-seq(0,1,by)
Q<-data.frame(matrix(NA,ncol=2,nrow=length(q)))
for ( i in q){
n<-match(i,q)
Q[n,1]<-i
Q[n,2]<-table(ifelse(x>quantile(x,prob=i),1,0))[2]/sum(table(ifelse(x>i,1,0)))
}
plot(Q,type="l")
}
QQ<-quant.exp(rpois(100,l=2),by=0.01)