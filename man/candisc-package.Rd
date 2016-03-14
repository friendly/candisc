\name{candisc-package}
\alias{candisc-package}

\docType{package}
\title{
Visualizing Generalized Canonical Discriminant and Canonical Correlation Analysis
}
\description{
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
The \code{candisc} package generalizes this to multi-way MANOVA designs
for all terms in a multivariate linear model (i.e., an \code{mlm} object),
computing canonical scores and vectors for each term (giving a \code{candiscList} object).

The graphic functions are designed to provide low-rank (1D, 2D, 3D) visualizations of
terms in a \code{mlm} via the \code{\link{plot.candisc}} method, 
and the HE plot \code{\link{heplot.candisc}} and \code{\link{heplot3d.candisc}}
methods.
For \code{mlm}s with more than a few response variables, these methods often provide a 
much simpler interpretation of the nature of effects in canonical space than
heplots for pairs of responses or an HE plot matrix of all responses in variable space.

Analogously, a multivariate linear model with quantitative predictors can also be
represented in a reduced-rank space by means of a canonical correlation
transformation of the Y and X variables to uncorrelated canonical variates,
Ycan and Xcan.  Computation for this analysis is provided by \code{\link{cancor}}
and related methods.  Visualization of these results in canonical space
are provided by the \code{\link{plot.cancor}},  \code{\link{heplot.cancor}} 
and \code{\link{heplot3d.cancor}} methods.

A few of these methods are illustrated in the vignette for the heplots package,

\code{vignette("HE-examples", package="heplots")}.
}
\details{
\tabular{ll}{
Package: \tab candisc\cr
Type: \tab Package\cr
Version: \tab 0.6-8\cr
Date: \tab 2016-03-09\cr
License: \tab GPL (>= 2)\cr
}
The organization of functions in this package and the \pkg{heplots} package
may change in a later version.
}

\author{
Michael Friendly and John Fox

Maintainer: Michael Friendly <friendly@yorku.ca>
}
\references{
Friendly, M. (2007).
  HE plots for Multivariate General Linear Models.
  \emph{Journal of Computational and Graphical Statistics}, \bold{16}(2) 421--444.
  \url{http://datavis.ca/papers/jcgs-heplots.pdf} 


Gittins, R. (1985). Canonical Analysis: A Review with Applications in Ecology,
Berlin: Springer.


}

\keyword{ package }
\keyword{multivariate}
\seealso{ 
\code{\link[heplots]{heplot}} for details about HE plots.

\code{\link{candisc}}, \code{\link{cancor}} for details about canonical discriminant analysis
and canonical correlation analysis.

}
%\examples{
%
%}
