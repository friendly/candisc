# Customizing Colors and Shapes in plot_discrim()

Since `plot_discrim()` returns a ggplot object, you can easily customize colors and shapes by adding scale layers after the function call.

## Example with Iris Data

```r
library(MASS)
library(ggplot2)

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
```

## Important Note: Use Both scale_color and scale_fill

When using `showgrid = "tile"`, you need to specify **both** `scale_color_manual()` and `scale_fill_manual()`:

- **`scale_color_manual()`**: Controls the color of the **data points** and the **point-based grid** (if using `showgrid = "point"`)
- **`scale_fill_manual()`**: Controls the fill color of the **tiles** (when using `showgrid = "tile"`)

### Example Breakdown

```r
# TILE visualization - need both color and fill scales
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +  # for data points
  scale_fill_manual(values = iris.colors) +   # for tiles
  scale_shape_manual(values = iris.pch)       # for point shapes

# POINT visualization - only need color scale
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "point") +
  scale_color_manual(values = iris.colors) +  # for both data points and grid points
  scale_shape_manual(values = iris.pch)       # for point shapes

# NO GRID - only need color scale
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "none") +
  scale_color_manual(values = iris.colors) +  # for data points only
  scale_shape_manual(values = iris.pch)       # for point shapes
```

## Complete Working Example

```r
library(MASS)
library(ggplot2)

# Custom colors and shapes
iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17

# Fit model
iris.lda <- lda(Species ~ ., iris)

# Create a polished plot
p <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                 data = iris, 
                 showgrid = "tile",
                 point.size = 3,
                 contour.color = "black") +
  scale_color_manual(values = iris.colors,
                     name = "Species") +
  scale_fill_manual(values = iris.colors,
                    name = "Species") +
  scale_shape_manual(values = iris.pch,
                     name = "Species") +
  theme_minimal() +
  labs(title = "Linear Discriminant Analysis of Iris Dataset",
       subtitle = "Decision boundaries with custom colors and shapes",
       x = "Petal Length (cm)",
       y = "Sepal Length (cm)")

# Display
print(p)

# Save if desired
ggsave("iris_lda_custom.png", p, width = 10, height = 7, dpi = 300)
```

## Using Named Vectors for Explicit Mapping

For even more control, you can use named vectors to explicitly map species to colors/shapes:

```r
# Named vectors ensure explicit mapping
iris.colors <- c("setosa" = "red", 
                 "versicolor" = "darkgreen", 
                 "virginica" = "blue")

iris.pch <- c("setosa" = 15, 
              "versicolor" = 16, 
              "virginica" = 17)

# Use in plot
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch)
```

## Alternative: Using Brewer Palettes

You can also use ColorBrewer palettes for automatic color schemes:

```r
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile") +
  scale_color_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  scale_shape_manual(values = 15:17)
```

## Common Shape Values

Here are some useful shape values (pch):
- 0-14: Various hollow shapes
- 15: Filled square
- 16: Filled circle
- 17: Filled triangle (point up)
- 18: Filled diamond
- 19: Solid circle
- 21-25: Shapes with separate border and fill colors

## Quick Reference

| showgrid | Requires scale_color | Requires scale_fill | Requires scale_shape |
|----------|---------------------|---------------------|---------------------|
| "tile"   | Yes (data points)   | Yes (tiles)         | Yes (data points)   |
| "point"  | Yes (all points)    | No                  | Yes (data points)   |
| "none"   | Yes (data points)   | No                  | Yes (data points)   |
