### Simple linear mixed effects example using the nlme library
library(nlme)
sleepstudy <- data.frame(read.table("sleep.txt", TRUE))
(dm1 <- lme(Reaction~Days, random = ~1|Subject, sleepstudy))
(dm2 < -lme(Reaction~Days, random = ~1|Subject,
          correlation = corAR1(form = ~Days|Subject), sleepstudy))
##
p1 <- predict(dm1)
p2 <- predict(dm2)
#
plot(density(sleepstudy$Reaction), ylim = c(0,.01), main="",xlab = "Tempo de Reacao")
lines(density(p1), col = 2)
lines(density(p2), col = 3)
legend(400, .007, legend = c("Dados", "modelo 1", "modelo 2"),
       lty = rep(1,3), col = c(1,2,3))
