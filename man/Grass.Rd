\name{Grass}
\alias{Grass}
\docType{data}
\title{Yields from Nitrogen nutrition of grass species}
\description{
  The data frame \code{Grass} gives the yield (10 * log10 dry-weight (g))
  of eight grass Species in five replicates (Block) grown in sand culture
  at five levels of nitrogen.
}
\usage{data(Grass)}
\format{
  A data frame with 40 observations on the following 7 variables.
  \describe{
    \item{\code{Species}}{a factor with levels 
        \code{B.media} \code{D.glomerata} \code{F.ovina} \code{F.rubra} \code{H.pubesens} 
        \code{K.cristata} \code{L.perenne} \code{P.bertolonii}}
    \item{\code{Block}}{a factor with levels \code{1} \code{2} \code{3} \code{4} \code{5}}
    \item{\code{N1}}{species yield at 1 ppm Nitrogen}
    \item{\code{N9}}{species yield at 9 ppm Nitrogen}
    \item{\code{N27}}{species yield at 27 ppm Nitrogen}
    \item{\code{N81}}{species yield at 81 ppm Nitrogen}
    \item{\code{N243}}{species yield at 243 ppm Nitrogen}
  }
}
\details{
  Nitrogen (NaNO3) levels were chosen to vary from what was expected to be from
  critically low to almost toxic.  The amount of Nitrogen can be considered on
  a log3 scale, with levels 0, 2, 3, 4, 5.  Gittins (1985, Ch. 11) treats these
  as equally spaced for the purpose of testing polynomial trends in Nitrogen level.

  The data are also not truly multivariate, but rather a split-plot experimental design.
  For the purpose of exposition, he regards Species as the experimental unit, so
  that correlations among the responses refer to a composite representative of a species
  rather than to an individual exemplar.
}
\source{
Gittins, R. (1985), Canonical Analysis: A Review with Applications in Ecology,
    Berlin: Springer-Verlag, Table A-5.
}
%\references{
%}

\examples{
str(Grass)
grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
Anova(grass.mod)

grass.canL <-candiscList(grass.mod)
names(grass.canL)
names(grass.canL$Species)

}
\keyword{datasets}
