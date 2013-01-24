\name{cancor}
\alias{cancor}
\alias{print.cancor}
\alias{summary.cancor}
\alias{coef.cancor}
\alias{scores}
\alias{scores.cancor}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Canonical Correlation Analysis
}
\description{
The function \code{cancor} generalizes and regularizes computation
for canonical correlation analysis in a way conducive to visualization
using methods in the \code{\link[heplots]{heplots}} package.

}
\usage{

cancor(X, Y, 
	X.names = colnames(X), Y.names = colnames(Y), row.names = rownames(X), 
	xcenter = TRUE, ycenter = TRUE, xscale = FALSE, yscale = FALSE, 
	ndim = min(p, q), 
	set.names = c("X", "Y"), 
	prefix = c("Xcan", "Ycan"), 
	use = "complete.obs")

\method{print}{cancor}(x, digits = max(getOption("digits") - 2, 3), ...)

\method{summary}{cancor}(object, digits = max(getOption("digits") - 2, 3), ...)

\method{coef}{cancor}(object, type = c("x", "y", "both", "list"), standardize=FALSE, ...)

scores(x, ...)

\method{scores}{cancor}(x, type = c("x", "y", "both", "list", "data.frame"), ...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{X}{
A matrix or data.frame whose columns contain the X variables
}
  \item{Y}{
A matrix or data.frame whose columns contain the Y variables

}
  \item{X.names, Y.names}{
Character vectors of names for the X and Y variables.
}
  \item{row.names}{
Observation names in X, Y
}
  \item{xcenter, ycenter}{
logical. Center the X, Y variables? [not yet implemented]
}
  \item{xscale, yscale}{
logical. Scale the X, Y variables to unit variance? [not yet implemented]

}
  \item{ndim}{
Number of canonical dimensions to retain in the result, for scores, coefficients, etc.
}
  \item{set.names}{
A vector of two character strings, giving names for the collections of
the X, Y variables.
}
  \item{prefix}{
A vector of two character strings, giving prefixes used to name the X and Y
canonical variables, respectively.
}
  \item{use}{
argument passed to \code{var} and \code{cov} determining how missing data
are handled.
}

  \item{x, object}{
A \code{cancor} object for related methods.
}
  \item{digits}{
Number of digits passed to \code{print} and \code{summary} methods
}
  \item{\dots}{
Other arguments, passed to methods
}

  \item{type}{
For the \code{coef} method, the type of coefficients returned, 
one of \code{"x"}, \code{"y"}, \code{"both"}. For the \code{scores}
method, the same list,  or \code{"data.frame"}, which returns
a data.frame containing the X and Y canonical scores.
}
  \item{standardize}{
For the \code{coef} method, whether coefficients should be standardized
by dividing by the standard deviations of the X and Y variables.
}
}

\details{
Canonical correlation analysis (CCA), as traditionally presented is used to identify and measure the
associations between two sets of quantitative variables, X and Y.  
It is often used in the same situations for which a multivariate multiple regression analysis (MMRA)
would be used. 
However, CCA is is \dQuote{symmetric} in that the sets X and Y have equivalent status,
and the goal is to find orthogonal linear combinations of each having maximal
(canonical) correlations.
On the other hand,  MMRA is \dQuote{asymmetric}, in that the Y set is considered as responses,
\emph{each one} to be explained by \emph{separate} linear combinations of the Xs.

This implementation of \code{cancor} provides the basic computations for CCA, together with
some extractor functions and methods for working with the results in a 
convenient fashion.  

However, for visualization using HE plots, it is most natural to consider plots representing
the relations among the canonical variables for the Y variables in terms of a 
multivariate linear model predicting the Y canonical scores, using either the X variables
or the X canonical scores as predictors.  Such plots, using \code{\link{heplot.cancor}}
provide a low-rank (1D, 2D, 3D) visualization of the relations between the two sets,
and so are useful in cases when there are more than 2 or 3 variables in each of X and Y.
}
\value{
An object of class \code{cancorr}, a list with the following 9 components:
  \item{cancor}{Canonical correlations, i.e., the correlations between each canonical variate for
  the Y variables with the corresponding canonical variate for the X variables.}
  \item{names}{Names for various items, a list of 4 components: \code{X}, \code{Y}, \code{row.names}, \code{set.names}}
  \item{ndim}{Number of canonical dimensions extracted, \code{<= min(p,q)}}
  \item{dim}{Problem dimensions, a list of 3 components: \code{p} (number of X variables), 
       \code{q} (number of Y variables), \code{n} (sample size)}
  \item{coef}{Canonical coefficients, a list of 2 components: \code{X}, \code{Y}}
  \item{scores}{Canonical variate scores, a list of 2 components: \code{X}, \code{Y}}
  \item{X}{The matrix X}
  \item{Y}{The matrix Y}
  \item{structure}{Structure correlations, a list of 4 components: \code{X.xscores}, \code{Y.xscores}, \code{X.yscores}, \code{Y.yscores}}
}
\references{
Gittins, R. (1985). \emph{Canonical Analysis: A Review with Applications in Ecology},
Berlin: Springer.

Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979).
\emph{Multivariate Analysis}. London: Academic Press.
}
\author{
Michael Friendly
}
\note{
Not all features of CCA are presently implemented: standardized coefficients, redundancy analysis, ...
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
Other implementations of CCA: \code{\link[stats]{cancor}} (very basic), 
\code{\link[yacca]{cca}} (fairly complete, but very messy return structure),
\code{\link[CCA]{cc}} (fairly complete, very messy return structure, no longer maintained).

\code{\link{candisc}}
}

\examples{
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

(cc <- cancor(X, Y, set.names=c("PA", "Ability")))

# show correlations of the canonical scores 
zapsmall(cor(scores(cc, type="x"), scores(cc, type="y")))

# standardized coefficients
coef(cc, type="both", standardize=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multivariate}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
