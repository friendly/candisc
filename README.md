<!-- badges: start -->

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) 
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/candisc)](https://cran.r-project.org/package=candisc)
[![R_universe](https://friendly.r-universe.dev/badges/candisc)](https://friendly.r-universe.dev) 
[![downloads](https://cranlogs.r-pkg.org/badges/grand-total/candisc)](https://cran.r-project.org/package=candisc)
[![documentation](https://img.shields.io/badge/documentation-blue)](https://friendly.github.io/candisc/)

<!-- badges: end -->


# candisc  <img src="man/figures/logo.png" align="right" height="160px" />
**Visualizing Generalized Canonical Discriminant and Canonical Correlation Analysis**

Version 1.0.1

<!-- when in Rmd format, can use
Version `r getNamespaceVersion("candisc")`
-->

This package includes functions for computing and visualizing 
generalized canonical discriminant analyses 
and canonical correlation analysis
for a multivariate linear model (MLM).  The goal is to provide ways of visualizing
such models in a low-dimensional space corresponding to dimensions
(linear combinations of the response variables) of maximal relationship
to the predictor variables. 

Traditional canonical discriminant analysis is restricted to a one-way MANOVA
design and is equivalent to canonical correlation analysis between a set of quantitative
response variables and a set of dummy variables coded from the factor variable.
The `candisc` package generalizes this to multi-way MANOVA designs
for all terms in a multivariate linear model (i.e., an `mlm` object),
computing canonical scores and vectors for each term (giving a `"candiscList"` object).

**Visualization methods**

The graphic functions are designed to provide low-rank (1D, 2D, 3D) visualizations of
terms in a `"mlm"` via the `plot.candisc()` method, which plots the observations
in canonical space, together with **variable vectors** showing the relations of the 
response `y` variables to the canonical variables `Can1`, `Can2`, similar to a biplot.

The HE plot `heplot.candisc()` and `heplot3d.candisc()` methods use a similar framework,
but replace the observations and groupwise data ellipses in the plot with 
representations of the **H** ellipsoid, representing between-group variation
in the means and the **E** ellipsoid reflecting the pooled within-group variation.

For `mlm`s with more than a few response variables, these methods often provide a 
much simpler interpretation of the nature of effects in canonical space than
heplots for pairs of responses or an HE plot matrix of all responses in variable space.

Analogously, a multivariate linear (regression) model with quantitative predictors can also be
represented in a reduced-rank space by means of a canonical correlation
transformation of the Y and X variables to _uncorrelated_ **canonical variates*, named with the prefix
`Ycan` and `Xcan`.  Computation for this analysis is provided by `cancor()`
and related methods.  Visualization of these results in canonical space
are provided by the `plot.cancor()`,  `heplot.cancor()` 
and `heplot3d.cancor()` methods.

**Variable ordering**

The relations among response variables in linear models can also be
useful for "effect ordering"
(Friendly & Kwan (2003))
for *variables* in other multivariate data displays, such as heatmaps or "corrgrams" (Friendly, 2002) of correlations.
to make the
displayed relationships more coherent.  The function `varOrder()`
implements a collection of these methods.

**Discriminant analysis**

A start has been made on extending these graphical methods to discriminant analysis,
for example from `MASS:lda()` beginning with a simplified interface to 
prediction, in `predict_discrim()`. A new plotting method, `plot_discrim()`, provides
`ggplot2` plots of the classification regions and decision boundaries.


## Installation

|                     |                                               |
|---------------------|-----------------------------------------------|
| CRAN version        | `install.packages("candisc")`                 |
| Development version | `remotes::install_github("friendly/candisc")` |

Or, install from r-universe:

```r
install.packages('candisc', repos = c('https://friendly.r-universe.dev')
```

## Vignettes

* A new vignette, `vignette("diabetes", package="candisc")`,
illustrates some of these methods.

* A more comprehensive collection of examples is contained in the vignettes for the `heplots` package,
`browseVignettes(package = "heplots")`.

## Citation

To cite package `candisc` in publications use:

  Friendly M., Fox J. (2025). candisc: Visualizing Generalized Canonical Discriminant and Canonical Correlation
  Analysis_. R package version 1.0.0, <https://CRAN.R-project.org/package=heplots>.

For the theory on which these methods are based, also cite:

  Friendly, M. (2007). “HE plots for Multivariate General Linear Models.” _Journal of Computational and Graphical
  Statistics_, *16*(2), 421-444. <https://doi.org/10.1198/106186007X208407>.

## References

Friendly, M. (2002). Corrgrams: Exploratory displays for correlation matrices. _The American Statistician_, **56**(4), 316–324. <https://doi.org/10.1198/000313002533>

Friendly, M., & Kwan, E. (2003). Effect Ordering for Data Displays. _Computational Statistics and Data Analysis_, **43**(4), 509–539. <https://doi.org/10.1016/S0167-9473(02)00290-6>
