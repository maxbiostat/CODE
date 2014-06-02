for (i in 1:10){
cat(system.time(crossprod(matrix(rnorm(10000000),ncol=100))),"\n");flush.console()
}