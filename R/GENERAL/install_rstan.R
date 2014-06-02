install.packages(c('inline','Rcpp'))
options(repos = c(getOption("repos"), rstan = "http://wiki.rstan-repo.googlecode.com/git/"))
install.packages('rstan', type = 'source')
