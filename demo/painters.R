#' ---
#' title: HE plots and candisc HE plots for MASS::painters data
#' author: Michael Friendly
#' ---

#' ## Load packages and the dataset
library(MASS)
library(heplots)
library(ggplot2)
library(dplyr)

data(painters, package = "MASS")
str(painters)

#' ## Use longer labels to identify the schools
school <- c("Renaissance", "Mannerist", "Sciento", "Venetian",
		"Lombard", "16th C", "17th C", "French")
levels(painters$School) <- school
head(painters)

#' ## How many from each school?
table(painters$School)

#' ## Exploratory plots
ggplot(data = painters, aes(x = School, y = Colour, fill = School)) +
  geom_boxplot() +
  labs(title = "Colour Scores Distribution by Painting School",
       x = "School",
       y = "Colour Score (0-20)") +
  theme_bw()

#' ## Reshape to long format for plotting multiple variables
painters_long <- painters |>
  tidyr::pivot_longer(cols = c(Composition, Drawing, Colour, Expression),
                      names_to = "Metric", values_to = "Score")

ggplot(painters_long, aes(x = Metric, y = Score, fill = Metric)) +
  geom_violin(alpha = 0.3) +
  geom_jitter(width = 0.1) +
  labs(title = "Distribution of De Piles' Scores",
       y = "Score (0-20)") +
  theme_light() +
  theme(legend.position = "none") # no need for a legend

#' ## Sample scatterplots

means <- painters |>
  group_by(School) |>
  summarise(across(Composition:Expression, mean))

ggplot(painters,
       aes(Composition, Colour,
           color = School, shape = School)) +
  geom_point(size=3) +
  stat_ellipse(level = 0.68, linewidth = 1.3) +
  geom_label(data = means,
             aes(label = School)) +
  scale_shape_manual(values = c(16, 17, 15, 9, 7, 8, 10, 5)) +
  theme_classic(base_size = 15) +
  theme(legend.position = "none")

ggplot(painters,
       aes(Drawing, Expression,
           color = School, shape = School)) +
  geom_point(size=3) +
  stat_ellipse(level = 0.68, linewidth = 1.3) +
  geom_label(data = means,
             aes(label = School)) +
  scale_shape_manual(values = c(16, 17, 15, 9, 7, 8, 10, 5)) +
  theme_classic(base_size = 15) +
  theme(legend.position = "none")

  
#' ## MANOVA: 
#' How do the various schools differ according to the aesthetic qualities?
painters.mod <- lm(cbind(Composition, Drawing, Colour, Expression) ~ School, data=painters)
coef(painters.mod)

#' ## Check for multivariate outliers
cqplot(painters.mod, id.n = 3)

#' ## HE plots
#' By default, it plots the first two variables
heplot(painters.mod,
       fill = TRUE, fill.alpha = c(0.1, 0.05),
       cex.lab = 1.25)

#' Specify `variables` for other variables
heplot(painters.mod,
       variables = 3:4,
       fill = TRUE, fill.alpha = c(0.1, 0.05),
       cex.lab = 1.25)

#' All pairwise HE pots
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



