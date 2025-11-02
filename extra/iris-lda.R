#' ---
#' title: Plotting discriminant analysis in discriminant space
#' ---

library(MASS)
library(car)

iris.lda <- lda(Species ~ ., iris)
iris.lda
names(iris.lda)

#' Get the scores for observations on the discriminent axes
iris.scores <- data.frame(
  Species = iris$Species,
  predict(iris.lda)$x)


col <- scales::hue_pal()(3)
dataEllipse(LD2 ~ LD1 | Species, data=iris.scores, 
            levels = 0.68, 
            fill = TRUE, fill.alpha = 0.05,
            col = col,
            pch = 15:17,
            grid = FALSE,
            label.pos = "top",
            label.cex = 1.8,
            asp = 1)
abline(h=0, v=0, col = "grey")

vecs <- iris.lda$scaling
rownames(vecs) <- sub("\\.", "\n", rownames(vecs))
vecs

vectors(vecs, col = "black", lwd = 2,
        scale = vecscale(vecs), xpd = TRUE)
