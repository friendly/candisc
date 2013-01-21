\name{vectors}
\alias{vectors}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Draw Labelled Vectors
}
\description{
A graphics utility function to draw vectors from an origin to a collection of points
(using \code{\link[graphics]{arrows}})
with labels for each (using \code{\link[graphics]{text}}).
}
\usage{
vectors(x, origin = c(0, 0), labels = rownames(x), 
	scale = 1, length = 0.1, angle = 10, 
	col = "blue", pos = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A two-column matrix containing the end points of the vectors
}
  \item{origin}{
Starting point(s) for the vectors
}
  \item{labels}{
Labels for the vectors
}
  \item{scale}{
A multiplier for the length of each vector
}
  \item{length}{
length of the edges of the arrow head (in inches).
}
  \item{angle}{
angle from the shaft of the arrow to the edge of the arrow head.
}
  \item{col}{
color(s) for the vectors.
}
  \item{pos}{
position of the text label relative to the vector head.
If \code{pos==NULL}, labels are positioned labels outside, relative to arrow ends.
}
  \item{\dots}{
other graphical parameters, such as \code{lty}, \code{lwd}, \code{xpd}, ... 

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
