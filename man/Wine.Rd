\name{Wine}
\alias{Wine}
\docType{data}
\title{
Chemical composition of three cultivars of wine 
}
\description{
These data are the results of a chemical analysis of wines grown in the same region in Italy 
but derived from three different cultivars. 
The analysis determined the quantities of 13 constituents found in each of the three types of wines.

This data set is a classic in the machine learning literature as an easy high-D classification
problem, but is also of interest for examples of MANOVA and discriminant analysis.
}
\usage{data("Wine")}
\format{
  A data frame with 178 observations on the following 14 variables.
  \describe{
    \item{\code{Cultivar}}{a factor with levels \code{barolo} \code{grignolino} \code{barbera}}
    \item{\code{Alcohol}}{a numeric vector}
    \item{\code{MalicAcid}}{a numeric vector}
    \item{\code{Ash}}{a numeric vector}
    \item{\code{AlcAsh}}{a numeric vector, Alcalinity of ash}
    \item{\code{Mg}}{a numeric vector, Magnesium}
    \item{\code{Phenols}}{a numeric vector, Total phenols}
    \item{\code{Flav}}{a numeric vector, Flavanoids}
    \item{\code{NonFlavPhenols}}{a numeric vector}
    \item{\code{Proa}}{a numeric vector, Proanthocyanins}
    \item{\code{Color}}{a numeric vector, color intensity}
    \item{\code{Hue}}{a numeric vector}
    \item{\code{OD}}{a numeric vector, OD280/OD315 of diluted wines}
    \item{\code{Proline}}{a numeric vector}
  }
}
\details{
The precise definitions of these variables is unknown: units, how they were measured,
etc. 
}
\source{
This data set was obtained from the UCI Machine Learning Repository,
\url{http://archive.ics.uci.edu/ml/datasets/Wine}.
This page references a large number of papers that use this data set
to compare different methods.
}
\references{
In R, a comparable data set is contained in the \pkg{ggbiplot} package.
}
\examples{
data(Wine)
str(Wine)
#summary(Wine)

Wine.mlm <- lm(as.matrix(Wine[, -1]) ~ Cultivar, data=Wine)
Wine.can <- candisc(Wine.mlm)
Wine.can


plot(Wine.can, ellipse=TRUE)
plot(Wine.can, which=1)


}
\keyword{datasets}
