
#' Scale vectors to fill the current plot
#' 
#' Calculates a scale factor so that a collection of vectors nearly fills the
#' current plot, that is, the longest vector does not extend beyond the plot
#' region.
#' 
#' 
#' @param vectors a two-column matrix giving the end points of a collection of
#'        vectors
#' @param bbox the bounding box of the containing plot region within which the
#'        vectors are to be plotted
#' @param origin origin of the vectors
#' @param factor maximum length of the rescaled vectors relative to the maximum
#'        possible
#' @return scale factor, the multiplier of the vectors
#' @author Michael Friendly
#' @seealso \code{\link{vectors}}
#' @keywords manip
#' @examples
#' 
#' bbox <- matrix(c(-3, 3, -2, 2), 2, 2)
#' colnames(bbox) <- c("x","y")
#' rownames(bbox) <- c("min", "max")
#' bbox
#' 
#' vecs <- matrix( runif(10, -1, 1), 5, 2)
#' 
#' plot(bbox)
#' arrows(0, 0, vecs[,1], vecs[,2], angle=10, col="red")
#' (s <- vecscale(vecs))
#' arrows(0, 0, s*vecs[,1], s*vecs[,2], angle=10)
#' 
#' @export vecscale
vecscale <- function(vectors, 
		bbox=matrix(par("usr"), 2, 2),
		origin=c(0, 0), factor=0.95) {	
	scale <- c(sapply(bbox[,1] - origin[1], function(dist) dist/vectors[,1]), 
			sapply(bbox[,2] - origin[2], function(dist) dist/vectors[,2])) 
	scale <- factor * min(scale[scale > 0])
	scale
}


