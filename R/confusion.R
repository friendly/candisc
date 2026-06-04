# Confusion matrix for LDA / QDA

#' Confusion matrix for LDA / QDA
#'
#' Calculates a table of the actual vs. predicted class of all observations
#' in a dataset for objects resulting from [MASS::lda()] or [MASS::qda()]
#'
#' @param object  An object of class `lda` or `qda`
#' @param ...     Arguments passed to methods
#'
#' @returns An object of class `c("confusion", "table")`, a table of
#'   frequencies of actual vs. predicted class with attributes `accuracy`
#'   and `error` giving the overall rates of correct and incorrect prediction.
#' @seealso [MASS::lda()], [MASS::qda()]
#' @export
#'
#' @examples
#'
#' library(MASS)
#' iris.lda <- lda(Species ~ ., iris)
#' confusion(iris.lda)
#'
#' iris.qda <- qda(Species ~ ., iris)
#' confusion(iris.qda)
#'
confusion <- function(object, ...) UseMethod("confusion")

#' @rdname confusion
#' @export
confusion.lda <- function(object, ...) {
  .confusion_table(object)
}

#' @rdname confusion
#' @export
confusion.qda <- function(object, ...) {
  .confusion_table(object)
}

.confusion_table <- function(object) {
  actual    <- insight::get_response(object)
  predicted <- predict(object, type = "prob")$class
  tab <- table(actual = actual, predicted = predicted)
  attr(tab, "accuracy") <- sum(diag(tab)) / sum(tab) * 100
  attr(tab, "error")    <- 100 - attr(tab, "accuracy")
  class(tab) <- c("confusion", "table")
  tab
}

#' @rdname confusion
#' @param x      A `confusion` object
#' @param digits Number of decimal places for accuracy and error rates
#' @export
print.confusion <- function(x, digits = 2, ...) {
  print(structure(x, class = "table"), ...)
  fmt <- paste0("%", digits + 4L, ".", digits, "f%%\n")  # room for up to "100" + "." + digits
  cat(sprintf(paste0("\nAccuracy: ", fmt), attr(x, "accuracy")))
  cat(sprintf(paste0("Error:    ", fmt), attr(x, "error")))
  invisible(x)
}
