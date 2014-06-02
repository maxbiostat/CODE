###Instalacao
install.packages(c("sp","spdep","gstat","geoR","BSDA","geoRglm","maptools","caTools","RColorBrewer",
"mcmc","ape","phylotools","phyclust","pwr","igraph","sampling","mgcv","odesolve","splancs","edesign",
"adegenet","phylotools","spatstat","polycor","colorspaces","R2WinBUGS","BRugs","multicore"))#,repos="http://cran.us.r-project.or")

install.packages(c('inline','Rcpp'))
options(repos = c(getOption("repos"), rstan = "http://wiki.rstan-repo.googlecode.com/git/"))
install.packages('rstan', type = 'source')
