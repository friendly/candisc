

#' Visualizing Generalized Canonical Discriminant and Canonical Correlation
#' Analysis
#' 
#' This package includes functions for computing and visualizing generalized
#' canonical discriminant analyses and canonical correlation analysis for a
#' multivariate linear model.  The goal is to provide ways of visualizing such
#' models in a low-dimensional space corresponding to dimensions (linear
#' combinations of the response variables) of maximal relationship to the
#' predictor variables.
#' 
#' Traditional canonical discriminant analysis is restricted to a one-way
#' MANOVA design and is equivalent to canonical correlation analysis between a
#' set of quantitative response variables and a set of dummy variables coded
#' from the factor variable. The `candisc` package generalizes this to
#' multi-way MANOVA designs for all terms in a multivariate linear model (i.e.,
#' an `"mlm"` object), computing canonical scores and vectors for each term
#' (giving a `"candiscList"` object).
#' 
#' The graphic functions are designed to provide low-rank (1D, 2D, 3D)
#' visualizations of terms in a `mlm` via the [plot.candisc()] 
#' method, and the HE plot [heplot.candisc()]  and
#' [heplot3d.candisc()] methods. For `mlm`s with more than a few
#' response variables, these methods often provide a much simpler
#' interpretation of the nature of effects in canonical space than heplots for
#' pairs of responses or an HE plot matrix of all responses in variable space.
#' 
#' Analogously, a multivariate linear (regression) model with quantitative
#' predictors can also be represented in a reduced-rank space by means of a
#' canonical correlation transformation of the Y and X variables to
#' uncorrelated canonical variates, Ycan and Xcan.  Computation for this
#' analysis is provided by [cancor()] and related methods.
#' Visualization of these results in canonical space are provided by the
#' [plot.cancor()], [heplot.cancor()] and [heplot3d.cancor()] methods.
#' 
#' These relations among response variables in linear models can also be useful
#' for \dQuote{effect ordering} (Friendly & Kwan (2003) for *variables* in
#' other multivariate data displays to make the displayed relationships more
#' coherent.  The function [varOrder()] implements a collection of
#' these methods.
#' 
#' A new vignette, `vignette("diabetes", package="candisc")`, illustrates
#' some of these methods. A more comprehensive collection of examples is
#' contained in the vignette for the \pkg{heplots} package,
#' 
#' `vignette("HE-examples", package="heplots")`.
#' 
#' The organization of functions in this package and the \pkg{heplots} package
#' may change in a later version.
#' 
#' @name candisc-package
#' @author Michael Friendly and John Fox
#' 
#' Maintainer: Michael Friendly <friendly@yorku.ca>
#' @seealso 
#' \code{\link[heplots]{heplot}} for details about HE plots.
#' 
#' [candisc()], [cancor()] for details about canonical
#' discriminant analysis and canonical correlation analysis.
#' @references 
#' Friendly, M. (2007).  HE plots for Multivariate General Linear Models.  
#' *Journal of Computational and Graphical Statistics*,
#' **16**(2) 421--444.  <http://datavis.ca/papers/jcgs-heplots.pdf>,
#' \doi{10.1198/106186007X208407}.
#' 
#' Friendly, M. & Kwan, E. (2003). Effect Ordering for Data Displays,
#' *Computational Statistics and Data Analysis*, **43**, 509-539.
#' \doi{10.1016/S0167-9473(02)00290-6}
#' 
#' Friendly, M. & Sigal, M. (2014). Recent Advances in Visualizing Multivariate
#' Linear Models. *Revista Colombiana de Estadistica* , **37**(2),
#' 261-283. 
#' \doi{10.15446/rce.v37n2spe.47934}.
#' 
#' Friendly, M. & Sigal, M. (2017). Graphical Methods for Multivariate Linear
#' Models in Psychological Research: An R Tutorial, *The Quantitative
#' Methods for Psychology*, 13 (1), 20-45.
#' \doi{10.20982/tqmp.13.1.p020}.
#' 
#' Gittins, R. (1985). *Canonical Analysis: A Review with Applications in
#' Ecology*, Berlin: Springer.
#' @aliases candisc-package
#' @keywords package multivariate
#' @importFrom graphics abline arrows boxplot layout lines par points polygon symbols text
#' @importFrom stats aggregate complete.cases contrasts cor cov cov.wt formula lsfit model.frame
#'         model.matrix model.response model.weights pf qchisq terms update var
"_PACKAGE"
