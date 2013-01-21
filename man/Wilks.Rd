\name{Wilks}
\alias{Wilks}
\alias{Wilks.cancor}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Wilks Lambda Tests for Canonical Correlations
}
\description{
Tests the sequential hypotheses that a given canonical correlation and all
that follow it are zero.
}
\usage{

Wilks(object, ...)

\method{Wilks}{cancor}(object, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{object}{
An object of class \code{cancor}
}
  \item{\dots}{
Other arguments passed to methods
}

}
\details{
Wilks' Lambda values are converted to F statistics using Rao's 
approximation.
}
\value{
A data.frame (of class \code{"anova"}) containing the test statistics
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979).
\emph{Multivariate Analysis}. London: Academic Press.

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
Wilks(cc)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{htest}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
