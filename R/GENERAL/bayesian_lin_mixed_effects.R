## Simple example of Bayesian linear mixed effects using the blme library
library(blme)
#################################################################################
(bm1 <- blmer(Reaction ~ Days + (Days|Subject), sleepstudy, cov.prior="gamma"))
(bm2 <- blmer(Reaction ~ Days + (Days|Subject), sleepstudy, cov.prior="gamma(shape = 2, rate = 0.5, posterior.scale='sd')"))
(bm3 <- blmer(Reaction ~ Days + (1 + Days|Subject), sleepstudy, cov.prior="wishart"))
(bm4 <- blmer(Reaction ~ Days + (1 + Days|Subject), sleepstudy, cov.prior="inverse.wishart(df = 5, inverse.scale = diag(0.5, 2))"))
(bm5 <- blmer(Reaction ~ Days + (1 + Days|Subject), sleepstudy, cov.prior = "none", fixef.prior="normal"))
(bm6 <- blmer(Reaction ~ Days + (1 + Days|Subject), sleepstudy, cov.prior = "none",fixef.prior="normal(cov = diag(0.5, 2), posterior.scale='absolute')"))
#################################################################################
predict.blme <- function (m) sleepstudy$Reaction-m@resid
p1 <- predict.blme(bm1)
p2 <- predict.blme(bm2)
p3 <- predict.blme(bm3)
p4 <- predict.blme(bm4)
p5 <- predict.blme(bm5)
p6 <- predict.blme(bm6)
####
plot(density(sleepstudy$Reaction),type="l",col=1,ylim=c(0,0.009),main="",xlab="Tempo de Rea??o")
lines(density(p4), col=2)
lines(density(p5), col=3)
lines(density(p6), col="blue")
legend(400,.007, legend = c("Dados","modelo 1","modelo 2","modelo 3"),
       lty = rep(1, 4), col = c(1, 2, 3, "blue"))
