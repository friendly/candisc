\name{cancor}
\alias{cancor}
\alias{cancor.default}
\alias{cancor.formula}
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

cancor(x, ...)

\method{cancor}{formula}(formula, data, subset, weights, na.rm=TRUE, method = "gensvd", ...)

\method{cancor}{default}(x, y, weights,
    X.names = colnames(X), Y.names = colnames(Y), row.names = rownames(X), 
    xcenter = TRUE, ycenter = TRUE, xscale = FALSE, yscale = FALSE, 
    ndim = min(p, q), 
    set.names = c("X", "Y"), 
    prefix = c("Xcan", "Ycan"), 
    na.rm = TRUE, use = if (na.rm) "complete" else "pairwise",
    method = "gensvd",
	...
	)

\method{print}{cancor}(x, digits = max(getOption("digits") - 2, 3), ...)

\method{summary}{cancor}(object, digits = max(getOption("digits") - 2, 3), ...)

\method{coef}{cancor}(object, type = c("x", "y", "both", "list"), standardize=FALSE, ...)

scores(x, ...)

\method{scores}{cancor}(x, type = c("x", "y", "both", "list", "data.frame"), ...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{formula}{
A two-sided formula of the form \code{cbind(y1, y2, y3, \dots) ~ x1 + x2 + x3 + \dots}
}
  \item{data}{
The data.frame within which the formula is evaluated
}
  \item{subset}{
an optional vector specifying a subset of observations to be used in the calculations.
}
  \item{weights}{
Observation weights. If supplied, this must be a vector of length equal to the number of
observations in X and Y, typically within [0,1].  In that case, the variance-covariance
matrices are computed using \code{\link[stats]{cov.wt}}, and the number of observations
is taken as the number of non-zero weights.
}
  \item{na.rm}{
logical, determining whether observations with missing cases are excluded in the computation
of the variance matrix of (X,Y).  See Notes for details on missing data.
}
  \item{method}{
the method to be used for calculation; currently only \code{method = "gensvd"} is supported;
}
  \item{x}{
Varies depending on method. For the \code{cancor.default} method, this should be
a matrix or data.frame whose columns contain the X variables
}
  \item{y}{
 For the \code{cancor.default} method,
a matrix or data.frame whose columns contain the Y variables

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
argument passed to \code{var} determining how missing data
are handled.  Only the default, \code{use="complete"} is allowed 
when observation weights are supplied.
}

  \item{object}{
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

The connection between CCA and HE plots for MMRA models can be developed as follows.
CCA can also be viewed as a principal component transformation of the predicted values of 
one set of variables from a regression on the other set of variables, 
in the metric of the error covariance matrix. 

For example, regress the Y variables on the X variables,
giving predicted values \eqn{\hat{Y} = X (X'X)^{-1} X' Y}
and residuals \eqn{R = Y - \hat{Y}}.
The error covariance matrix is \eqn{E = R'R/(n-1)}. 
Choose a transformation Q
that orthogonalizes the error covariance matrix to an identity, that is,
\eqn{(RQ)'(RQ) = Q' R' R Q = (n-1) I},
and apply the same transformation to the predicted values to yield, say, \eqn{Z = \hat{Y} Q}.
Then, a principal component analysis on the covariance matrix of Z gives eigenvalues of 
\eqn{E^{-1} H}, and so is equivalent to the MMRA analysis of \code{lm(Y ~ X)} statistically,
but visualized here in canonical space.

}
\value{
An object of class \code{cancorr}, a list with the following components:
  \item{cancor}{Canonical correlations, i.e., the correlations between each canonical variate for
  the Y variables with the corresponding canonical variate for the X variables.}
  \item{names}{Names for various items, a list of 4 components: \code{X}, \code{Y}, \code{row.names}, \code{set.names}}
  \item{ndim}{Number of canonical dimensions extracted, \code{<= min(p,q)}}
  \item{dim}{Problem dimensions, a list of 3 components: \code{p} (number of X variables), 
       \code{q} (number of Y variables), \code{n} (sample size)}
  \item{coef}{Canonical coefficients, a list of 2 components: \code{X}, \code{Y}}
%  \item{scores}{Canonical variate scores, a list of 2 components: \code{X}, \code{Y}}
  \item{scores}{Canonical variate scores, a list of 2 components: 
  	\describe{
	  \item{\code{X}}{Canonical variate scores for the X variables}
	  \item{\code{Y}}{Canonical variate scores for the Y variables}
  	}
  }
  \item{X}{The matrix X}
  \item{Y}{The matrix Y}
  \item{weights}{Observation weights, if supplied, else \code{NULL}}
%  \item{structure}{Structure correlations, a list of 4 components: \code{X.xscores}, \code{Y.xscores}, \code{X.yscores}, \code{Y.yscores}}
  \item{structure}{Structure correlations ("loadings"), a list of 4 components: 
	  \describe{
	  \item{X.xscores}{Structure correlations of the X variables with the Xcan canonical scores}
	  \item{Y.xscores}{Structure correlations of the Y variables with the Xcan canonical scores}
	  \item{X.yscores}{Structure correlations of the X variables with the Ycan canonical scores}
	  \item{Y.yscores}{Structure correlations of the Y variables with the Ycan canonical scores}
	  }

The formula method also returns components \code{call} and \code{terms}
  }
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
Not all features of CCA are presently implemented: standardized vs. raw scores, 
more flexible handling of missing data, other plot methods, ...
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
Other implementations of CCA: \code{\link[stats]{cancor}} (very basic), 
\code{\link[yacca]{cca}} in the \pkg{yacca} (fairly complete, but very messy return structure),
\code{\link[CCA]{cc}} in \pkg{CCA} (fairly complete, very messy return structure, no longer maintained).

\code{\link{redundancy}}, for redundancy analysis;
\code{\link{plot.cancor}}, for enhanced scatterplots of the canonical variates.

\code{\link{heplot.cancor}} for CCA HE plots and
\code{\link[heplots]{heplots}} for generic heplot methods.

\code{\link{candisc}} for related methods focused on multivariate linear models with
one or more factors among the X variables.
}

\examples{
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

(cc <- cancor(X, Y, set.names=c("PA", "Ability")))

## Canonical correlation analysis of:
##       5   PA  variables:  n, s, ns, na, ss 
##   with        3   Ability  variables:  SAT, PPVT, Raven 
## 
##     CanR  CanRSQ   Eigen percent    cum                          scree
## 1 0.6703 0.44934 0.81599   77.30  77.30 ******************************
## 2 0.3837 0.14719 0.17260   16.35  93.65 ******                        
## 3 0.2506 0.06282 0.06704    6.35 100.00 **                            
## 
## Test of H0: The canonical correlations in the 
## current row and all that follow are zero
## 
##      CanR  WilksL      F df1   df2  p.value
## 1 0.67033 0.44011 3.8961  15 168.8 0.000006
## 2 0.38366 0.79923 1.8379   8 124.0 0.076076
## 3 0.25065 0.93718 1.4078   3  63.0 0.248814


# formula method
cc <- cancor(cbind(SAT, PPVT, Raven) ~  n + s + ns + na + ss, data=Rohwer, 
    set.names=c("PA", "Ability"))

# using observation weights
set.seed(12345)
wts <- sample(0:1, size=nrow(Rohwer), replace=TRUE, prob=c(.05, .95))
(ccw <- cancor(X, Y, set.names=c("PA", "Ability"), weights=wts) )

# show correlations of the canonical scores 
zapsmall(cor(scores(cc, type="x"), scores(cc, type="y")))

# standardized coefficients
coef(cc, type="both", standardize=TRUE)

plot(cc, smooth=TRUE)

##################
data(schooldata)
##################

#fit the MMreg model
school.mod <- lm(cbind(reading, mathematics, selfesteem) ~ 
education + occupation + visit + counseling + teacher, data=schooldata)
Anova(school.mod)
pairs(school.mod)

# canonical correlation analysis
school.cc <- cancor(cbind(reading, mathematics, selfesteem) ~ 
education + occupation + visit + counseling + teacher, data=schooldata)
school.cc
heplot(school.cc, xpd=TRUE, scale=0.3)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multivariate}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
