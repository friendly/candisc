#' @name PsyAcad
#' @aliases PsyAcad
#' @docType data
#' @title
#' Psychological Measures and Academic Achievement
#'
#' @description
#' A researcher collected data on three psychological variables, four academic variables 
#' (standardized test scores) and gender for 600 college freshman. 
#' She is interested in how the set of psychological variables relates to the academic variables and gender. 
#' In particular, the researcher is interested in how many dimensions (canonical variables) are necessary to 
#' understand the association between the two sets of variables.
#'
#' @usage data("PsyAcad")
#' @format
#'  A data frame with 600 observations on the following 8 variables.
#'  \describe{
#'    \item{\code{LocControl}}{locus of control, a numeric vector}
#'    \item{\code{SelfConcept}}{self concept, a numeric vector}
#'    \item{\code{Motivation}}{motivation, a numeric vector}
#'    \item{\code{Read}}{reading score, a numeric vector}
#'    \item{\code{Write}}{writing score, a numeric vector}
#'    \item{\code{Math}}{mathematics score, a numeric vector}
#'    \item{\code{Science}}{science score, a numeric vector}
#'    \item{\code{Sex}}{a factor with levels \code{M}, \code{F}}
#'  }
#'
#' @source 
#' Taken from \url{http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis}
#' @references
#' %%  ~~ possibly secondary sources and usages ~~
#'
#' @concept cancor
#' @examples
#' data(PsyAcad)
#' PsyAcad.can <- cancor(cbind(LocControl, SelfConcept, Motivation) ~ 
#'        Read + Write + Math + Science + Sex, data = PsyAcad)
#'
#' PsyAcad.can
#'
#'
#' @keywords datasets
NULL
