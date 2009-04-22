\name{dataIndex}
\alias{dataIndex}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Indices of observations in a model data frame}
\description{
Find sequential indices for observations in a data frame
corresponding to the unique combinations of the levels
of a given model term from a model object or a data frame
}
\usage{
dataIndex(x, term)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Either a data frame or a model object}
  \item{term}{The name of one term in the model, consisting only of factors}
}
\value{
  A vector of indices.
}
%\references{ ~put references to the literature/web site here ~ }
\author{Michael Friendly}
%\seealso{ ~~objects to See Also as \code{\link{help}}, ~~~ }
\examples{
factors <- expand.grid(A=factor(1:3),B=factor(1:2),C=factor(1:2))
n <- nrow(factors)
responses <-data.frame(Y1=10+round(10*rnorm(n)),Y2=10+round(10*rnorm(n)))

test <- data.frame(factors, responses)
mod <- lm(cbind(Y1,Y2) ~ A*B, data=test)

dataIndex(mod, "A")
dataIndex(mod, "A:B")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utilities}
\keyword{manip}% __ONLY ONE__ keyword per line
