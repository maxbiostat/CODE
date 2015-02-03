## Code to detect outliers in a vector x
## Copyleft (or the one to blame): Carvalho, LMF (2014)
## Main idea taken from http://stackoverflow.com/questions/12866189/calculating-the-outliers-in-r
outliers <- function(x){
  ## this function will find which values in a vector x are
  ## mild or extreme outliers
  lowerq <- as.numeric(quantile(x, probs = .25)) # First quartile
  upperq <- as.numeric(quantile(x, probs = .75)) # Third quartile
  iqr <- upperq - lowerq   # Inter-quartile range
  # Mild outliers
  mild.threshold.lower <- lowerq - (iqr * 1.5)
  mild.threshold.upper <- (iqr * 1.5) + upperq
  # Extreme outliers
  extreme.threshold.lower <- lowerq - (iqr * 3)
  extreme.threshold.upper <- (iqr * 3) + upperq
  mild <- extreme <- vector(2, mode = "list")
  names(mild) <- names(extreme) <- c("low", "high")
  mild[[1]] <- x[which(x < mild.threshold.lower)]
  mild[[2]] <- x[which(x > mild.threshold.upper)]
  extreme[[1]] <- x[which(x < extreme.threshold.lower)]
  extreme[[2]] <- x[which(x > extreme.threshold.upper)]
  
  return(list(Mild = mild, Extreme = extreme))
}
# install.packages("outliers") # uncomment to install the package
library(outliers)
set.seed(12345)
# y <- rnorm(100) # 100 random samples from the standard (m = 0, sd = 1) Gaussian
# outliers(y)
# outlier(y)
###########################

# outlier() returns the value in x that is farthest from the sample mean
# since it CAN be an outlier
# outliers() calculates the interquartile range (IQR) and
# returns values of x which are mild and extreme outliers

wt <- c(9.570016, 9.014795, 19.3106, 10.07331,
        9.410151, 10.4062, 12.35741, 14.83612)

outliers(wt)
outlier(wt)

app <- c(11.42724, 13.93081, 11.65813, 12.35741)
outliers(app)
outlier(app)
