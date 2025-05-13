# plot method for cancor, borrowing from interpPlot

default.arg <- function(args.list, arg, default){
    if (is.null(args.list[[arg]])) default else args.list[[arg]]
}



#' Canonical Correlation Plots
#' 
#' @description
#' This function produces plots to help visualize X, Y data in canonical space.
#' 
#' The present implementation plots the canonical scores for the Y variables
#' against those for the X variables on given dimensions. We treat this as a
#' view of the data in canonical space, and so offer additional annotations to
#' a standard scatterplot.
#' 
#' Canonical correlation analysis assumes that the all correlations between the
#' X and Y variables can be expressed in terms of correlations the canonical
#' variate pairs, (Xcan1, Ycan1), (Xcan2, Ycan2), \dots, and that the relations
#' between these pairs are indeed linear.
#' 
#' Data ellipses, and smoothed (loess) curves, together with the linear
#' regression line for each canonical dimension help to assess whether there
#' are peculiarities in the data that might threaten the validity of CCA. Point
#' identification methods can be useful to determine influential cases.
#' 
#' @param x A \code{"cancor"} object
#' @param which Which dimension to plot? An integer in \code{1:x$ndim}.
#' @param xlim,ylim Limits for x and y axes
#' @param xlab,ylab Labels for x and y axes.  If not specified, these are
#'        constructed from the \code{set.names} component of \code{x}.
#' @param points logical.  Display the points?
#' @param add logical.  Add to an existing plot?
#' @param col Color for points.
#' @param ellipse logical. Draw a data ellipse for the canonical scores?
#' @param ellipse.args A list of arguments passed to
#'        \code{\link[car]{dataEllipse}}. Internally, the function sets the default
#'        value for \code{levels} to 0.68.
#' @param smooth logical. Draw a (loess) smoothed curve?
#' @param smoother.args Arguments passed to \code{\link[car]{loessLine}}, which
#'        should be consulted for details and defaults.
#' @param col.smooth Color for the smoothed curve.
#' @param abline logical. Draw the linear regression line for Ycan[,which] on
#'        Xcan[,which]?
#' @param col.lines Color for the linear regression line
#' @param lwd Line widths
#' @param labels Point labels for point identification via the \code{id.method}
#'        argument.
#' @param id.method Method used to identify individual points. See
#'        \code{\link[car]{showLabels}} for details.  The default, 
#'        \code{id.method = "mahal"} identifies the \code{id.n} points furthest 
#'        from the centroid.
#' @param id.n Number of points to identify
#' @param id.cex,id.col Character size and color for labeled points
#' @param \dots Other arguments passed down to \code{plot(\dots)} and
#'        \code{points(\dots)}
#' @return None.  Used for its side effect of producing a plot. %% ~Describe
#'        the value returned 
#' @author Michael Friendly
#' @seealso \code{\link{cancor}},
#' 
#' \code{\link[car]{dataEllipse}}, \code{\link[car]{loessLine}},
#' \code{\link[car]{showLabels}}
#' @references 
#' Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979).
#' \emph{Multivariate Analysis}. London: Academic Press.
#' @keywords hplot
#' @importFrom car dataEllipse showLabels loessLine
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' X <- as.matrix(Rohwer[,6:10])  # the PA tests
#' Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables
#' 
#' cc <- cancor(X, Y, set.names=c("PA", "Ability"))
#' 
#' plot(cc)
#' # exercise some options
#' plot(cc, which=1,
#'      smooth=TRUE, 
#'      pch = 16,
#'      id.n=3, ellipse.args=list(fill=TRUE, fill.alpha = 0.2))
#' plot(cc, which=2, smooth=TRUE)
#' plot(cc, which=3, smooth=TRUE)
#' 
#' 
#' # plot vectors showing structure correlations of Xcan and Ycan with their own variables
#' plot(cc)
#' struc <- cc$structure
#' Xstruc <- struc$X.xscores[,1]
#' Ystruc <- struc$Y.yscores[,1]
#' scale <- 2
#' 
#' # place vectors in the margins of the plot
#' usr <- matrix(par("usr"), nrow=2, dimnames=list(c("min", "max"), c("x", "y")))
#' ypos <- usr[2,2] - (1:5)/10 
#' arrows(0, ypos, scale*Xstruc, ypos, angle=10, len=0.1, col="blue")
#' text(scale*Xstruc, ypos, names(Xstruc), pos=2, col="blue")
#' 
#' xpos <- usr[2,1] - ( 1 + 1:3)/10
#' arrows(xpos, 0, xpos, scale*Ystruc, angle=10, len=0.1, col="darkgreen")
#' text(xpos, scale*Ystruc, names(Ystruc), pos=1, col="darkgreen")
#' 
#' 
#' @export
plot.cancor <- function(x, 
    which=1, 
		xlim, ylim, 
		xlab, ylab,
    points=TRUE, 
		add=FALSE, 
		col=palette()[1],
		ellipse = TRUE, ellipse.args = list(), 
    smooth=FALSE, smoother.args = list(), col.smooth=palette()[3],
		abline=TRUE, 
		col.lines = palette()[2], 
		lwd=2,
		labels=rownames(xy), 
		id.method = "mahal", 
		id.n = 0, id.cex = 1, id.col = palette()[1],
		...) {

  if (!inherits(x, "cancor")) 
      stop("Not a cancor object")
  # sanity checks on which
  if (length(which)>1) {
  	which <- which[1]
  	warning("plot.cancor only plots one dimension at a time")
  }
  if (! which %in% 1:x$ndim) stop(paste(which, "is not among the canonical dimensions"))

	xy <- cbind(scores(x, type="x")[,which],
              scores(x, type="y")[,which])
	
	lims <- apply(xy, 2, range)
	if (missing(xlim)) xlim=lims[,1]
	if (missing(ylim)) ylim=lims[,2]
  
  if (missing(xlab)) xlab <- paste(x$names$set.names[1], "dimension", which) 
  if (missing(ylab)) ylab <- paste(x$names$set.names[2], "dimension", which) 
    
	if (!add) plot(xy, xlim=xlim, ylim=ylim, xlab=xlab, ylab=ylab, ...)  
	if (points) points(xy, col=col, ...)
	
  if (ellipse) {
			levels <- default.arg(ellipse.args, "levels", 0.68)
      ellipse.args <- c(list(xy, add = TRUE, plot.points = FALSE, levels=levels), 
          ellipse.args)
      do.call(dataEllipse, ellipse.args)
  }
  if (abline) {
    abline(lsfit(xy[, 1], xy[, 2]), col = col.lines, 
        lwd = lwd)
  }
  if (!is.null(labels)) {
  showLabels(xy[, 1], xy[, 2], labels = labels, id.method = id.method, 
        id.n = id.n, id.cex = id.cex, id.col = id.col)
  }
  if (smooth) {
    loessLine(xy[,1], xy[,2], col=col.smooth, smoother.args = smoother.args, log.x=FALSE, log.y=FALSE)
  }
#  invisible()
}
