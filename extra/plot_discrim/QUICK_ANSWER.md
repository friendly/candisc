# Quick Answer: Custom Colors and Shapes for plot_discrim()

## Your Question
How to use custom colors and shapes with the iris data using these vectors:
```r
iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17
```

## The Answer

Yes! Simply add scale layers after the `plot_discrim()` call:

```r
library(MASS)
library(ggplot2)

iris.colors <- c("red", "darkgreen", "blue")
iris.pch <- 15:17

iris.lda <- lda(Species ~ ., iris)

plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch)
```

## Key Points

1. **You need BOTH `scale_color_manual()` AND `scale_fill_manual()`** when using `showgrid = "tile"`:
   - `scale_color_manual()` controls the color of the actual data points
   - `scale_fill_manual()` controls the color of the background tiles

2. **With `showgrid = "point"` or `"none"`**, you only need `scale_color_manual()`

3. **`scale_shape_manual()`** controls the point shapes for all showgrid options

## Alternative with Named Vectors

For more explicit control:

```r
iris.colors <- c("setosa" = "red", 
                 "versicolor" = "darkgreen", 
                 "virginica" = "blue")
iris.pch <- c("setosa" = 15, 
              "versicolor" = 16, 
              "virginica" = 17)

plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile") +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch)
```

This ensures colors/shapes are explicitly mapped to species names regardless of data order.
