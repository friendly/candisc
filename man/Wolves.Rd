\name{Wolves}
\alias{Wolves}
\docType{data}
\title{Wolf skulls }
\description{
Skull morphometric data on Rocky Mountain and Arctic
wolves (Canis Lupus L.) taken from Morrison (1990).
%which were taken from
%taken from Jolicoeur (1959, 1975). 
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
    \item{\code{x6}}{postgglenoid foramina width, a numeric vector}
    \item{\code{x7}}{interorbital width, a numeric vector}
    \item{\code{x8}}{braincase width, a numeric vector}
    \item{\code{x9}}{crown length, a numeric vector}
  }
}
\details{
For MANOVA or canonical discriminant analysis, either \code{group}
or \code{location} and \code{sex} provide alternative
parameterizations.
}
\source{
Morrison, D. F.  \emph{Multivariate Statistical Methods},  (3rd ed.), 1990. 
New York: McGraw-Hill, p. 288-289.

%  ~~ reference to a publication or URL from which the data were obtained ~~
}
%\references{
%  ~~ possibly secondary sources and usages ~~
%}
\examples{
data(Wolves)

wolf.mod <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9)~group, data=Wolves)

wolf.can <-candisc(wolf.mod)
plot(wolf.can)
heplot(wolf.can)


}
\keyword{datasets}
