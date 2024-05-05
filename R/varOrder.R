
#' Order variables according to canonical structure or other criteria
#' 
#' @description
#' The \code{varOrder} function implements some features of \dQuote{effect
#' ordering} (Friendly & Kwan (2003) for \emph{variables} in a multivariate
#' data display to make the displayed relationships more coherent.
#' 
#' This can be used in pairwise HE plots, scatterplot matrices, parallel
#' coordinate plots, plots of multivariate means, and so forth.
#' 
#' For a numeric data frame, the most useful displays often order variables
#' according to the angles of variable vectors in a 2D principal component
#' analysis or biplot. For a multivariate linear model, the analog is to use
#' the angles of the variable vectors in a 2D canonical discriminant biplot.
#' 
#' 
#' @aliases varOrder varOrder.mlm varOrder.data.frame
#' @param x A multivariate linear model or a numeric data frame
#' @param term For the \code{mlm} method, one term in the model for which the
#'        canonical structure coefficients are found.
#' @param variables indices or names of the variables to be ordered; defaults
#'        to all response variables an MLM or all numeric variables in a data frame.
#' @param type For an MLM, \code{type="can"} uses the canonical structure
#'        coefficients for the given \code{term}; \code{type="pc"} uses the principal
#'        component variable eigenvectors.
#' @param method One of \code{c("angles", "dim1", "dim2", "alphabet", "data",
#'        "colmean")} giving the effect ordering method.  
#'  \describe{
#'     \item{"angles"}{Orders variables according to the angles their vectors make
#'     with dimensions 1 and 2, counter-clockwise starting from the lower-left
#'     quadrant in a 2D biplot or candisc display.} \item{"dim1"}{Orders variables
#'     in increasing order of their coordinates on dimension 1}
#'     \item{"dim2"}{Orders variables in increasing order of their coordinates on
#'     dimension 2} \item{"alphabet"}{Orders variables alphabetically}
#'     \item{"data"}{Uses the order of the variables in the data frame or the list
#'     of responses in the MLM} \item{"colmean"}{Uses the order of the column means
#'     of the variables in the data frame or the list of responses in the MLM} 
#'     }
#' @param names logical; if \code{TRUE} the effect ordered names of the
#'     variables are returned; otherwise, their indices in \code{variables} are
#'     returned.
#' @param descending If \code{TRUE}, the ordered result is reversed to a
#'     descending order.
#' @param \dots Arguments passed to methods
#' @return A vector of integer indices of the variables or a character vector
#'     of their names. 
#' @author Michael Friendly
#' @references Friendly, M. & Kwan, E. (2003). Effect Ordering for Data
#'     Displays, \emph{Computational Statistics and Data Analysis}, \bold{43},
#'     509-539. \doi{10.1016/S0167-9473(02)00290-6}
#' @keywords manip multivariate
#' @examples
#' 
#' data(Wine, package="candisc")
#' Wine.mod <- lm(as.matrix(Wine[, -1]) ~ Cultivar, data=Wine)
#' Wine.can <- candisc(Wine.mod)
#' plot(Wine.can, ellipse=TRUE)
#' 
#' # pairs.mlm HE plot, variables in given order
#' pairs(Wine.mod, fill=TRUE, fill.alpha=.1, var.cex=1.5)
#' 
#' order <- varOrder(Wine.mod)
#' pairs(Wine.mod, variables=order, fill=TRUE, fill.alpha=.1, var.cex=1.5)
#' 
#' 
#' @export varOrder
varOrder <- function(x, ...) {
	UseMethod("varOrder")
}

varOrder.mlm <- function(x,
                     term,
                     variables, 
                     type = c("can", "pc"),
                     method = c("angles", "dim1", "dim2", "alphabet", "data", "colmean"),
                     names = FALSE,
                     descending = FALSE,
                     ...)
{
	data <- model.frame(x)
	Y <- model.response(data) 
	vars <- colnames(Y)
  if (!missing(variables)){
      if (is.numeric(variables)) {
          vars <- vars[variables]
          if (any(is.na(vars))) stop("Bad response variable selection.")
          }
      else {
          check <- !(variables %in% vars)
          if (any(check)) stop(paste("The following", 
              if (sum(check) > 1) "variables are" else "variable is",
              "not in the model:", paste(variables[check], collapse=", ")))
          vars <- variables
          }
      }

	method = match.arg(method)
	type   = match.arg(type)

	if (method %in% c("angles", "dim1", "dim2")) {
  	if (type == "pc")
  		struc <- eigen(cor(Y))$vectors
  	else
  		struc <- candisc(x, term)$structure
	}
	order <- switch( method,
		alphabet = order(vars),
		angles = order( ifelse( struc[vars,1] >0, 
		                        atan(struc[vars,2]/struc[vars,1]), 
		                        atan(struc[vars,2]/struc[vars,1]) + pi)),
		dim1 = order(struc[vars,1]),
		dim2 = order(struc[vars,2]),
		data = seq_along(vars),
		colmean = order(colMeans(Y))
	)
  
  if (descending) order <- rev(order)
	if (names) vars[order] else order
}

varOrder.data.frame <- 
	function(x, 
           variables, 
           method = c("angles", "dim1", "dim2", "alphabet", "data", "colmean"),
           names = FALSE,
	         descending = FALSE,
	         ...) {
	Y <- x
	vars <- colnames(Y)
  if (!missing(variables)){
      if (is.numeric(variables)) {
          vars <- vars[variables]
          if (any(is.na(vars))) stop("Bad response variable selection.")
          }
      else {
          check <- !(variables %in% vars)
          if (any(check)) stop(paste("The following", 
              if (sum(check) > 1) "variables are" else "variable is",
              "not in the data:", paste(variables[check], collapse=", ")))
          vars <- variables
          }
      }

	method = match.arg(method)
	if (method %in% c("angles", "dim1", "dim2")) {
	  struc <- eigen(cor(Y))$vectors
	}
	order <- switch( method,
  	alphabet = order(vars),
  	angles = order( ifelse( struc[vars,1] >0, 
  	                        atan(struc[vars,2]/struc[vars,1]), 
  	                        atan(struc[vars,2]/struc[vars,1]) + pi)),
  	dim1 = order(struc[vars,1]),
  	dim2 = order(struc[vars,2]),
  	data = seq_along(vars),
  	colmean = order(colMeans(Y))
	)
	if (descending) order <- rev(order)
	if (names) vars[order] else order

}
varOrder.default <- function(x, ...) {
	stop("no methods are yet available for objects of class ", class(x))
}
