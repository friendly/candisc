# LDA / QDA for iris data
# From: https://www.geeksforgeeks.org/data-analysis/quadratic-discriminant-analysis/

# import libraries
library(caret)
library(MASS)
library(tidyverse)

# Code to plot decision plot
decision_boundary <- function(model, data,vars, resolution = 200,...) {
  class <- 'Species'
  labels_var <- data[,class]
  k <- length(unique(labels_var))
  # For sepals
  if (vars == 'sepal'){
  data <- data %>% select(Sepal.Length, Sepal.Width)
  }
  else{
  data <- data %>% select(Petal.Length, Petal.Width)
  }
  
  
  # plot with color labels
  int_labels <- as.integer(labels_var)
  plot(data, col <- int_labels+1L, pch = int_labels+1L, ...)
  
  # make grid
  r <- sapply(data, range, na.rm = TRUE)
  xs <- seq(r[1,1], r[2,1], length.out = resolution)
  ys <- seq(r[1,2], r[2,2], length.out = resolution)
  dfs <- cbind(rep(xs, each=resolution), rep(ys, time = resolution))
  
  colnames(dfs) <- colnames(r)
  dfs <- as.data.frame(dfs)
  
  p <- predict(model, dfs, type ='class' )
  p <- as.factor(p$class)

  
  points(dfs, col = as.integer(p)+1L, pch = ".")
  
  mats <- matrix(as.integer(p), nrow = resolution, byrow = TRUE)
  contour(xs, ys, mats, add = TRUE, lwd = 2, levels = (1:(k-1))+.5)
  
  invisible(mats)
}

op <- par(mfrow=c(2,2))
# run the linear discriminant analysis and plot the decision boundary with Sepals variable
model <- lda(Species ~ Sepal.Length + Sepal.Width, data=iris)
lda_sepals <- decision_boundary(model, iris, vars= 'sepal' , main = "LDA_Sepals")

# run the quadratic discriminant analysis and plot the decision boundary with Sepals variable
model_qda <- qda(Species ~ Sepal.Length + Sepal.Width, data=iris)
qda_sepals <- decision_boundary(model_qda, iris, vars= 'sepal', main = "QDA_Sepals")

# run the linear discriminant analysis and plot the decision boundary with Petals variable
model <- lda(Species ~ Petal.Length + Petal.Width, data=iris)
lda_petal =decision_boundary(model, iris, vars='petal', main = "LDA_petals")

# run the quadratic discriminant analysis and plot the decision boundary with Petals variable
model_qda <- qda(Species ~ Petal.Length + Petal.Width, data=iris)
qda_petal =decision_boundary(model_qda, iris, vars='petal', main = "QDA_petals")
par(op)

