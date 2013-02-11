\name{plot.cancor}
\alias{plot.cancor}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Canonical Correlation Plots
}
\description{
This function produces plots to help visualize X, Y data
in canonical space.

The present implementation plots the canonical scores for
the Y variables against those for the X variables on given
dimensions. We treat this as a view of the data in canonical
space, and so offer additional annotations to a standard
scatterplot.
}
\usage{
\method{plot}{cancor}(x, which = 1, xlim, ylim, xlab, ylab, 
    points = TRUE, add = FALSE, col = palette()[1], 
    ellipse = TRUE, ellipse.args = list(), 
    smooth = FALSE, smoother.args = list(), col.smooth = palette()[3], 
    abline = TRUE, col.lines = palette()[2], lwd = 2,
    labels = rownames(xy),
    id.method = "mahal",  id.n = 0, id.cex = 1, id.col = palette()[1],
    ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A \code{"cancor"} object
}
  \item{which}{
Which dimension to plot? An integer in \code{1:x$ndim}.
}
  \item{xlim, ylim}{
Limits for x and y axes
}
  \item{xlab, ylab}{
Labels for x and y axes.  If not specified, these are
constructed from the \code{set.names} component of \code{x}.
}
  \item{points}{
logical.  Display the points?
}
  \item{add}{
logical.  Add to an existing plot?
}
  \item{col}{
Color for points.
}
  \item{ellipse}{
logical. Draw a data ellipse for the canonical scores?
}
  \item{ellipse.args}{
Arguments passed to \code{\link[car]{dataEllipse}}.
Internally, the function sets the default value for \code{levels} to 0.68.
}
  \item{smooth}{
logical. Draw a (loess) smoothed curve?
}
  \item{smoother.args}{
Arguments passed to \code{\link[car]{loessLine}},
which should be consulted for details and defaults.
}
  \item{col.smooth}{
Color for the smoothed curve.
}
  \item{abline}{
logical. Draw the linear regression line for Ycan[,which] on Xcan[,which]?
}
  \item{col.lines}{
Color for the linear regression line
}
  \item{lwd}{
Line widths
}
  \item{labels}{
Point labels for point identification via the \code{id.method} argument.
}
  \item{id.method}{
Method used to identify individual points. See \code{\link[car]{showLabels}}
for details.  The default, \code{id.method = "mahal"} identifies the \code{id.n} points
furthest from the centroid. 
}
  \item{id.n}{
Number of points to identify
}
  \item{id.cex, id.col}{
Character size and color for labeled points
}
  \item{\dots}{
Other arguments passed down to \code{plot(\dots)} and \code{points(\dots)}
}

}
\details{
Canonical correlation analysis assumes that the all correlations between
the X and Y variables can be expressed in terms of correlations
the canonical variate pairs,
(Xcan1, Ycan1), (Xcan2, Ycan2), \dots, and that the relations between these
pairs are indeed linear. 

Data ellipses, and smoothed (loess) curves, together with the linear regression
line for each canonical dimension help to assess whether there are
peculiarities in the data that might threaten the validity of CCA.
Point identification methods can be useful to determine influential cases.
}
\value{
None.  Used for its side effect of producing a plot.
%%  ~Describe the value returned
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
\code{\link{cancor}},

\code{\link[car]{dataEllipse}},  \code{\link[car]{loessLine}}, \code{\link[car]{showLabels}}
}
\examples{
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

cc <- cancor(X, Y, set.names=c("PA", "Ability"))

plot(cc)
# exercise some options
plot(cc, smooth=TRUE, id.n=3, ellipse.args=list(fill=TRUE))
plot(cc, which=2, smooth=TRUE)
plot(cc, which=3, smooth=TRUE)


# plot vectors showing structure correlations of Xcan and Ycan with their own variables
plot(cc)
struc <- cc$structure
Xstruc <- struc$X.xscores[,1]
Ystruc <- struc$Y.yscores[,1]
scale <- 2

# place vectors in the margins of the plot
usr <- matrix(par("usr"), nrow=2, dimnames=list(c("min", "max"), c("x", "y")))
ypos <- usr[2,2] - (1:5)/10 
arrows(0, ypos, scale*Xstruc, ypos, angle=10, len=0.1, col="blue")
text(scale*Xstruc, ypos, names(Xstruc), pos=2, col="blue")

xpos <- usr[2,1] - ( 1 + 1:3)/10
arrows(xpos, 0, xpos, scale*Ystruc, angle=10, len=0.1, col="darkgreen")
text(xpos, scale*Ystruc, names(Ystruc), pos=1, col="darkgreen")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{hplot}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
