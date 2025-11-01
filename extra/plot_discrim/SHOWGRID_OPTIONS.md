# showgrid Visualization Options

The `showgrid` parameter in `plot_discrim()` now offers three visualization options for displaying predicted class regions:

## Option 1: `showgrid = "tile"` (Default)

Uses `geom_tile()` to create a heatmap-style visualization of predicted class regions.

**Characteristics:**
- Creates filled rectangular tiles showing predicted classes across the plot area
- Uses `fill` aesthetic mapped to the predicted class
- Alpha transparency set to 0.3 (30%) to allow data points to be visible
- Provides the clearest visualization of decision boundaries
- Best for presentations and publications

**Code:**
```r
geom_tile(aes(.data[[vars[1]]], .data[[vars[2]]], fill = .data[[lhs]]), 
          data = prd.data, 
          alpha = 0.3)
```

**When to use:**
- When you want clear, continuous regions showing predicted classes
- For creating publication-quality visualizations
- When working with higher resolution settings

---

## Option 2: `showgrid = "point"`

Uses `geom_point()` to create a point-based visualization (original behavior).

**Characteristics:**
- Creates small, semi-transparent points colored by predicted class
- Uses `col` aesthetic mapped to the predicted class
- Small point size (0.5) and shape (20 = solid circle)
- Alpha transparency set to 0.4 (40%)
- More subtle than tiles, shows the underlying grid structure

**Code:**
```r
geom_point(aes(.data[[vars[1]]], .data[[vars[2]]], col = .data[[lhs]]), 
           data = prd.data, 
           shape = 20, size = 0.5, alpha = 0.4)
```

**When to use:**
- When you want a more subtle indication of class regions
- When the plot might be too busy with tiles
- For exploratory analysis where you want to see the grid resolution

---

## Option 3: `showgrid = "none"`

No grid display - shows only actual data points and decision boundary contours.

**Characteristics:**
- Cleanest visualization
- Only displays:
  - Original data points (with color and shape by actual class)
  - Decision boundary contours (in black by default)
- No predicted class regions shown

**When to use:**
- When you only want to show the decision boundaries
- For cleaner, simpler plots
- When the focus should be on the actual data distribution
- For overlaying on other visualizations

---

## Comparison Example

```r
library(MASS)
library(ggplot2)
library(gridExtra)  # for grid.arrange

iris.lda <- lda(Species ~ ., iris)

# Create three versions
p1 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data=iris, showgrid = "tile") +
      ggtitle("showgrid = 'tile'")

p2 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data=iris, showgrid = "point") +
      ggtitle("showgrid = 'point'")

p3 <- plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
                  data=iris, showgrid = "none") +
      ggtitle("showgrid = 'none'")

# Display side by side
grid.arrange(p1, p2, p3, ncol = 3)
```

## Technical Notes

- The `resolution` parameter (default = 100) controls the density of the prediction grid
- Higher resolution creates smoother tiles/points but takes longer to compute
- The `match.arg()` function ensures only valid options are accepted
- Invalid inputs will produce an error message listing the valid options
