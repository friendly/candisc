\name{heplot.cancor}
\alias{heplot.cancor}
\alias{heplot3d.cancor}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Canonical Correlation HE plots}

\description{
These functions plot ellipses (or ellipsoids in 3D)
in canonical space
representing the hypothesis and error sums-of-squares-and-products matrices for 
terms in a multivariate linear model representing the result of a
canonical correlation analysis.
They provide a low-rank 2D (or 3D) view of the effects 
in the space of maximum canonical correlations, together with variable
vectors representing the correlations of Y variables with the canonical
dimensions.

For consistency with \code{\link{heplot.candisc}}, the plots show
effects in the space of the canonical Y variables selected by \code{which}.

}

\usage{
\method{heplot}{cancor}(mod, which = 1:2, scale, asp=1,
    var.vectors = "Y", var.col = c("blue", "darkgreen"), var.lwd = par("lwd"), 
    var.cex = par("cex"), var.xpd = TRUE, 
    prefix = "Ycan", suffix = TRUE, terms = TRUE, ...)

\method{heplot3d}{cancor}(mod, which = 1:3, scale, asp="iso",
    var.vectors = "Y", var.col = c("blue", "darkgreen"), var.lwd = par("lwd"), 
    var.cex = par("cex"), var.xpd = NA, 
    prefix = "Ycan", suffix = FALSE, terms = TRUE, ...)
}


%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mod}{ A \code{cancor} object}
  \item{which}{ A numeric vector containing the indices of the Y canonical
  dimensions to plot. }
  \item{scale}{ Scale factor for the variable vectors in canonical space.  If
  not specified, the function calculates one to make the variable vectors 
  approximately fill the plot window. }
  \item{asp}{aspect ratio setting. Use \code{asp=1} in 2D plots and \code{asp="iso"} in 3D plots
   to ensure equal units on the axes. Use \code{asp=NA} in 2D plots and \code{asp=NULL} in 3D plots
   to allow separate scaling for the axes. See Details below.}

  \item{var.vectors}{Which variable vectors to plot?  A character vector containing one or more
  of \code{"X"} and \code{"Y"}.}

  \item{var.col}{ Color(s) for variable vectors and labels, a vector of length 1 or 2.
  The first color is used for Y vectors and the second for X vectors, if these are plotted. }
  \item{var.lwd}{ Line width for variable vectors }
  \item{var.cex}{ Text size for variable vector labels }
  \item{var.xpd}{logical. Allow variable labels outside the plot box? Does not apply to 3D plots.}
  \item{prefix}{ Prefix for labels of the Y canonical dimensions.}
  \item{suffix}{ Suffix for labels of canonical dimensions. If \code{suffix=TRUE}
  the percent of hypothesis (H) variance accounted for by each canonical dimension is added to the axis label.}

  \item{terms}{
Terms for the X variables to be plotted in canonical space.
The default, \code{terms=TRUE} or \code{terms="X"}
plots H ellipses for all of the X variables.
\code{terms="Xcan"} plots H ellipses for all of the X canonical variables,
\code{Xcan1}, \code{Xcan2}, \dots.
}
  \item{\dots}{
Other arguments passed to \code{link[heplots]{heplot}}.
In particular, you can pass linear hypotheses among the term variables via \code{hypotheses}.
}
}
\details{
The interpretation of variable vectors in these plots is different from that of the
\code{terms} plotted as H "ellipses," which appear as degenerate lines in the plot (because they
correspond to 1 df tests of rank(H)=1).  

In canonical space, the interpretation of the H ellipses for the \code{terms} is the same
as in ordinary HE plots:  a term is significant \emph{iff} its H ellipse projects outside
the (orthogonalized) E ellipsoid somewhere in the space of the Y canonical dimensions.
The orientation of each H ellipse with respect to the Y canonical dimensions indicates
which dimensions that X variate contributes to.

On the other hand, the variable vectors shown in these plots are intended only to show
the correlations of Y variables with the canonical dimensions.  Only their relative
lengths and angles with respect to the Y canonical dimensions have meaning.
Relative lengths correspond to proportions of variance accounted for in the 
Y canonical dimensions plotted;
angles between the variable vectors and the canonical axes correspond to the
structure correlations. 
The absolute lengths of these vectors are typically manipulated by the 
\code{scale} argument to provide better visual resolution and labeling for the variables.

Setting the aspect ratio of these plots is important for the proper interpretation of
angles between the variable vectors and the coordinate axes.  
However, this then makes it impossible to change the aspect ratio of the plot
by re-sizing manually.
}
\value{
Returns invisibly an object of class \code{"heplot"}, with
  coordinates for the various hypothesis ellipses and the error ellipse, and
  the limits of the horizontal and vertical axes.
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{cancor}} for details on canonical correlation as implemented here;
\code{\link{plot.cancor}} for scatterplots of canonical variable scores.

\code{\link{heplot.candisc}}, \code{\link[heplots]{heplot}},
\code{\link[car]{linearHypothesis}} 
}
\examples{
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])
Y <- as.matrix(Rohwer[,3:5])
cc <- cancor(X, Y, set.names=c("PA", "Ability"))

# basic plot
heplot(cc)

# note relationship of joint hypothesis to individual ones
heplot(cc, scale=1.25, hypotheses=list("na+ns"=c("na", "ns")))

# more options
heplot(cc, hypotheses=list("All X"=colnames(X)),
	fill=c(TRUE,FALSE), fill.alpha=0.2,
	var.cex=1.5, var.col="red", var.lwd=3,
	prefix="Y canonical dimension"
	)

# 3D version
\dontrun{
heplot3d(cc, var.lwd=3, var.col="red")
}

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{hplot}
\keyword{multivariate}% __ONLY ONE__ keyword per line
