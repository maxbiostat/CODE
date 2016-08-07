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
test.small <- c(3, 5, 7, 9)
naiveLogSumExp(test.small)
stabLogSumExp(test.small)

test.big <- c(130, 150,170, 190)
naiveLogSumExp(test.big)
stabLogSumExp(test.big)