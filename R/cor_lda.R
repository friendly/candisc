
# Pass ... to cor() ??

#' Calculate Structure Correlations from Discriminant Analysis
#' 
#' `cor_lda()` calculates the "structure" correlations between the observed variables and the discriminant dimension scores
#' from a linear discriminant analysis provided by [MASS::lda()].  These more directly assess the direction and strength
#' of the relations between the two sets than do the `scaling` weights returned by `lda()`. They are useful for plotting
#' the discriminant scores, showing the contributions of the variables by vectors.
#'
#' @param object   An object of class `"lda"` such as results from [MASS::lda()] 
#' @param prior   The prior probabilities of the classes. By default, taken to be the proportions in what was set 
#'                in the call to [MASS::lda()]
#' @param dimen   The dimension of the space to be used. If this is less than the number of available dimensions, 
#'                \eqn{min(p, ng-1)}, only the first `dimen` discriminant components are used. 
#' @param method  a character string indicating which correlation coefficient is to be computed. One of `"pearson"` 
#'                (default), `"kendall"`, or `"spearman"`: can be abbreviated. See [stats::cor()] for details
#' @param ...     other arguments (presently ignored)
#'
#' @returns       a numeric matrix of correlations, of size `nv` = number of predictor variables * `dimen`
#' @seealso [predict_discrim()], [MASS::lda()], [stats::cor()]
#' @author Michael Friendly
#' @export
#'
#' @examples
#' library(MASS)   # for lda()
#' 
#' iris.lda <- lda(Species ~ ., iris)
#' cor_lda(iris.lda)
#' 
cor_lda <- function(
    object,
    prior = object$prior,
    dimen,
    method = c("pearson", "kendall", "spearman"),
    ...) {
  
  cls <- class(object)
  if (cls != "lda") {
    stop(paste('object must be of class `"lda"`, not', cls))
  }
  scores <- predict_discrim(object, 
                            dimen = dimen,
                            scores = TRUE, 
                            posterior = FALSE)
  # remove predicted class
  scores <- scores[, -1]

  # partition into variables and dimensions
  nc <- ncol(scores)
  dims <- grep("LD", names(scores))
  vars <- 1:(nc - length(dims))
  
  method <- match.arg(method)
  cor(scores[, vars], scores[, dims],
      method = method)
}