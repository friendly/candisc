\name{vectors}
\alias{vectors}
\alias{vectors3d}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Draw Labeled Vectors in 2D or 3D
}
\description{
Graphics utility functions to draw vectors from an origin to a collection of points
(using \code{\link[graphics]{arrows}} in 2D or \code{\link[rgl]{lines3d}} in 3D)
with labels for each (using \code{\link[graphics]{text}} or \code{\link[rgl]{texts3d}}).
}
\usage{
vectors(x, origin = c(0, 0), labels = rownames(x), 
    scale = 1, 
    col="blue",
    lwd=1, cex=1,
    length=.1, angle=13, pos=NULL,	
    ...)

vectors3d(x, origin=c(0,0,0), labels=rownames(x), 
    scale=1, 
    col="blue", 
    lwd=1, cex=1,
    ...) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A two-column matrix or a three-column matrix containing the end points of the vectors
}
  \item{origin}{Starting point(s) for the vectors}
  \item{labels}{Labels for the vectors}
  \item{scale}{A multiplier for the length of each vector}
  \item{col}{color(s) for the vectors.}
  \item{lwd}{line width(s) for the vectors.}
  \item{cex}{color(s) for the vectors.}

  \item{length}{
For \code{vectors}, length of the edges of the arrow head (in inches).
}
  \item{angle}{
For \code{vectors}, angle from the shaft of the arrow to the edge of the arrow head.
}

  \item{pos}{
For \code{vectors}, position of the text label relative to the vector head.
If \code{pos==NULL}, labels are positioned labels outside, relative to arrow ends.
}
  \item{\dots}{
other graphical parameters, such as \code{lty},  \code{xpd}, ... 
}

}
\details{
The graphical parameters \code{col}, \code{lty} and \code{lwd} 
can be vectors of length greater than one and will be recycled if necessary

}
\value{
None
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
\code{\link[graphics]{arrows}},
\code{\link[graphics]{text}},
\code{\link[graphics]{segments}}

\code{\link[rgl]{lines3d}},
\code{\link[rgl]{texts3d}}

}
\examples{
plot(c(-3, 3), c(-3,3), type="n")
X <- matrix(rnorm(10), ncol=2)
rownames(X) <- LETTERS[1:5]
vectors(X, scale=2, col=palette())

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{aplot}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
