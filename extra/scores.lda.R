# Extract discriminant scores for lda()
# -- just a thin wrapper on predict_discrim to provide a `scores()` method


#' Extract Observation Discriminant Scores for Linear Discriminant Analysis
#' 
#' This is a thin wrapper for [predict_discrim()] to provide a `scores()` method for discriminant analysis
#' from [MASS::lda()].
#'
#' @param x      An object of class `"lda"` such as results from [MASS::lda()]
#' @param prior   The prior probabilities of the classes. By default, taken to be the proportions in what was set 
#'                in the call to [MASS::lda()]
#' @param dimen   The dimension of the space to be used. If this is less than the number of available dimensions, 
#'                \eqn{min(p, ng-1)}, only the first `dimen` discriminant components are used. 
#' @param ...     Unused; for compatibility with the generic
#'
#' @returns    a data frame for the observations with columns `LD1`, `LD2`, ... for the discriminant dimensions
#' @author Michael Friendly
#' @seealso [predict_discrim()], [MASS::lda()]
#' @export
#'
#' @examples
#' library(MASS)   # for lda()
#' 
#' iris.lda <- lda(Species ~ ., iris)
#' scores(iris.lda) |>
#'    str()
#'  
scores.lda <- function(x,
                       prior = object$prior,
                       dimen,
                       ...) {

  scores <- predict_discrim(x,
                            dimen = dimen,
                            scores = TRUE, 
                            posterior = FALSE)
  # get the LD scores
  dims <- grep("LD", names(scores))
  scores[, dims]
}