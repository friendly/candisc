# reflect methods

#' @export
reflect <- function(object, columns = 1:2, ...) {
  UseMethod("reflect")
}

reflect.data.frame <- function(object, columns = 1:2, ...) {
  
  object[, columns] <- -1 * object[, columns]
}
  
reflect.cancor <- function(object, columns = 1:2, ...) {
  
  check <- function(x, cols){
    if(!all(cols %in% 1:ncol(x))) stop("Illegal columns selected:",
                                       paste(cols, collapse = ", "))
  }
  check(object)
  object$coef$X[, columns] <- -1 * object$coef$X[, columns]
  object$coef$Y[, columns] <- -1 * object$coef$Y[, columns]
  
  object$scores$X[, columns] <- -1 * object$scores$X[, columns]
  object$scores$Y[, columns] <- -1 * object$scores$Y[, columns]
}

