library(BSDA)
test<-data.frame()
for (n in 2:30){
test[n,1]<-n
test[n,2]<-tsum.test(mean.x=5, s.x =2, n.x =n, mean.y =55 , s.y =14, n.y =n, alternative = "two.sided", var.equal = FALSE, conf.level = 0.95)$p.value
test[n,3]<-tsum.test(mean.x=5, s.x =2, n.x =n, mean.y =55 , s.y =14, n.y =n, alternative = "two.sided", var.equal = FALSE, conf.level = 0.95)$statistic
test[n,4]<-tsum.test(mean.x=90, s.x =10, n.x =n, mean.y =55 , s.y =14, n.y =n, alternative = "two.sided", var.equal = FALSE, conf.level = 0.95)$p.value
test[n,5]<-tsum.test(mean.x=90, s.x =10, n.x =n, mean.y =55 , s.y =14, n.y =n, alternative = "two.sided", var.equal = FALSE, conf.level = 0.95)$statistic
}
names(test)<-c("N","pT1","tT1","pT2","tT2")
plot(pT1~N,test,type="l",lwd=2,xlab="Number of Observations",ylab="Yielded p-value")
lines(pT2~N,test,type="l",col=2,lwd=2)
lines(test$N,rep(0.05,length(test$N)),col=3,lty=2,lwd=2)
legend(12,.12,legend=c("prM vs. prM+70-21 mAb","prM+70-21 mAb vs. wt","95 % significance threshold"),col=c(1,2,3),lty=c(1,1,2),lwd=c(2,2,2))
######
plot(tT1~N,test,type="l",lwd=2,ylim=c(-20,12),xlab="Number of Observations",ylab="Calculated t-statistic")
lines(tT2~N,test,type="l",col=2,lwd=2)



