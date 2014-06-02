## The effect of skewness of the weights matrix on the optimal number of clusters (Ko)
library(cluster)
#simu.pam<-function(l,niter){
pam.optim<-function(d){
d <- as.matrix(d)
opt <- data.frame(matrix(NA, ncol = 2, nrow = nrow(d)-2))
names(opt)<-c("K","Obj")
for (k in 2:(ncol(d)-1)){
opt[match(k, 2:(ncol(d)-1)), 1] <- k
opt[match(k, 2:(ncol(d)-1)), 2] <- (kmeans(diss, centers = k)$tot.withinss)/
  (kmeans(diss, centers = k)$totss)
}
return(opt)}
#####################################
data.simu <- function(ncol, mi, n){
x <- data.frame(matrix(NA, ncol = ncol, nrow = n))
names(x) <- paste("V", 1:ncol)
for (c in 1:ncol){
x[,c] <- mean(x[, c-1])
x[,c] <- rnorm(n, mi)
}
return(x)
}
data.simu(ncol = 10, mi = 2, n = 5)
######################################
diss <- dist(data.simu(ncol = 50, mi = 2, n = 100))
plot(pam.optim(diss))

