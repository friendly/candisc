\name{heplot.candiscList}
\alias{heplot.candiscList}
\alias{heplot3d.candiscList}

\title{Canonical Discriminant HE plots }
\description{
These functions plot ellipses (or ellipsoids in 3D)
in canonical discriminant space
representing the hypothesis and error sums-of-squares-and-products matrices for 
terms in a multivariate linear model.
They provide a low-rank 2D (or 3D) view of the effects for that term 
in the space of maximum discrimination. 
}

\usage{
\method{heplot}{candiscList}(mod, term, ask = interactive(), graphics = TRUE, ...)

\method{heplot3d}{candiscList}(mod, term, ask = interactive(), graphics = TRUE, ...)
}

\arguments{
  \item{mod}{A \code{candiscList} object for  terms in a \code{mlm} }
  \item{term}{The name of one term to be plotted for the \code{heplot} and
   \code{heplot3d} methods. If not specified, one
  plot is produced for each term in the \code{mlm} object.}
  \item{ask}{If \code{TRUE} (the default), a menu of  terms is presented; if ask is FALSE, 
  canonical HE plots for all  terms are produced.}
 \item{graphics}{if \code{TRUE} (the default, when running interactively), then the menu of terms to plot is presented in a dialog box rather than as a text menu.}
  \item{\dots}{ Arguments to be passed down }
}

%\details{
%}

\value{
No useful value; used for the side-effect of producing canonical HE plots.
}

\references{ 
Friendly, M. (2006). Data Ellipses, HE Plots and Reduced-Rank Displays for Multivariate Linear Models: SAS Software and Examples Journal of Statistical Software, 17(6), 1-42. \url{http://www.jstatsoft.org/v17/i06/} 

Friendly, M. (2007).
  HE plots for Multivariate General Linear Models.
  \emph{Journal of Computational and Graphical Statistics}, \bold{16}(2) 421--444.
  \url{http://datavis.ca/papers/jcgs-heplots.pdf} 
 }
 
\author{ Michael Friendly and John Fox }
%\note{ ~~further notes~~ 
%}
\seealso{ \code{\link{candisc}}, \code{\link{candiscList}}, \code{\link[heplots]{heplot}}, 
    \code{\link[heplots]{heplot3d}}}
    
%\examples{
%}

\keyword{multivariate}
\keyword{hplot}
