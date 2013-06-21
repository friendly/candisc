\name{vecscale}
\alias{vecscale}
\title{
Scale vectors to fill the current plot
}
\description{
Calculates a scale factor so that a collection of vectors nearly fills the current
plot, that is, the longest vector does not extend beyond the plot region.

}
\usage{
vecscale(vectors, bbox = matrix(par("usr"), 2, 2), origin = c(0, 0), factor = 0.95)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{vectors}{
a two-column matrix giving the end points of a collection of vectors
}
  \item{bbox}{
the bounding box of the containing plot region within which the vectors are to be plotted
}
  \item{origin}{
origin of the vectors
}
  \item{factor}{
maximum length of the rescaled vectors relative to the maximum possible
}
}
%\details{
%%%  ~~ If necessary, more details than the description above ~~
%}
\value{
scale factor, the multiplier of the vectors
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{
Michael Friendly
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{vectors}}
}
\examples{
bbox <- matrix(c(-3, 3, -2, 2), 2, 2)
colnames(bbox) <- c("x","y")
rownames(bbox) <- c("min", "max")
bbox

vecs <- matrix( runif(10, -1, 1), 5, 2)

plot(bbox)
arrows(0, 0, vecs[,1], vecs[,2], angle=10, col="red")
(s <- vecscale(vecs))
arrows(0, 0, s*vecs[,1], s*vecs[,2], angle=10)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
