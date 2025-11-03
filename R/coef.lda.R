# Coef methods for lda / qda
# What to do for qda?

#' Extract Coefficients from Discriminant Analysis
#' 
#' Provides `coef` methods to extract the coefficients (`scaling` components) for variables from discriminant analysis methods [MASS::lda()] and [MASS::qda()].
#' 
#' @details
#' For [MASS::lda()] the result is a matrix whose rows are the quantitative variables in the analysis and whose columns are 
#' the coefficients of linear discriminant functions, `LD1`, `LD2`, ... This matrix transforms observations to discriminant 
#' functions, normalized so that within groups covariance matrix is spherical.
#' 
#' Quadratic discriminant analysis (from [MASS::qda()]) does not produce a simple set of "coefficients" like a linear model. 
#' Instead, the classification is based on parameters that define a quadratic score function for each class, derived from the 
#' estimated class-specific means and covariance matrices. The `scaling` components here are an array, where for each group `i`, 
#' `scaling[,,i]` is a matrix which transforms observations so that within-groups covariance matrix is spherical.
#' 
#'
#' @param object An object returned by [MASS::lda()] or [MASS::qda()]
#' @param ...    Other arguments (ignored)
#'
#' @returns Coefficients (`scaling` components) extracted from the model `object`. 
#' @export
#'
#' @rdname coef.lda
#' @examples
#' library(MASS)
#' iris.lda <- lda(Species ~ ., iris)
#' coef(iris.lda)
#' 
#' iris.qda <- qda(Species ~ ., iris)
#' coef(iris.qda)
#' 
coef.lda <- function(object, ...) {
  object$scaling
}

#' @rdname coef.lda
#' @export
coef.qda <- function(object, ...) {
  object$scaling
}
