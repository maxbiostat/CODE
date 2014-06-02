summary.t.test<-function(m1,m2,s1,s2,n1,n2,level,tails,eq.var,paired,sum.var){
  s1=s1^2;s2=s2^2# turn SDs into variances
#define the type of test
 if(paired=="TRUE" && n1!=n2){cat (" For paired T-test sample sizes must be equal", "\n")}
 else
  if (paired=="TRUE"){df=n1-1,stat=(m1-m2)*sqrt((n1^2-n1)/(sum.var))}
  else if (eq.var=="TRUE"){df=n1+n2-2;s=sqrt(((n1-1)*s1+(n2-1)*s2)/df);stat=(m1-m2)/(s*sqrt(1/n1+1/n2))}
       else df=((s1/n1+s2/n2)^2)/(((s1/n1)^2)/(n1-1)+((s2/n2)^2)/(n2-1))
            stat= (m1-m2)/sqrt(s1/n1+s2/n2)
# Now lets set the confidence
       if (tails==1){p.crit=1-level}
       else p.crit=(1-level)/2
# Finally calculate the p-value

return(list(t=stat,df=df,p-value=p))}
#################
#simulating data 
#set.seed(82939)
x<-rnorm(100,3,2)
y<-rnorm(50,10,8)
#standard 'raw' t.test
t.test(x,y,alternative="two.sided",var.equal=FALSE)
#test for aggregated data
m1=mean(x);m2=mean(y);s1=sd(x);s2=sd(y);n1=length(x);n2=length(y)
#s1=s1^2;s2=s2^2;df=((s1/n1+s2/n2)^2)/(((s1/n1)^2)/(n1-1)+((s2/n2)^2)/(n2-1));df
#summary.t.test(m1=m1,m2=m2,n1=n1,n2=n2,s1=s1,s2=s2,tails=2,eq.var=FALSE)
