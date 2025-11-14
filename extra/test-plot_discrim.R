library(MASS)
library(ggplot2)
library(dplyr)

# Source the modified function
source(here::here("extra", "plot_discrim.R"))  # Adjust path as needed

# Create LDA model with all 4 iris variables
iris.lda <- lda(Species ~ ., iris)

cat("========================================\n")
cat("Testing plot_discrim() function\n")
cat("========================================\n\n")

# ==============================================================================
# Basic functionality tests
# ==============================================================================
cat("BASIC FUNCTIONALITY\n")
cat("-------------------\n")

# Test 1: formula call: y ~ x
cat("Test 1: Basic plot with formula\n")
p1 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width)
print(p1)

# Test 2: character vector specification
cat("\nTest 2: Basic plot with character vector\n")
p2 <- plot_discrim(iris.lda, c("Petal.Width", "Petal.Length"))
print(p2)

# ==============================================================================
# Ellipse tests
# ==============================================================================
cat("\n\nELLIPSE CUSTOMIZATION\n")
cat("---------------------\n")

# Test 3: add data ellipses (default)
cat("Test 3: Add data ellipses with defaults\n")
p3 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                   ellipse = TRUE)
print(p3)

# Test 4: filled ellipses with transparency
cat("\nTest 4: Filled ellipses with transparency\n")
p4 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                   ellipse = TRUE,
                   ellipse.args = list(geom = "polygon", alpha = 0.2))
print(p4)

# Test 5: customize ellipse level and line thickness
cat("\nTest 5: Custom ellipse level (95%) and line thickness\n")
p5 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                   ellipse = TRUE,
                   ellipse.args = list(level = 0.95, linewidth = 2))
print(p5)

# ==============================================================================
# Contour and grid tests
# ==============================================================================
cat("\n\nCONTOUR AND GRID OPTIONS\n")
cat("------------------------\n")

# Test 6: without contours
cat("Test 6: Plot without contours\n")
p6 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                   contour = FALSE)
print(p6)

# Test 7: point grid instead of tiles
cat("\nTest 7: Using point grid instead of tiles\n")
p7 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                   showgrid = "point")
print(p7)

# Test 8: no grid
cat("\nTest 8: No grid display\n")
p8 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                   showgrid = "none")
print(p8)

# ==============================================================================
# Label tests
# ==============================================================================
cat("\n\nLABEL CUSTOMIZATION\n")
cat("-------------------\n")

# Test 9: Basic labels
cat("Test 9: Add class labels with default settings\n")
p9 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                   labels = TRUE)
print(p9)

# Test 10: Labels with geom = "label"
cat("\nTest 10: Labels with background boxes\n")
p10 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                    labels = TRUE,
                    labels.args = list(geom = "label", size = 6, fontface = "bold"))
print(p10)

# Test 11: Labels with position adjustments
cat("\nTest 11: Labels with position adjustments\n")
p11 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                    labels = TRUE,
                    labels.args = list(nudge_y = 0.1, size = 5))
print(p11)

# Test 12: Labels with ellipses
cat("\nTest 12: Labels combined with ellipses\n")
p12 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                    labels = TRUE,
                    ellipse = TRUE,
                    labels.args = list(geom = "label", alpha = 0.7))
print(p12)

# ==============================================================================
# other.levels parameter tests
# ==============================================================================
cat("\n\nOTHER.LEVELS PARAMETER\n")
cat("----------------------\n")

# Test 13: Default behavior (uses means for non-focal variables)
cat("Test 13: Default behavior - uses means for Sepal.Length and Sepal.Width\n")
cat("  Sepal.Length mean:", mean(iris$Sepal.Length), "\n")
cat("  Sepal.Width mean:", mean(iris$Sepal.Width), "\n")
p13 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width)
print(p13)

# Test 14: Specify custom values for non-focal variables
cat("\nTest 14: Custom values - Sepal.Length=6.0, Sepal.Width=3.0\n")
p14 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                    other.levels = list(Sepal.Length = 6.0, Sepal.Width = 3.0))
print(p14)

# Test 15: Verify it works with character specification of vars
cat("\nTest 15: Using character vector for vars with other.levels\n")
p15 <- plot_discrim(iris.lda, c("Petal.Width", "Petal.Length"),
                    other.levels = list(Sepal.Length = 5.5, Sepal.Width = 2.8))
print(p15)

# ==============================================================================
# Customization with scales
# ==============================================================================
cat("\n\nCUSTOMIZATION WITH SCALES\n")
cat("-------------------------\n")

# Test 16: Define custom colors and shapes, modify theme
cat("Test 16: Custom colors, shapes, and theme\n")
iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17
p16 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  theme_bw(base_size = 14) +
  theme(legend.position = "inside",
        legend.position.inside = c(.8, .25))
print(p16)

# ==============================================================================
# QDA comparison
# ==============================================================================
cat("\n\nQUADRATIC DISCRIMINANT ANALYSIS\n")
cat("-------------------------------\n")

# Test 17: QDA gives quite a different result
cat("Test 17: Quadratic discriminant analysis\n")
iris.qda <- qda(Species ~ ., iris)
p17 <- plot_discrim(iris.qda, Petal.Length ~ Petal.Width)
print(p17)

# ==============================================================================
# Error handling tests
# ==============================================================================
cat("\n\nERROR HANDLING\n")
cat("--------------\n")

# Test 18: Error checking - missing variable in other.levels
cat("Test 18: Should error if other.levels missing a variable\n")
tryCatch({
  p18 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                      other.levels = list(Sepal.Length = 6.0))  # Missing Sepal.Width
  cat("  ERROR: Should have caught missing variable!\n")
}, error = function(e) {
  cat("  ✓ Correctly caught error:", conditionMessage(e), "\n")
})

# Test 19: Error checking - multiple values
cat("\nTest 19: Should error if other.levels has multiple values\n")
tryCatch({
  p19 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                      other.levels = list(Sepal.Length = c(5, 6), Sepal.Width = 3.0))
  cat("  ERROR: Should have caught multiple values!\n")
}, error = function(e) {
  cat("  ✓ Correctly caught error:", conditionMessage(e), "\n")
})

# ==============================================================================
# Complete example combining multiple features
# ==============================================================================
cat("\n\nCOMPREHENSIVE EXAMPLE\n")
cat("---------------------\n")

cat("Test 20: Comprehensive plot with multiple features\n")
p20 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width,
                    ellipse = TRUE,
                    ellipse.args = list(level = 0.68, linewidth = 1.5),
                    labels = TRUE,
                    labels.args = list(geom = "label", size = 5, fontface = "bold", alpha = 0.8),
                    other.levels = list(Sepal.Length = 5.8, Sepal.Width = 3.0)) +
  scale_color_manual(values = c("setosa" = "#E41A1C", 
                                 "versicolor" = "#377EB8", 
                                 "virginica" = "#4DAF4A")) +
  scale_fill_manual(values = c("setosa" = "#E41A1C", 
                                "versicolor" = "#377EB8", 
                                "virginica" = "#4DAF4A")) +
  theme_minimal(base_size = 12) +
  labs(title = "Iris Species Classification",
       subtitle = "Linear Discriminant Analysis")
print(p20)

cat("\n========================================\n")
cat("All tests completed successfully!\n")
cat("========================================\n")
