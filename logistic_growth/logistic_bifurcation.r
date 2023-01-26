library(ggplot2)
ini.x <- 1/2
rmin <- 2
rmax <- 4
out.df <- matrix(NA, ncol = 2, nrow = 0)
a <- 0.01
r <- seq(rmin, rmax, by = 0.01)
n <- 100
tcutoff <- 40

for (z in 1:length(r)) {
  xl <- vector()
  xl[1] <- ini.x
  for (i in 2:n) {
    xl[i] <- xl[i - 1] * r[z] * (1- xl[i-1])
  }
  uval <- unique(xl[tcutoff:n])
  ### Here is where we can save the output for ggplot
  out.df <- rbind(out.df, cbind(rep(r[z], length(uval)), uval))
}
out.df <- as.data.frame(out.df)
colnames(out.df) <- c("r", "N")

ggplot(out.df, aes(x = r, y = N)) +
  geom_point(size = 0.5) +
  scale_x_continuous(expression(lambda)) +
  scale_y_continuous(expression(N))+
  theme_bw(base_size = 16)
