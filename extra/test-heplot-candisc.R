library(heplots)
library(candisc)
#library(car)
# NB: changed contrast order
data(iris)
#contrasts(iris$Species) <- matrix(c(0,-1,1, 2, -1, -1), 3,2)
contrasts(iris$Species) <- matrix(c(1,-1/2,-1/2,  0, 1, -1), nrow=3, ncol=2)
contrasts(iris$Species)

iris.mod <- lm(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~
                 Species, data=iris)

iris.can <- candisc(iris.mod) 

iris_colors <-c("blue", "darkgreen", "brown4")
clr <- c(iris_colors, "red")

vars <- names(iris)[1:4] |> 
  stringr::str_replace("\\.", "\n")
plot(iris.can,
     var.labels = vars,
     var.col = "black",
     var.lwd = 2,
     ellipse=TRUE,
     scale = 9,
     col = iris_colors,
     pch = 15:17,
     cex = 0.7, var.cex = 1.25,
     rev.axes = c(TRUE, FALSE),
     xlim = c(-10, 10),
     cex.lab = 1.5)

heplot(iris.can,
       size = "effect",
       scale = 8,
       var.labels = vars,
       var.col = "black",
       var.lwd = 2,
       fill = TRUE, fill.alpha = 0.2,
       rev.axes = c(TRUE, FALSE),
       xlim = c(-10, 10))

