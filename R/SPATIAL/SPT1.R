library("ncdf")
d=open.ncdf("M:\\serie 2031-2060.nc")
lon=get.var.ncdf(d,"longitude");lat=get.var.ncdf(d,"latitude")
data=get.var.ncdf(d,verbose=F)
library(fields)
image.plot(lon,lat,data[,,2]);windows()
temp=data[,,2]
image.plot(lon,lat,temp)
#################
coords=expand.grid(lon,lat);names(coords)=c("x","y")
dt=data.frame(T=as.vector(temp)-273,coords)
##################
datum=data.frame(read.table("M:\\COMPT.txt",T))
s1=lm(M ~ T + I(T^2) + I(T^3)+I(T^4),data=datum)
t=ifelse(dt$T<10,10,dt$T)
#t=dt$T
Sp=predict(s1,newdata=data.frame(T=t))
TEMP=matrix(Sp,ncol=64,nrow=128);TEMP2=ifelse(TEMP<0,0,TEMP)
image.plot(lon,lat,TEMP2,main="Tamanho médio de progenie")
#write.table(temp-273,file="F:\\RHODI-2\\emformadetabela.txt",sep="\t")