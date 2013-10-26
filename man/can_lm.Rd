\name{can_lm}
\alias{can_lm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Transform a Multivariate Linear model mlm to a Canonical Representation
}
\description{
This function uses \code{\link{candisc}} to transform the responses in a
multivariate linear model to scores on canonical variables for a given term and then uses
those scores as responses in a linear (lm) or multivariate linear model (mlm).
}
\usage{
can_lm(mod, term, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mod}{
A \code{mlm} object
}
  \item{term}{
One term in that model
}
  \item{\dots}{
Arguments passed to \code{\link{candisc}}
}
}
\details{
The function constructs a model formula of the form \code{Can ~ terms}
where Can is the canonical score(s) and terms are the terms in the original mlm,
then runs lm() with that formula.
}
\value{
A \code{lm} object if \code{term} is a rank 1 hypothesis, otherwise a \code{mlm} object
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Michael Friendly
}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{candisc}}, \code{\link{cancor}}
}
\examples{
iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
iris.can <- can_lm(iris.mod, "Species")
iris.can
Anova(iris.mod)
Anova(iris.can)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
