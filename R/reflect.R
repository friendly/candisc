# reflect methods

#' Reflect Columns in an Object, reversing the sign of all elements
#' 
#' @description
#' `candisc` and `cancor`  objects have coefficients for the X and Y and weighted scores for these,
#' whose signs are arbitrary, in the sense that a given column can be reflected (multiplied by -1) without changing the fit.
#' But, often you will want to reverse the direction of one or more dimensions for ease of interpretation.
#' 
#' This function allows you to reflect any columns of the variable coefficients (and corresponding observation scores). 
#' This is often useful for interpreting a biplot, for example when a component (often the first) has all negative signs.
#' 
#' @details
#' `reflect` methods are available for:
#' 
#' * `data.frame`s, for numeric columns
#' *  `"cancor"` objects, for the coefficients and scores of the `X` and `Y` variables
#' *  `"candisc"` objects, for the coefficients, structure correlations and scores
#' 
#' Note that [plot.candisc()] and [plot.candisc()] can handle this internally using the argument `rev.axes`.
#' 
#' @param object  An object whose columns are to be reflected
#' @param columns a vector of indices of the columns to reflect
#' @param ...     Unused
#'
#' @returns The object with specified columns of the appropriate components (variable coefficients, observation scores, ...) multiplied by -1.
#' @author Michael Friendly
#' @seealso [ggbiplot::reflect] has similar methods for PCA-like objects
#' @export
#' @examples
#' # None yet
#' 
reflect <- function(object, columns = 1:2, ...) {
  UseMethod("reflect")
}

#' @describeIn reflect `"data.frame"` method.
#' @export
reflect.data.frame <- function(object, columns = 1:2, ...) {

  check_cols(object, columns)  
  check_numeric(object, columns)
  object[, columns] <- -1 * object[, columns]
  object
}
  
#' @describeIn reflect `"cancor"` method.
#' @export
reflect.cancor <- function(object, columns = 1:2, ...) {
  
  # check <- function(x, cols){
  #   if(!all(cols %in% 1:ncol(x))) stop("Illegal columns selected:",
  #                                      paste(cols, collapse = ", "))
  # }

  check_cols(object$coef$X, columns)
  object$coef$X[, columns] <- -1 * object$coef$X[, columns]
  object$coef$Y[, columns] <- -1 * object$coef$Y[, columns]
  
  object$scores$X[, columns] <- -1 * object$scores$X[, columns]
  object$scores$Y[, columns] <- -1 * object$scores$Y[, columns]
  
  object
}

#' @describeIn reflect `"candisc"` method.
#' @export
reflect.candisc <- function(object, columns = 1:2, ...) {
  
  object$coeffs_raw[, columns] <- -1 * object$coeffs_raw[, columns]
  object$coeffs_std[, columns] <- -1 * object$coeffs_std[, columns]

  object$structure[, columns] <- -1 * object$structure[, columns]
  object$scores[, columns] <- -1 * object$scores[, columns]
  
  object
  
}

check_cols <- function(x, cols)  {
  xcols <- 1:ncol(x)
  if (!all(cols %in% xcols)) stop("Illegal columns selected:",
                                       paste(cols, collapse = ", "))
}

check_numeric <- function(x, cols)  {
  df <- x[, cols]
  if (!all(sapply(df, is.numeric))) stop("Only numeric columns can be reflected:",
                                       paste(cols, collapse = ", "))
}

