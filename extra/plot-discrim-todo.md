In the `candisc` R package, I have a function, `plot_discrim()` to plot the results of a linear discriminant analysis
for two variables. The code is at https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/R/plot_discrim.R.
I'd like you to help make this more general. I'll ask for one thing at a time.

It has an argument `ellipse` to control the display of data ellipses for the groups, but the attributes 
(level = 0.68, linewidth = 1.2) are hard-coded in the call to `stat_ellipse()` and there is no
`geom` argument to control whether the ellipse is filled (`geom = "polygon"`) or unfilled
(`geom = "path"`). I think the simplest thing for the user would be to add an argument,
`ellipse.args = list(...)` that could handle `level`, `linewidth`, etc. and then feed these
values into the call to `stat_ellipse()`. The `list(...)`  should allow any arguments
valid for `stat_ellipse()`. Document these changes in the roxygen comments like
`@param ellipse.args`.

I would like to be able to add direct labels for the classes using either
`geom_text()` or `geom_label()`. These should be positioned near the means
of the classes. As part of this the function should calculate the class means
for the variables to be plotted. Here is the code I tried, but it gave errors
```
 class_means <- data |>
   group_by(!!!class) |>
   select(!!!vars) |>
   summarise(across(vars), mean)
```
Then, implement a `labels = TRUE/FALSE` argument, with default `FALSE`.
Along with this, implement a `labels.args = list(...)` which can take
`geom = "text"` or `geom = `label`, along with other arguments to these
like `nudge_x`, `nudge_y`.

Next, rename the argument `modes.means` to `other.levels` and better explain in the documentation
that it controls how the non-focal variables are represented in the data frame used to generate
the predicted classes over the grid.

## Plots in discriminant space.

This is a continuation of the conversation on plotting results of LDA / QDA in the `candisc`
package. The present version of the function `plot_discrim()` is in the
github repo at https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/R/plot_discrim.R
Read this and then I'll pose several enhancements.


The function currently plots in the space of the observed variables. I'd like to also
allow it to plot the observations and predictions in discriminant space; that is using
the variables `LD1` and `LD2` calculated using `predict_discrim()`.

I think this can be done by allowing the `vars` argument to take the special form
`LD2 ~ LD1` or `LD1 ~ LD2`. Then for generating the grid of predicted classes
the function should calculate a new `lda()` of the form
`mod.lda <- lda(class ~ LD1 + LD2, data=) where `data` is the set of 
data values for the variables obtained from `predict_discrim()` for this revised model.
Here is the code I used to construct an example using the present version.

```
iris_scored <- predict_discrim(iris.lda, scores=TRUE)
iris.lda2 <- lda(Species ~ LD1 + LD2, data=iris_scored)

plot_discrim(iris.lda2, LD2 ~ LD1,
             contour = FALSE,
             ellipse = TRUE) +
  scale_color_manual(values = iris.colors) +
  scale_fill_manual(values = iris.colors) +
  scale_shape_manual(values = iris.pch) +
  theme_minimal(base_size = 16) 
```

In the present version for plotting in discriminant space, it would be useful to automatically create labels
for the axes that contain the percent of between-group variance accounted for by each dimension.
Please fetch the current version from https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/R/plot_discrim.R
The code to get better axis labels, for the first two dimensions is:
```
svd <- iris.lda$svd
var <- 100 * round(svd^2/sum(svd^2), 3)
labs <- glue::glue("Discriminant dimension {1:2} ({var}%)") |>
  print()
# Discriminant dimension 1 (86.5%)
# Discriminant dimension 2 (13.5%)
```

Then, for ggplot, the code to add labels would be like:

```
 + labs(x = labs[1], y = labs[2])
```

What makes this tricky is that when there are more than 2 discriminant dimensions, one can use `LD3 ~ LD2`, and the
labels should use those components of the `svd` variances.

## Vignettes

In the candisc package, I have a demo file,
https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/demo/painters.R
I would like to turn into a vignette for the package in `.qmd` format,
with the main focus on HE plots, candisc plots and discriminant analysis plots.
Read the source file and I'll give you further instructions.

Begin with a brief statement of what the `MASS::painters` data set consists of.
Then incorporate the analysis and graphic steps into the vignette. Treat each block
of code starting with a comment `#' ##` as a new section.
Comments like `#'` are meant to be used as text. You can expand on what these are
saying, but not too long.

Use this style of YAML header

```
---
title: "Diabetes data: heplots and candisc examples"
author: "Michael Friendly"
date: "`r Sys.Date()`"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Diabetes data: heplots and candisc examples}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---
```

## Reversing axes

Please fetch the current version of `plot_discrim()` from https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/R/plot_discrim.R
When plotting discriminant scores in discriminant space, the orientation of the axes LD1
and LD2 is arbitrary, in that either or both can be multiplied by -1 without changing the fit.

Implement an option, `rev.axes`, a vector of two logical T/F values, that when 
`rev.axes[1] ==TRUE` reverses the sign of the horizontal axis, and similarly for `rev.axes[2]`,
reversing the vertical axis. This only applies for plots of the discriminant variables.

## axis limits
Limits of the variables plotted currently use the range of the focal x, y variables in lines 271-278.
Can you add arguments `xlim`, `ylim`, with defaults `NULL` to allow these ranges to be
overridden. This is a bit tricky, since the current version uses `lapply(data[, vars] ...`
rather than identifying x, y

## Variable vectors

One final thing I'd like to do with my function `plot_discrim()` is to be able to draw vectors
in the plot representing the correlations of the observed variables with the discriminant dimensions.
This applies only when the formula in the call to `plot_discrim()` specifies the dimensions
like `LD2 ~ LD`.  For an "lda" object, these correlations can be calculated using `cor_lda()`.

--> see code in `extra/plot-discrim-test.R`
