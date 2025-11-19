library(MASS)
library(ggplot2)
library(dplyr)
library(patchwork)

iris.lda <- lda(Species ~ ., iris)
# Test with tile display (default)
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, showgrid = "tile")

# Test with point display
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, showgrid = "point")

# Test with no grid
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, showgrid = "none")


iris.qda <- qda(Species ~ ., iris)
plot_discrim(iris.qda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile")

# Define custom colors and shapes
iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17

# Fit the model
iris.lda <- lda(Species ~ ., iris)

# Create plot with custom colors and shapes
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch)

# data ellipses
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            ellipse = TRUE) 
  
  
#   data(peng, package = "heplots")
# #  source("R/penguin/penguin-colors.R")
#   source("C:/R/Projects/Vis-MLM-book/R/penguin/penguin-colors.R")
#   
#   # use penguin colors
#   peng.lda <- lda(species ~  bill_length + bill_depth + flipper_length + body_mass, data = peng)
#   plot_discrim(peng.lda, bill_length ~ bill_depth, data=peng, showgrid = "tile") +
#     scale_color_penguins()
#   
#   peng.qda <- qda(species ~  bill_length + bill_depth + flipper_length + body_mass, data = peng)
#   plot_discrim(peng.qda, bill_length ~ bill_depth, data=peng, showgrid = "point") +
#     scale_color_penguins()
  
# Plots to advertise package

p1 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            contour = FALSE,
            ellipse = TRUE) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  theme_minimal(base_size = 16) +
  theme(legend.position = "inside",
        legend.position.inside = c(.8, .2))

p2 <- plot_discrim(iris.qda, Petal.Length ~ Petal.Width, 
            contour = FALSE,
            ellipse = TRUE) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  theme_minimal(base_size = 16) +
  theme(legend.position = "inside",
        legend.position.inside = c(.8, .2))

p1 + p2

# plot in discriminant space
# 
iris_scored <- predict_discrim(iris.lda, scores=TRUE)
head(iris_scored)

iris.lda2 <- lda(Species ~ LD1 + LD2, data=iris_scored)
iris.lda2

plot_discrim(iris.lda2, LD2 ~ LD1,
             contour = FALSE,
             ellipse = TRUE) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  theme_minimal(base_size = 16) 


############################################################
# Test new LDA plots
############################################################
############################################################

#source(here::here("extra/plot_discrim-labs.R"))

# Basic discriminant space plot
plot_discrim(iris.lda, LD2 ~ LD1)

# With ellipses and labels
plot_discrim(iris.lda, LD2 ~ LD1, 
             ellipse = TRUE,
             labels = TRUE)

# Comprehensive styled plot

plt <- plot_discrim(iris.lda, LD2 ~ LD1,
             contour = FALSE,
             ellipse = TRUE,
             labels = TRUE,
             labels.args = list(geom = "label")) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")
plt


# add variable vectors
# 
vecs <- cor_lda(iris.lda)
vecs

# make a tidy data frame for gggda::geom_vector
# or, maybe use geom_arrow?
vecs <- vecs |>
  as.data.frame() |>
  tibble::rownames_to_column(var = "label") |>
  mutate(label = stringr::str_replace(label, "\\.", "\n")) |>
  print()

plt +
  gggda::geom_vector(
    data = vecs,
    aes(x = 4 * LD1, y = 4 * LD2, label = label),
    lineheight = 0.8, linewidth = 1.25, size = 5
  ) +
  coord_equal()

