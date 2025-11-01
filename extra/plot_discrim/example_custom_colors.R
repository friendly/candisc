## Complete Example: Custom Colors and Shapes for Iris LDA
## This script demonstrates how to customize plot_discrim() visualizations

library(MASS)
library(ggplot2)

# Source the updated plot_discrim function
source("plot_discrim.R")

# Define custom colors and shapes for the three iris species
iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17

# Fit the LDA model
iris.lda <- lda(Species ~ ., iris)

# ============================================================
# Example 1: Tile visualization with custom colors and shapes
# ============================================================
cat("Example 1: Tile visualization with custom colors\n")

p1 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  labs(title = "LDA with Tiles - Custom Colors")

print(p1)

# ============================================================
# Example 2: Point visualization with custom colors and shapes
# ============================================================
cat("\nExample 2: Point visualization with custom colors\n")

p2 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data = iris, showgrid = "point") +
  scale_color_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  labs(title = "LDA with Points - Custom Colors")

print(p2)

# ============================================================
# Example 3: No grid, only boundaries with custom colors
# ============================================================
cat("\nExample 3: Boundaries only with custom colors\n")

p3 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data = iris, showgrid = "none") +
  scale_color_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  labs(title = "LDA Boundaries Only - Custom Colors")

print(p3)

# ============================================================
# Example 4: Fully customized publication-quality plot
# ============================================================
cat("\nExample 4: Publication-quality plot\n")

p4 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data = iris, 
                  showgrid = "tile",
                  point.size = 3,
                  contour.color = "black") +
  scale_color_manual(values = iris.colors,
                     name = "Species",
                     labels = c("I. setosa", "I. versicolor", "I. virginica")) +
  scale_fill_manual(values = iris.colors,
                    name = "Species",
                    labels = c("I. setosa", "I. versicolor", "I. virginica")) +
  scale_shape_manual(values = iris.pch,
                     name = "Species",
                     labels = c("I. setosa", "I. versicolor", "I. virginica")) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray40"),
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  labs(title = "Linear Discriminant Analysis of Iris Dataset",
       subtitle = "Classification boundaries between three species",
       x = "Petal Length (cm)",
       y = "Sepal Length (cm)")

print(p4)

# Save the publication-quality plot
ggsave("iris_lda_publication.png", p4, width = 10, height = 7, dpi = 300)
cat("\nPlot saved as 'iris_lda_publication.png'\n")

# ============================================================
# Example 5: Using named vectors for explicit control
# ============================================================
cat("\nExample 5: Using named vectors\n")

# Named vectors ensure explicit mapping to species names
iris.colors.named <- c("setosa" = "red", 
                       "versicolor" = "darkgreen", 
                       "virginica" = "blue")

iris.pch.named <- c("setosa" = 15, 
                    "versicolor" = 16, 
                    "virginica" = 17)

p5 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors.named) +
  scale_fill_manual(values = iris.colors.named) +
  scale_shape_manual(values = iris.pch.named) +
  labs(title = "LDA with Named Color/Shape Vectors")

print(p5)

# ============================================================
# Example 6: Comparison of all three showgrid options
# ============================================================
cat("\nExample 6: Side-by-side comparison\n")

library(gridExtra)

p_tile <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                      data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  ggtitle('showgrid = "tile"') +
  theme_minimal()

p_point <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                       data = iris, showgrid = "point") +
  scale_color_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  ggtitle('showgrid = "point"') +
  theme_minimal()

p_none <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                      data = iris, showgrid = "none") +
  scale_color_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  ggtitle('showgrid = "none"') +
  theme_minimal()

# Arrange in a grid
grid.arrange(p_tile, p_point, p_none, ncol = 3)

cat("\nAll examples completed successfully!\n")
