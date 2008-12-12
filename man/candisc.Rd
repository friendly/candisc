\name{candisc}
\alias{candisc}
\alias{candisc.mlm}
\alias{coef.candisc}
\alias{plot.candisc}
\alias{print.candisc}
\alias{summary.candisc}

\title{Canonical discriminant analysis}
\description{
 \code{candisc} performs a generalized canonical discriminant analysis for
 one term in a multivariate linear model (i.e., an \code{mlm} object),
 computing canonical scores and vectors.  It represents a transformation
 of the original variables into a canonical space of maximal differences
 for the term, controlling for other model terms.
 To be of any use,
 the term should be a factor or interaction corresponding to a
 multivariate test with 2 or more degrees of freedom for the
 null hypothesis.
}
\usage{
candisc(mod, ...)

\method{candisc}{mlm}(mod, term, type = "2", manova, ndim = rank, ...)

\method{coef}{candisc}(object, type = c("std", "raw", "structure"), ...)

\method{plot}{candisc}(x, which = 1:2, conf = 0.95, col, pch, scale, asp = 1,
    var.col = "blue", var.lwd = par("lwd"), prefix = "Can", suffix=TRUE, ...)
    
\method{print}{candisc}(x, digits=max(getOption("digits") - 2, 3), ...)

\method{summary}{candisc}(object, means = TRUE, scores = FALSE, coef = c("std"),
    ndim, digits = max(getOption("digits") - 2, 4), ...)
}


