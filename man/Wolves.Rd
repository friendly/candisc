\name{Wolves}
\alias{Wolves}
\docType{data}
\title{Wolf skulls }
\description{
Skull morphometric data on Rocky Mountain and Arctic
wolves (Canis Lupus L.) taken from Morrison (1990),
originally from Jolicoeur (1959). 
}
\usage{data(Wolves)}
\format{
  A data frame with 25 observations on the following 11 variables.
  \describe{
    \item{\code{group}}{a factor with levels \code{ar:f} \code{ar:m} \code{rm:f} \code{rm:m},
    comprising the combinations of \code{location} and \code{sex}}
    \item{\code{location}}{a factor with levels \code{ar}=Artic, \code{rm}=Rocky Mountain}
    \item{\code{sex}}{a factor with levels \code{f}=female, \code{m}=male}
    \item{\code{x1}}{palatal length, a numeric vector}
    \item{\code{x2}}{postpalatal length, a numeric vector}
    \item{\code{x3}}{zygomatic width, a numeric vector}
    \item{\code{x4}}{palatal width outside first upper molars, a numeric vector}
    \item{\code{x5}}{palatal width inside second upper molars, a numeric vector}
    \item{\code{x6}}{postglenoid foramina width, a numeric vector}
    \item{\code{x7}}{interorbital width, a numeric vector}
    \item{\code{x8}}{braincase width, a numeric vector}
    \item{\code{x9}}{crown length, a numeric vector}
  }
}
\details{
All variables are expressed in millimeters. 

The goal was to determine how geographic and sex differences among the wolf
populations are determined by these skull measurements. 
For MANOVA or (canonical) discriminant analysis, the factors \code{group}
or \code{location} and \code{sex} provide alternative
parameterizations.
}
\source{
Morrison, D. F.  \emph{Multivariate Statistical Methods},  (3rd ed.), 1990. 
New York: McGraw-Hill, p. 288-289.

%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
Jolicoeur, P. ``Multivariate geographical variation in the wolf \emph{Canis lupis L.}'',
\emph{Evolution}, XIII, 283--299.
}
\examples{
data(Wolves)

# using group
wolf.mod <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9)~group, data=Wolves)
Anova(wolf.mod)

(wolf.can <-candisc(wolf.mod))
plot(wolf.can)
heplot(wolf.can)

# using location, sex
wolf.mod2 <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9)~location*sex, data=Wolves)
Anova(wolf.mod2)

(wolf.can2 <-candiscList(wolf.mod2))
plot(wolf.can2)

}
\keyword{datasets}
