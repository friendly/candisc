\name{cancor}
\alias{cancor}
\alias{print.cancor}
\alias{summary.cancor}
\alias{coef.cancor}
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

\method{coef}{cancor}(object, type = c("x", "y", "both", "list"), ...)
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
A vector of two character strings, giving 
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
For the \code{coef} method, the type of coefficients returned.
}
}
\details{
None yet.
}
\value{
An object of class \code{cancorr}, a list with the following 9 components:
  \item{cancor}{Canonical correlations}
  \item{names}{A list of 4 components: \code{X}, \code{Y}, \code{row.names}, \code{set.names}}
  \item{ndim}{Number of canonical dimensions extracted}
  \item{dim}{A list of 3 components: \code{p}, \code{q}, \code{n}}
  \item{coef}{Canonical coefficients, a list of 2 components: \code{X}, \code{Y}}
  \item{scores}{Canonical variate scores, a list of 2 components: \code{X}, \code{Y}}
  \item{X}{Description of 'X'}
  \item{Y}{Description of 'Y'}
  \item{structure}{A list of 4 components: \code{X.xscores}, \code{Y.xscores}, \code{X.yscores}, \code{Y.yscores}}
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
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link[stats]{cancor}}, ~~~
}
\examples{
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

(cc <- cancor(X, Y, set.names=c("PA", "Ability")))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multivariate}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
