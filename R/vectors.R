# utility for drawing labeled vectors
# TODO: handle xpd=TRUE somewhere so labels aren't cut off
# DONE: allow origin to be a two-col matrix like x
# TODO: calculate default length in terms of par("usr")



#' Draw Labeled Vectors in 2D or 3D
#' 
#' Graphics utility functions to draw vectors from an origin to a collection of
#' points (using [graphics::arrows()] in 2D or
#' [rgl::lines3d()] in 3D) with labels for each (using [graphics::text()]
#' or [rgl::texts3d()]
#' 
#' The graphical parameters `col`, `lty` and `lwd` can be
#' vectors of length > 1 and will be recycled if necessary across the rows of `x` which define the vectors.
#' 
#' For use in high-level plots, `vecscale()` can be used to find a value for the `scale` argument to automatically re-scale 
#' the vectors to approximately fill the plot region.
#' 
#' The option `xpd = TRUE` can be passed to `vectors()` via the `...` argument to avoid labels being clipped.
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
#' @param length For `vectors`, length of the edges of the arrow head (in
#'        inches).
#' @param angle For `vectors`, angle from the shaft of the arrow to the
#'        edge of the arrow head.
#' @param pos For `vectors`, position of the text label relative to the
#'        vector head. If `pos==NULL` (the default), labels are positioned labels outside,
#'        relative to arrow ends
#' @param \dots other graphical parameters, such as `lty`, `xpd`, ...
#' @return None
#' @author Michael Friendly
#' @seealso [graphics::arrows()], [graphics::text()], [graphics::segments()]
#' 
#'         [rgl::lines3d()], [rgl::texts3d()] 
#' @keywords aplot
#' @examples
#' 
#' set.seed(1234)
#' plot(c(-3, 3), c(-3,3), type="n",
#'      xlab = "X", ylab = "Y")
#' X <- matrix(rnorm(10), ncol=2)
#' rownames(X) <- LETTERS[1:5]
#' vectors(X, scale=2, col=palette(), xpd = TRUE)
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
		if(missing(pos)) pos <- ifelse( (x[,1] - origin[,1]) > 0, 4, 2)
		# DONE: position labels relative to arrow ends (outside)
		text(x[,1], x[,2], labels, pos=pos, cex=cex, col=col, ...)
		}
}

# Draw arrows with filled heads
# the following function isn't exported

.arrows <- function(..., angle=13){
  angles <- seq(1, angle, by=3)
  for (ang in angles) arrows(..., angle=ang)
}