\arguments{
  \item{mod}{An mlm object, such as computed by lm() with a multivariate response}
  \item{term}{the name of one term from \code{mod}}
  \item{type}{type of test for the model \code{term}, one of: "II", "III", "2", or "3"}
  \item{manova}{the \code{Anova.mlm} object corresponding to \code{mod}.  Normally,
    this is computed internally by  \code{Anova(mod)}}
  \item{ndim}{Number of dimensions to store in (or retrieve from, for the \code{summary} method)
  the \code{means}, \code{structure}, \code{scores} and
    \code{coeffs.*} components.  The default is the rank of the H matrix for the hypothesis
  term.}
  \item{object, x}{A candisc object}
  \item{which}{A vector of two integers, selecting the canonical dimensions to plot}
  \item{conf}{Confidence coefficient for the confidence circles plotted in the \code{plot} method}
  \item{col}{A vector of colors to be used for the levels of the term in the \code{plot} method}
  \item{pch}{A vector of point symbols to be used for the levels of the term in the \code{plot} method}
  \item{scale}{Scale factor for the variable vectors in canonical space.  If not specified, a scale
  factor is calculated to make the variable vectors approximately fill the plot space. }
  \item{asp}{Aspect ratio for the \code{plot} method.  The \code{asp=1} (the default) assures that
  the units on the horizontal and vertical axes are the same, so that lengths and angles of the
  variable vectors are interpretable.}
  \item{var.col}{Color used to plot variable vectors}
  \item{var.lwd}{Line width used to plot variable vectors}
  \item{prefix}{Prefix used to label the canonical dimensions plotted}
  \item{suffix}{Suffix for labels of canonical dimensions. If \code{suffix=TRUE}
  the percent of hypothesis (H) variance accounted for by each canonical dimension is added to the axis label.}
  \item{means}{Logical value used to determine if canonical means are printed}
  \item{scores}{Logical value used to determine if canonical scores are printed}
  \item{coef}{Type of coefficients printed by the summary method. Any one or more of
  "std", "raw", or "structure"}
  \item{digits}{significant digits to print.}
  \item{\dots}{arguments to be passed down.  In particular, \code{type="n"} can be used with
  the \code{plot} method to suppress the display of canonical scores.}
}
\details{
Canonical discriminant analysis is typically carried out in conjunction with
a one-way MANOVA design. It represents a linear transformation of the response variables
into a canonical space in which (a) each successive canonical variate produces
maximal separation among the groups (e.g., maximum univariate F statistics), and
(b) all canonical variates are mutually uncorrelated. 
For a one-way MANOVA with g groups and p responses, there are 
\code{dfh} = min( g-1, p) such canonical dimensions, and tests, initally stated
by Bartlett (1938) allow one to determine the number of significant 
canonical dimensions.   Computational details for the one-way case are described
in Cooley & Lohnes (1971), and in the SAS/STAT User's Guide,  "The CANDISC procedure:
Computational Details," \url{http://support.sas.com/onlinedoc/913/getDoc/en/statug.hlp/candisc_sect12.htm}.

A generalized canonical discriminant analysis extends this idea to a general
multivariate linear model.  Analysis of each term in the \code{mlm} produces
a rank \eqn{df_h}{dfh} H matrix sum of squares and crossproducts matrix that is 
tested against the rank \eqn{df_e}{dfe} E matrix by the standard multivariate
tests (Wilks' Lambda, Hotelling-Lawley trace, Pillai trace, Roy's maximum root
test).  For any given term in the \code{mlm}, the generalized canonical discriminant
analysis amounts to a standard discriminant analysis based on the H matrix for that
term in relation to the full-model E matrix.

}
\value{
  An object of class \code{candisc} with the following components:
  	\item{dfh }{hypothesis degrees of freedom for \code{term}}
  	\item{dfe }{error degrees of freedom for the \code{mlm}}
  	\item{rank }{number of non-zero eigenvalues of $HE^{-1}$}
  	\item{eigenvalues }{eigenvalues of $HE^{-1}$}
  	\item{canrsq }{squared canonical correlations}
  	\item{pct }{A vector containing the percentages of the \code{canrsq} of their total.}
  	\item{ndim }{Number of canonical dimensions stored in the \code{means}, \code{structure} and \code{coeffs.*} components}
  	\item{means }{A data.frame containing the class means for the levels of the factor(s) in the term}
  	\item{factors }{A data frame containing the levels of the factor(s) in the \code{term}}
  	\item{term }{name of the \code{term}}
  	\item{terms }{A character vector containing the names of the terms in the \code{mlm} object}
  	\item{coeffs.raw }{A matrix containing the raw canonical coefficients}
  	\item{coeffs.std }{A matrix containing the standardized canonical coefficients}
    	\item{structure }{A matrix containing the canonical structure coefficients on \code{ndim} dimensions, i.e.,
    	the correlations between the original variates and the canonical scores.
    	These are sometimes referred to as Total Structure Coefficients.}
  	\item{scores }{A data frame containing the predictors in the \code{mlm} model and the
  	canonical scores on \code{ndim} dimensions. 
    These are calculated as \code{Y \%*\% coeffs.raw}, where \code{Y} contains the
  	standardized response variables.}
}
\references{
Bartlett, M. S. (1938). Further aspects of the theory of multiple regression. Proc. Camb. Phil. Soc. 34, 33-34.

Cooley, W.W. & Lohnes, P.R. (1971). Multivariate Data Analysis,  New York: Wiley.

Gittins, R. (1985). Canonical Analysis: A Review with Applications in Ecology,
Berlin: Springer.

}
\author{Michael Friendly and John Fox}

\seealso{ \code{\link{candiscList}}, \code{\link[heplots]{heplot}},  \code{\link[heplots]{heplot3d}}}
\examples{
grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
Anova(grass.mod,test="Wilks")

grass.can1 <-candisc(grass.mod, term="Species")
plot(grass.can1, type="n")

# library(heplots)
heplot(grass.can1, scale=6)

# iris data
iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
iris.can <- candisc(iris.mod, data=iris)
plot(iris.can)

heplot(iris.can)

# 1-dim plot
iris.can1 <- candisc(iris.mod, data=iris, ndim=1)
plot(iris.can1)

}

\keyword{multivariate}
\keyword{hplot}

