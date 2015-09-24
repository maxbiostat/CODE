## Taken from http://lingpipe-blog.com/2009/06/25/log-sum-of-exponentials/
## Imagine you want to compute z = log(sum(exp(x_i)))
## This may give you an overflow for x_i big enough
## See the link for the derivation of this stabilised version

naiveLogSumExp <- function(x){
  z <- log(sum(exp(x)))
  return(z)
}
stabLogSumExp <- function(x){
  m <- max(x)
  z <- m + log(sum(exp(x-m)))
  return(z)
}
###
test.small <- c(13, 15, 17, 19)
naiveLogSumExp(test.small)
stabLogSumExp(test.small)

test.big <- c(1E+13, 1E+15, 1E+17, 1E+19)
naiveLogSumExp(test.big)
stabLogSumExp(test.big)

