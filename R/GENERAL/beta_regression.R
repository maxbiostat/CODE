# # Beta regression on survival proportions # WARNING: IT IS FLAWED
library(betareg)
psurvdata<-data.frame(read.table("Dropbox/Compartilhada_Luiz-L.Ricardo/REPORT_MODELAGEM/data/oncopeltus_psurv.txt",T))
psurvdata$psurv[which(psurvdata$psurv>.999)]<-.999
mb<-betareg(psurv~day+SEX*STATUS,data=psurvdata,link="probit");summary(mb)
## plotting
p.surv<-predict(mb)
se.p<-sqrt(mean((psurvdata$psurv-p.surv)^2))/sqrt(length(p.surv))
conf.band<-function(x,sd,alfa){
  lwr=x-qnorm(alfa/2)*sd
  upr=x+qnorm(alfa/2)*sd  
  return(data.frame(lwr,upr))}
bands.psurv<-conf.band(p.surv,se.p,.05)
bigdt.surv<-data.frame(psurvdata,p.surv,bands.psurv)
#bigdt$Infectious_status<-factor(ifelse(bigdt$STATUS==0,1,0),labels=c("Infected", "Uninfected"))# monstruous trick to fool ggplot
#
ggplot(bigdt.surv, aes(x = day, y =p.surv)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = GROUP),alpha=.2) +
  scale_x_continuous("Time (days)") +
  scale_y_continuous("Survival proportion") +
  guides(fill=FALSE)+
  geom_line(aes(colour = GROUP),size = 1)

