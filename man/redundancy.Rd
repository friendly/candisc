\name{redundancy}
\alias{redundancy}
\alias{print.cancor.redundancy}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Canonical Redundancy Analysis
}
\description{
Calculates indices of redundancy (Stewart & Love, 1968) from a canonical correlation analysis.
These give the proportion of variances of the variables in each set
(X and Y) which are accounted for by the variables in the other set
through the canonical variates.

}
\usage{

redundancy(object, ...)

\method{print}{cancor.redundancy}(x, digits = max(getOption("digits") - 3, 3), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{object}{
A \code{"cancor"} object
}

  \item{x}{
A \code{"cancor.redundancy"} for the \code{print} method.
}
  \item{digits}{
Number of digits to print
}
  \item{\dots}{
Other arguments 
}
}
\details{
None yet.
%Repeat with and variables interchanged, and you get the same eigenvalues.

}
\value{
%%  ~Describe the value returned
An object of class \code{"cancor.redundancy"}, a list with the following 5 components:
  \item{Xcan.redun}{Canonical redundancies for the X variables, i.e., the total fraction of
  	X variance accounted for by the Y variables through each canonical variate.}
  \item{Ycan.redun}{Canonical redundancies for the Y variables}
  \item{X.redun}{Total canonical redundancy for the X variables, i.e., the sum of
  	\code{Xcan.redun}.}
  \item{Y.redun}{Total canonical redundancy for the Y variables}
  \item{set.names}{names for the X and Y sets of variables}
}

\references{
Stewart, D. and Love, W. (1968). A general canonical correlation index. 
\emph{Psychological Bulletin}, 70, 160-163.
}
\author{
Michael Friendly
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{cancor}}, ~~~
}
\examples{
	data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

cc <- cancor(X, Y, set.names=c("PA", "Ability"))

redundancy(cc)
## 
## Redundancies for the PA variables & total X canonical redundancy
## 
##     Xcan1     Xcan2     Xcan3 total X|Y 
##   0.17342   0.04211   0.00797   0.22350 
## 
## Redundancies for the Ability variables & total Y canonical redundancy
## 
##     Ycan1     Ycan2     Ycan3 total Y|X 
##    0.2249    0.0369    0.0156    0.2774 

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multivariate}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
