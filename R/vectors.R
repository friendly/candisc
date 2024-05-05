# utility for drawing labeled vectors
# TODO: handle xpd=TRUE somewhere so labels aren't cut off
# DONE: allow origin to be a two-col matrix like x
# TODO: calculate default length in terms of par("usr")



#' Draw Labeled Vectors in 2D or 3D
#' 
#' Graphics utility functions to draw vectors from an origin to a collection of
#' points (using \code{\link[graphics]{arrows}} in 2D or
#' \code{\link[rgl]{lines3d}} in 3D) with labels for each (using
#' \code{\link[graphics]{text}} or \code{\link[rgl]{texts3d}}).
#' 
#' The graphical parameters \code{col}, \code{lty} and \code{lwd} can be
#' vectors of length greater than one and will be recycled if necessary
#' 
#' @aliases vectors vectors3d
#' @param x A two-column matrix or a three-column matrix containing the end
#'          points of the vectors
#' @param origin Starting point(s) for the vectors
#' @param labels Labels for the vectors
#' @param scale A multiplier for the length of each vector
#' @param col color(s) for the vectors.
#' @param lwd line width(s) for the vectors.
#' @param cex color(s) for the vectors.
#' @param length For \code{vectors}, length of the edges of the arrow head (in
#'        inches).
#' @param angle For \code{vectors}, angle from the shaft of the arrow to the
#'        edge of the arrow head.
#' @param pos For \code{vectors}, position of the text label relative to the
#'        vector head. If \code{pos==NULL}, labels are positioned labels outside,
#'        relative to arrow ends.
#' @param \dots other graphical parameters, such as \code{lty}, \code{xpd}, ...
#' @return None
#' @author Michael Friendly
#' @seealso \code{\link[graphics]{arrows}}, \code{\link[graphics]{text}},
#' \code{\link[graphics]{segments}}
#' 
#' \code{\link[rgl]{lines3d}}, \code{\link[rgl]{texts3d}}
#' @keywords aplot
#' @examples
#' 
#' plot(c(-3, 3), c(-3,3), type="n")
#' X <- matrix(rnorm(10), ncol=2)
#' rownames(X) <- LETTERS[1:5]
#' vectors(X, scale=2, col=palette())
#' 
#' 
#' @export vectors
vectors <- function(x, origin=c(0,0), labels=rownames(x), 
		scale=1, 
		col="blue",
		lwd=1,
		cex=1,
		length=.1, angle=13, 
		pos=NULL, ...) {

	x <- scale*x
	if (is.vector(origin)) origin <- matrix(origin, ncol=2)
	.arrows(origin[,1], origin[,2], 
	        x[,1], x[,2], 
	        lwd=lwd, col=col, length=length, 
	        angle=angle, ...)
	if (!is.null(labels)) {
		if(missing(pos)) pos <- ifelse(x[,1]>0, 4, 2)
		# DONE: position labels relative to arrow ends (outside)
		text(x[,1], x[,2], labels, pos=pos, cex=cex, col=col, ...)
		}
}

# the following function isn't exported

.arrows <- function(..., angle=13){
  angles <- seq(1, angle, by=3)
  for (ang in angles) arrows(..., angle=ang)
}
