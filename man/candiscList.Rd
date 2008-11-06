\name{candiscList}
\alias{candiscList}
\alias{candiscList.mlm}
\alias{plot.candiscList}
\alias{print.candiscList}
\alias{summary.candiscList}

\title{Canonical discriminant analyses}
\description{
 \code{candiscList} performs a generalized canonical discriminant analysis for
 all terms in a multivariate linear model (i.e., an \code{mlm} object),
 computing canonical scores and vectors.  
}
\usage{
candiscList(mod, ...)

\method{candiscList}{mlm}(mod, type = "2", manova, ndim, ...)

\method{plot}{candiscList}(x, term, ask = interactive(), graphics = TRUE, ...)

\method{print}{candiscList}(x, ...)

\method{summary}{candiscList}(object, ...)
}

\arguments{
  \item{mod}{An mlm object, such as computed by lm() with a multivariate response}
  \item{type}{type of test for the model \code{term}, one of: "II", "III", "2", or "3"}
  \item{manova}{the \code{Anova.mlm} object corresponding to \code{mod}.  Normally,
    this is computed internally by  \code{Anova(mod)}}
  \item{ndim}{Number of dimensions to store in the \code{means}, \code{structure}, \code{scores} and
    \code{coeffs.*} components.  The default is the rank of the H matrix for the hypothesis
  term.}
  \item{object, x}{A candiscList object}
  \item{term}{The name of one term to be plotted for the \code{plot} method.  If not specified, one
  candisc plot is produced for each term in the \code{mlm} object.}
  \item{ask}{If \code{TRUE} (the default, when running interactively), a menu of  terms is presented; if ask is FALSE, 
  canonical plots for all  terms are produced.}
  \item{graphics} {if \code{TRUE} (the default, when running interactively), then the menu of terms to plot is presented in a dialog box rather than as a text menu.} 
  \item{\dots}{arguments to be passed down.}
}
%\details{
%}

\value{
  An object of class \code{candiscList} which is a list of  \code{candisc} objects
  for the terms in the mlm.

}

\author{Michael Friendly and John Fox}


\seealso{ \code{\link{candisc}}, \code{\link[heplots]{heplot}},  \code{\link[heplots]{heplot3d}}}
\examples{
grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)

grass.canL <-candiscList(grass.mod)
print(grass.canL)
plot(grass.canL, type="n", ask=FALSE)

}

\keyword{multivariate}
\keyword{hplot}