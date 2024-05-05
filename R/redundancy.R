
#' Canonical Redundancy Analysis
#' 
#' @description
#' Calculates indices of redundancy (Stewart & Love, 1968) from a canonical
#' correlation analysis. These give the proportion of variances of the
#' variables in each set (X and Y) which are accounted for by the variables in
#' the other set through the canonical variates.
#' 
#' @aliases redundancy print.cancor.redundancy
#' @param object A \code{"cancor"} object
#' @param x A \code{"cancor.redundancy"} for the \code{print} method.
#' @param digits Number of digits to print
#' @param \dots Other arguments
#' @return An object of class \code{"cancor.redundancy"}, a list with the 
#' following 5 components:
#'    \item{Xcan.redun}{Canonical redundancies for the X variables, i.e., the
#'       total fraction of X variance accounted for by the Y variables through each
#'       canonical variate.} 
#' \item{Ycan.redun}{Canonical redundancies for the Y variables} 
#' \item{X.redun}{Total canonical redundancy for the X variables,
#'       i.e., the sum of \code{Xcan.redun}.} 
#' \item{Y.redun}{Total canonical redundancy for the Y variables} 
#' \item{set.names}{names for the X and Y sets of variables}
#' @author Michael Friendly
#' @seealso \code{\link{cancor}}
#' @references Stewart, D. and Love, W. (1968). A general canonical correlation
#' index.  \emph{Psychological Bulletin}, 70, 160-163.
#' @keywords multivariate
#' @examples
#' 
#' 	data(Rohwer, package="heplots")
#' X <- as.matrix(Rohwer[,6:10])  # the PA tests
#' Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables
#' 
#' cc <- cancor(X, Y, set.names=c("PA", "Ability"))
#' 
#' redundancy(cc)
#' ## 
#' ## Redundancies for the PA variables & total X canonical redundancy
#' ## 
#' ##     Xcan1     Xcan2     Xcan3 total X|Y 
#' ##   0.17342   0.04211   0.00797   0.22350 
#' ## 
#' ## Redundancies for the Ability variables & total Y canonical redundancy
#' ## 
#' ##     Ycan1     Ycan2     Ycan3 total Y|X 
#' ##    0.2249    0.0369    0.0156    0.2774 
#' 
#' 
#' @export redundancy
redundancy <- function(object, ...) {
    if (!inherits(object, "cancor")) 
        stop("Not a cancor object")
    cancor <- object$cancor
    Xstruc <- object$structure$X.xscores
    Ystruc <- object$structure$Y.yscores
    
    # for each canonical variate, fraction of total X, Y variance associated
    Xcan.vad <- apply(Xstruc^2, 2, mean, na.rm = TRUE)
    Ycan.vad <- apply(Ystruc^2, 2, mean, na.rm = TRUE)
    
    # canonical redundancies for X, Y variables (total fraction of X variance accounted for by Y variables through canonical
    # variables, and vice-versa)
    Xcan.redun <- Xcan.vad * cancor^2
    Ycan.redun <- Ycan.vad * cancor^2
    
    result <- list(Xcan.redun=Xcan.redun, 
	               Ycan.redun=Ycan.redun, 
	               X.redun=sum(Xcan.redun), 
	               Y.redun=sum(Ycan.redun),
	               set.names=object$names$set.names)
    class(result) <- "cancor.redundancy"
    # invisible(result)
    result
} 

print.cancor.redundancy <- function(x, digits=max(getOption("digits") - 3, 3), ...) {
	Xname <- x$set.names[1]
	Yname <- x$set.names[2]
	cat(paste("\nRedundancies for the", Xname, "variables & total X canonical redundancy\n\n"))
	Xredun <- c(x$Xcan.redun, "total X|Y"=x$X.redun)
	print(Xredun, digits=digits)
	
	cat(paste("\nRedundancies for the", Yname, "variables & total Y canonical redundancy\n\n"))
	Yredun <- c(x$Ycan.redun, "total Y|X"=x$Y.redun)
	print(Yredun, digits=digits)
	
}
