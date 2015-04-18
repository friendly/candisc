\name{HSB}
\alias{HSB}
\docType{data}
\title{High School and Beyond Data}
\description{
The High School and Beyond Project was a longitudinal study of students in the U.S.
carried out in 1980 by the National Center for Education Statistics.  
Data were collected from 58,270 high school students (28,240 seniors and 30,030 sophomores) and 1,015 secondary schools. 
The HSB data frame is sample of 600 observations, of unknown characteristics, originally taken
from Tatsuoka (1988). 
}
\usage{data(HSB)}
\format{
  A data frame with 600 observations on the following 15 variables.  There is no missing data.
  \describe{
    \item{\code{id}}{Observation id: a numeric vector}
    \item{\code{gender}}{a factor with levels \code{male} \code{female}}
    \item{\code{race}}{Race or ethnicity: a factor with levels \code{hispanic} \code{asian} \code{african-amer} \code{white}}
    \item{\code{ses}}{Socioeconomic status: a factor with levels \code{low} \code{middle} \code{high}}
    \item{\code{sch}}{School type: a factor with levels \code{public} \code{private}}
    \item{\code{prog}}{High school program: a factor with levels \code{general} \code{academic} \code{vocation}}
    \item{\code{locus}}{Locus of control: a numeric vector}
    \item{\code{concept}}{Self-concept: a numeric vector}
    \item{\code{mot}}{Motivation: a numeric vector}
    \item{\code{career}}{Career plan: a factor with levels \code{clerical} \code{craftsman} 
        \code{farmer} \code{homemaker} \code{laborer} \code{manager} \code{military} 
        \code{operative} \code{prof1} \code{prof2} \code{proprietor} \code{protective} 
        \code{sales} \code{school} \code{service} \code{technical} \code{not working}}
    \item{\code{read}}{Standardized reading score: a numeric vector}
    \item{\code{write}}{Standardized writing score: a numeric vector}
    \item{\code{math}}{Standardized math score: a numeric vector}
    \item{\code{sci}}{Standardized science score: a numeric vector}
    \item{\code{ss}}{Standardized social science (civics) score: a numeric vector}
  }
}
%\details{
%}

\source{
Tatsuoka, M. M. (1988).  Multivariate Analysis: Techniques for Educational and Psychological Research (2nd ed.).
New York: Macmillan, Appendix F, 430-442.

%Retrieved from:
%\url{http://www.gseis.ucla.edu/courses/data/hbs6.dta}
}
\references{
High School and Beyond data files:
\url{http://www.sscnet.ucla.edu/issr/da/index/techinfo/I78961.HTM}
}
\examples{
str(HSB)
# main effects model
hsb.mod <- lm( cbind(read, write, math, sci, ss) ~
		gender + race + ses + sch + prog, data=HSB)
Anova(hsb.mod)

# Add some interactions
hsb.mod1 <- update(hsb.mod, . ~ . + gender:race + ses:prog)
heplot(hsb.mod1, col=palette()[c(2,1,3:6)], variables=c("read","math"))

hsb.can1 <- candisc(hsb.mod1, term="race")
heplot(hsb.can1, col=c("red", "black"))

# show canonical results for all terms
\dontrun{
hsb.can <- candiscList(hsb.mod)
hsb.can
}

}
\keyword{datasets}
