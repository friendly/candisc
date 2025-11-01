# plot_discrim.R Modernization Summary

## Changes Made

### 1. Modernized ggplot2 Code (Removed aes_string() Deprecation)

I've updated your `plot_discrim` function to use modern ggplot2 tidy evaluation instead of the deprecated `aes_string()`. 

**Before (deprecated):**
```r
gg <- ggplot(aes_string(vars[1], vars[2]), data = data) + 
  geom_point(aes_string(col = lhs, shape = lhs), size = point.size) + 
  geom_contour(aes_string(vars[1], vars[2], 
                          z = paste0('as.integer(', lhs, ') + 1L')), 
               color = contour.color,
               data = prd.data, inherit.aes = FALSE)
```

**After (modern):**
```r
gg <- ggplot(data = data, aes(.data[[vars[1]]], .data[[vars[2]]])) + 
  geom_point(aes(col = .data[[lhs]], shape = .data[[lhs]]), size = point.size) + 
  geom_contour(aes(.data[[vars[1]]], .data[[vars[2]]], 
                   z = as.integer(.data[[lhs]]) + 1L), 
               color = contour.color,
               data = prd.data, inherit.aes = FALSE)
```

### 2. Enhanced showgrid Parameter

The `showgrid` parameter has been enhanced from a simple TRUE/FALSE to accept three options:

**New signature:**
```r
showgrid = c("tile", "point", "none")
```

**Options:**
- `"tile"` (default): Uses `geom_tile()` to display predicted class regions as colored tiles with 30% transparency
- `"point"`: Uses `geom_point()` to display predicted class regions as semi-transparent points (original behavior)
- `"none"`: Displays no grid, showing only the actual data points and decision boundaries

**Implementation:**
```r
# Add grid visualization based on showgrid option
if(showgrid == "tile") {
  gg <- gg + 
    geom_tile(aes(.data[[vars[1]]], .data[[vars[2]]], fill = .data[[lhs]]), 
              data = prd.data, 
              alpha = 0.3)
} else if(showgrid == "point") {
  gg <- gg + 
    geom_point(aes(.data[[vars[1]]], .data[[vars[2]]], col = .data[[lhs]]), 
               data = prd.data, 
               shape = 20, size = 0.5, alpha = 0.4)
}
# if showgrid == "none", don't add anything
```

### Benefits

- ✅ No more deprecation warnings
- ✅ More efficient (no string parsing)
- ✅ Better error messages if variables don't exist
- ✅ Follows current ggplot2 best practices
- ✅ More flexible visualization options for predicted class regions
- ✅ `geom_tile()` option provides clearer visualization of decision boundaries
- ✅ Compatible with ggplot2 3.0.0+

### Usage Examples

```r
library(MASS)
library(ggplot2)
iris.lda <- lda(Species ~ ., iris)

# Tile display (default) - shows regions as colored tiles
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile")

# Point display - shows regions as semi-transparent points
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "point")

# No grid - shows only data points and decision boundaries
plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "none")
```

The function will work without any deprecation warnings and provides more flexible visualization options!
