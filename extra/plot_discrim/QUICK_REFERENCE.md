# plot_discrim() Quick Reference

## Updated Function Signature

```r
plot_discrim(model, 
            vars, 
            data, 
            resolution = 100,
            contour.color = "black",
            point.size = 3,
            showgrid = c("tile", "point", "none"),  # NEW: enhanced options
            ...,
            modes.means)
```

## What Changed

### 1. No More Deprecation Warnings
All `aes_string()` calls replaced with modern `.data[[]]` pronoun syntax.

### 2. Enhanced showgrid Parameter
- **Old:** `showgrid = TRUE` or `showgrid = FALSE`
- **New:** `showgrid = "tile"`, `"point"`, or `"none"`

## Quick Usage Examples

```r
library(MASS)
library(ggplot2)

# Fit model
iris.lda <- lda(Species ~ ., iris)

# Tile visualization (default, recommended)
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile")

# Point visualization (original style)
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "point")

# No grid (only boundaries and data)
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "none")
```

## Migration Guide

If you have existing code using the old TRUE/FALSE options:

```r
# Old code
plot_discrim(model, vars, data, showgrid = TRUE)   # showed points
plot_discrim(model, vars, data, showgrid = FALSE)  # showed nothing

# New equivalent code
plot_discrim(model, vars, data, showgrid = "point")  # shows points
plot_discrim(model, vars, data, showgrid = "none")   # shows nothing

# New default (better visualization)
plot_discrim(model, vars, data, showgrid = "tile")   # shows tiles (NEW!)
```

## Advanced: Customizing the Visualization

The function returns a ggplot object, so you can add layers:

```r
# Add custom theme and colors
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, showgrid = "tile") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Set2") +
  labs(title = "LDA Decision Boundaries for Iris Dataset",
       x = "Petal Length (cm)",
       y = "Sepal Length (cm)")

# Adjust contour and point appearance
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
            data = iris, 
            showgrid = "tile",
            contour.color = "red",
            point.size = 2)
```

## Notes

- The default is now `"tile"` which provides the clearest visualization
- `match.arg()` ensures only valid options are accepted
- All code is compatible with ggplot2 3.0.0+
- No deprecation warnings will appear
