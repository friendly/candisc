[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/candisc)](https://cran.r-project.org/package=candisc)
[![](https://cranlogs.r-pkg.org/badges/grand-total/candisc)](https://cran.r-project.org/package=candisc)
[![Rdoc](https://www.rdocumentation.org/badges/version/candisc)](http://www.rdocumentation.org/packages/candisc)

# candisc  <img src="candisc-logo.png" align="right" height="200px" />
**Visualizing Generalized Canonical Discriminant and Canonical Correlation Analysis**

Version 0.8-2

This package includes functions for computing and visualizing 
generalized canonical discriminant analyses 
and canonical correlation analysis
for a multivariate linear model.  The goal is to provide ways of visualizing
such models in a low-dimensional space corresponding to dimensions
(linear combinations of the response variables) of maximal relationship
to the predictor variables. 

Traditional canonical discriminant analysis is restricted to a one-way MANOVA
design and is equivalent to canonical correlation analysis between a set of quantitative
response variables and a set of dummy variables coded from the factor variable.
The `candisc` package generalizes this to multi-way MANOVA designs
for all terms in a multivariate linear model (i.e., an `mlm` object),
computing canonical scores and vectors for each term (giving a `candiscList` object).

The graphic functions are designed to provide low-rank (1D, 2D, 3D) visualizations of
terms in a `mlm` via the `plot.candisc` method, 
and the HE plot `heplot.candisc` and `heplot3d.candisc`
methods.
For `mlm`s with more than a few response variables, these methods often provide a 
much simpler interpretation of the nature of effects in canonical space than
heplots for pairs of responses or an HE plot matrix of all responses in variable space.

Analogously, a multivariate linear (regression) model with quantitative predictors can also be
represented in a reduced-rank space by means of a canonical correlation
transformation of the Y and X variables to uncorrelated canonical variates,
Ycan and Xcan.  Computation for this analysis is provided by `cancor`
and related methods.  Visualization of these results in canonical space
are provided by the `plot.cancor`,  `heplot.cancor` 
and `heplot3d.cancor}` methods.

These relations among response variables in linear models can also be
useful for "effect ordering"
(Friendly & Kwan (2003)
for *variables* in other multivariate data displays to make the
displayed relationships more coherent.  The function `varOrder`
implements a collection of these methods.

A new vignette, `vignette("diabetes", package="candisc")`,
illustrates some of these methods.
A more comprehensive collection of examples is contained in the vignette for the `heplots` package,
`vignette("HE-examples", package="heplots")`.

## Installation

Get the released version from CRAN:

     install.packages("candisc")

The development version can be installed to your R library directly from this repo via:

     if (!require(devtools)) install.packages("devtools")
     library(devtools)
     install_github("friendly/candisc")

