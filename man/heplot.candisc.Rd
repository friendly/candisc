\name{heplot.candisc}
\alias{heplot.candisc}
\alias{heplot3d.candisc}
\title{ Canonical Discriminant HE plots}
\description{
These functions plot ellipses (or ellipsoids in 3D)
in canonical discriminant space
representing the hypothesis and error sums-of-squares-and-products matrices for 
terms in a multivariate linear model.
They provide a low-rank 2D (or 3D) view of the effects for that term 
in the space of maximum discrimination. 
}
\usage{
\method{heplot}{candisc}(mod, which = 1:2, scale, asp = 1, var.col = "blue", 
    var.lwd = par("lwd"), prefix = "Can", suffix = TRUE, terms = mod$term, ...)

\method{heplot3d}{candisc}(mod, which = 1:3, scale, var.col = "blue", var.lwd=par("lwd"),
    prefix = "Can", suffix = FALSE, terms = mod$term, 
    ...) 
}
    
\arguments{
  \item{mod}{ A \code{candisc} object for one term in a \code{mlm}}
  \item{which}{ A numeric vector containing the indices of the canonical
  dimensions to plot. }
  \item{scale}{ Scale factor for the variable vectors in canonical space.  If
  not specified, the function calculates one to make the variable vectors 
  approximately fill the plot window. }
  \item{asp}{Aspect ratio for the horizontal and vertical
  dimensions. The default, \code{asp=1} ensures equal units, so that angles
  and lengths of variable vectors are interpretable. As well, the 
  standardized canonical scores are uncorrelated, so the Error ellipse
  (ellipsoid) should plot as a circle (sphere) in canonical space.}
  \item{var.col}{ Color for variable vectors and labels }
  \item{var.lwd}{ Line width for variable vectors }
  \item{prefix}{ Prefix for labels of canonical dimensions.}
  \item{suffix}{ Suffix for labels of canonical dimensions. If \code{suffix=TRUE}
  the percent of hypothesis (H) variance accounted for by each canonical dimension is added to the axis label.}
  \item{terms}{ Terms  from the original \code{mlm} whose H ellipses
  are to be plotted in canonical space.  The default is the one term for
  which the canonical scores were computed.  If \code{terms=TRUE},
  all terms are plotted.}
  \item{\dots}{ Arguments to be passed down to \code{\link[heplots]{heplot}} or \code{\link[heplots]{heplot3d}}}
}

\details{
The generalized canonical discriminant analysis for on term in a \code{mlm}
is based on the eigenvalues, \eqn{\lambda_i}{lambda_i}, and eigenvectors, V,
of the H and E matrices for that term.  This produces uncorrelated
canonical scores which give the maximum univariate F statistics.
The canonical HE plot is then just the HE plot of the canonical scores
for the given term.
}

\value{
No useful value; used for the side-effect of producing a canonical HE plot.
}

\references{ 
Friendly, M. (2006). Data Ellipses, HE Plots and Reduced-Rank Displays for Multivariate Linear Models: SAS Software and Examples Journal of Statistical Software, 17(6), 1-42. \url{http://www.jstatsoft.org/v17/i06/} 

Friendly, M. (2007). HE plots for Multivariate General Linear Models. Journal of Computational and Graphical Statistics, 16 (2), 421-444. 
\url{http://www.math.yorku.ca/SCS/Papers/jcgs-heplots.pdf} 

}
\author{ Michael Friendly and John Fox }

\seealso{ \code{\link{candisc}}, \code{\link{candiscList}}, 
    \code{\link[heplots]{heplot}}, \code{\link[heplots]{heplot3d}}}

\examples{
grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)

grass.can1 <-candisc(grass.mod, term="Species")
grass.canL <-candiscList(grass.mod)

heplot(grass.can1, scale=6)
heplot(grass.can1, scale=6, terms=TRUE)
heplot(grass.canL, terms=TRUE, ask=FALSE)

# NB: aspect3d not set for equal scaling in this plot 
heplot3d(grass.can1)
# change to equal scaling, so E ellipsoid is spherical
aspect3d("iso")

## Pottery data, from car package
pottery.mod <- lm(cbind(Al, Fe, Mg, Ca, Na) ~ Site, data=Pottery)
(pottery.can <-candisc(pottery.mod))

heplot(pottery.can, var.lwd=3)
heplot3d(pottery.can, var.lwd=3, scale=10, zlim=c(-3,3))
aspect3d("iso")
## Not run: 
play3d(spin3d(axis = c(1, 0, 0), rpm = 5), duration=12)
## End(Not run)
}
\keyword{multivariate}
\keyword{hplot}