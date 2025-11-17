#' ---
#' title: HE plots and candisc HE plots for MASS::painters data
#' author: Michael Friendly
#' ---

library(MASS)
library(heplots)

data(painters, package = "MASS")

#' Use longer labels to identify the schools
school <- c("Renaissance", "Mannerist", "Sciento", "Venetian",
		"Lombard", "16th C", "17th C", "French")
levels(painters$School) <- school
head(painters)

#' How many from each school?
table(painters$School)

#' ## MANOVA: how do the schools differ according to the aesthetic qualities?
painters.mod <- lm(cbind(Composition, Drawing, Colour, Expression) ~ School, data=painters)
coef(painters.mod)

#' ## HE plots
#' By default, plots the first two variables
heplot(painters.mod,
       fill = TRUE, fill.alpha = c(0.1, 0.05),
       cex.lab = 1.25)

heplot(painters.mod,
       variables = 3:4,
       fill = TRUE, fill.alpha = c(0.1, 0.05),
       cex.lab = 1.25)

pairs(painters.mod)

#' ## Canonical analysis
#' How many dimensions of differences?
painters.can <- candisc(painters.mod)
painters.can
summary(painters.can)

#' ## HE plot in canonical space
heplot(painters.can,
       fill = TRUE, fill.alpha = c(0.1, 0.05),
       var.lwd = 2, var.cex = 1.4,
       cex.lab = 1.25)



#' ## 3D view
#' There seem to be 3 significant dimensions. View it in 3D
if(requireNamespace("rgl")){
  heplot3d(painters.can, col=c("pink", "brown"))
}
						
#' ## Discriminant analysis
#'
painters.lda <- lda(School ~ Composition + Drawing + Colour + Expression,
                    data = painters) 		
painters.lda

class_table <- table(
  actual = painters$School,
  predicted = predict(painters.lda)$class)


plot_discrim(painters.lda, LD2 ~ LD1,
             labels = TRUE, 
             labels.args = list(geom = "label")) +
  scale_shape_manual(values = c(16, 17, 15, 9, 7, 8, 10, 5)) +
  theme_classic(base_size = 15) +
  theme(legend.position = "none")

# Dimensions 1 & 3
plot_discrim(painters.lda, LD3 ~ LD1,
             labels = TRUE, 
             labels.args = list(geom = "label")) +
  scale_shape_manual(values = c(16, 17, 15, 9, 7, 8, 10, 5)) +
  theme_classic(base_size = 15)



