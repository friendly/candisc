# HE plot for a cancor object



#' Canonical Correlation HE plots
#'
#' @description
#'  
#' Hypothesis - Error (HE) plots for canonical correlation analysis provide a new graphical method
#' for understanding the relations between two sets of variables, \eqn{\mathbf{X}} and \eqn{\mathbf{Y}}.
#' They are similar to HE plots for multivariate multiple regression (MMRA) problems,
#' except that ...
#' 
#' These functions plot ellipses (or ellipsoids in 3D) in canonical space
#' representing the hypothesis and error sums-of-squares-and-products matrices
#' for terms in a multivariate linear model representing the result of a
#' canonical correlation analysis. They provide a low-rank 2D (or 3D) view of
#' the effects in the space of maximum canonical correlations, together with
#' variable vectors representing the correlations of Y variables with the
#' canonical dimensions.
#' 
#' For consistency with \code{\link{heplot.candisc}}, the plots show effects in
#' the space of the canonical Y variables selected by \code{which}.
#' 
#' The interpretation of variable vectors in these plots is different from that
#' of the \code{terms} plotted as H "ellipses," which appear as degenerate
#' lines in the plot (because they correspond to 1 df tests of rank(H)=1).
#' 
#' In canonical space, the interpretation of the H ellipses for the
#' \code{terms} is the same as in ordinary HE plots: a term is significant
#' \emph{iff} its H ellipse projects outside the (orthogonalized) E ellipsoid
#' somewhere in the space of the Y canonical dimensions. The orientation of
#' each H ellipse with respect to the Y canonical dimensions indicates which
#' dimensions that X variate contributes to.
#' 
#' On the other hand, the variable vectors shown in these plots are intended
#' only to show the correlations of Y variables with the canonical dimensions.
#' Only their relative lengths and angles with respect to the Y canonical
#' dimensions have meaning. Relative lengths correspond to proportions of
#' variance accounted for in the Y canonical dimensions plotted; angles between
#' the variable vectors and the canonical axes correspond to the structure
#' correlations.  The absolute lengths of these vectors are typically
#' manipulated by the \code{scale} argument to provide better visual resolution
#' and labeling for the variables.
#' 
#' Setting the aspect ratio of these plots is important for the proper
#' interpretation of angles between the variable vectors and the coordinate
#' axes.  However, this then makes it impossible to change the aspect ratio of
#' the plot by re-sizing manually.
#' 
#' @aliases heplot.cancor heplot3d.cancor
#' @param mod A \code{cancor} object
#' @param which A numeric vector containing the indices of the Y canonical
#'        dimensions to plot.
#' @param scale Scale factor for the variable vectors in canonical space.  If
#'        not specified, the function calculates one to make the variable vectors
#'        approximately fill the plot window.
#' @param asp aspect ratio setting. Use \code{asp=1} in 2D plots and
#'        \code{asp="iso"} in 3D plots to ensure equal units on the axes. Use
#'        \code{asp=NA} in 2D plots and \code{asp=NULL} in 3D plots to 
#'        allow separate scaling for the axes. See Details below.
#' @param var.vectors Which variable vectors to plot?  A character vector
#'        containing one or more of \code{"X"} and \code{"Y"}.
#' @param var.col Color(s) for variable vectors and labels, a vector of length
#'        1 or 2.  The first color is used for Y vectors and the second for X vectors,
#'        if these are plotted.
#' @param var.lwd Line width for variable vectors
#' @param var.cex Text size for variable vector labels
#' @param var.xpd logical. Allow variable labels outside the plot box? Does not
#'        apply to 3D plots.
#' @param prefix Prefix for labels of the Y canonical dimensions.
#' @param suffix Suffix for labels of canonical dimensions. If
#'        \code{suffix=TRUE} the percent of hypothesis (H) variance accounted for by
#'        each canonical dimension is added to the axis label.
#' @param terms Terms for the X variables to be plotted in canonical space. The
#'        default, \code{terms=TRUE} or \code{terms="X"} plots H ellipses for all of
#'       the X variables. \code{terms="Xcan"} plots H ellipses for all of the X
#'       canonical variables, \code{Xcan1}, \code{Xcan2}, \dots.
#' @param \dots Other arguments passed to \code{link[heplots]{heplot}}. In
#'       particular, you can pass linear hypotheses among the term variables via
#'       \code{hypotheses}.
#' @return Returns invisibly an object of class \code{"heplot"}, with
#'       coordinates for the various hypothesis ellipses and the error ellipse, and
#'       the limits of the horizontal and vertical axes. 
#' @author Michael Friendly
#' @seealso 
#'       \code{\link{cancor}} for details on canonical correlation as
#'       implemented here; 
#'       \code{\link{plot.cancor}} for scatterplots of canonical 
#'       variable scores.
#'       \code{\link{heplot.candisc}}, \code{\link[heplots]{heplot}},
#'       \code{\link[car]{linearHypothesis}}
#' @references Gittins, R. (1985). \emph{Canonical Analysis: A Review with
#' Applications in Ecology}, Berlin: Springer.
#' 
#' Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979). \emph{Multivariate
#' Analysis}. London: Academic Press.
#' @keywords hplot multivariate
#' @export
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' X <- as.matrix(Rohwer[,6:10])
#' Y <- as.matrix(Rohwer[,3:5])
#' cc <- cancor(X, Y, set.names=c("PA", "Ability"))
#' 
#' # basic plot
#' heplot(cc)
#' 
#' # note relationship of joint hypothesis to individual ones
#' heplot(cc, scale=1.25, hypotheses=list("na+ns"=c("na", "ns")))
#' 
#' # more options
#' heplot(cc, hypotheses=list("All X"=colnames(X)),
#' 	fill=c(TRUE,FALSE), fill.alpha=0.2,
#' 	var.cex=1.5, var.col="red", var.lwd=3,
#' 	prefix="Y canonical dimension"
#' 	)
#' 
#' # 3D version
#' \dontrun{
#' heplot3d(cc, var.lwd=3, var.col="red")
#' }
#' 
#' 
heplot.cancor <- function (
	mod,		         # output object from cancor
	which=1:2,       # canonical dimensions to plot
	scale,           # scale factor(s) for variable vectors in can space
	asp=1,           # aspect ratio, to ensure equal units?
	var.vectors = "Y", # which variable vectors to show?
	var.col=c("blue", "darkgreen"),  # colors for Y and X variable vectors and labels
	var.lwd=par("lwd"),
	var.cex=par("cex"),
	var.xpd=TRUE,     # was: par("xpd"),
	prefix = "Ycan",  # prefix for labels of canonical dimensions
	suffix = TRUE,   # add label suffix with can % ?
	terms=TRUE,  # terms to be plotted in canonical space / TRUE=all
	...              # extra args passed to heplot
	) {

  if (!inherits(mod, "cancor")) stop("Not a cancor object")
	if (mod$ndim < 2 || length(which)==1) {
		# using stop() here would terminate heplot.candiscList
	   message("Can't do a 1 dimensional canonical HE plot")
#	   plot(mod, which=which, var.col=var.col, var.lwd=var.lwd, prefix=prefix, suffix=suffix, ...) 
	   return()
	}

	Yvars <- mod$names$Y
	scores <- data.frame(mod$scores$X, mod$scores$Y)
	scores <- data.frame(scores, mod$X)   # append X variables
	Xcoef <- mod$coef$X
	Ycoef <- mod$coef$Y
	Ycan <- colnames(Ycoef)

	canr <- mod$cancor
  lambda <- canr^2 / (1-canr^2)
  pct = 100*lambda / sum(lambda)

  if ((is.logical(terms) && terms) || terms=="X") {
  	terms <- mod$names$X
	}
	# allow plotting the Xcan variables
	else if (length(terms)==1 && terms=="Xcan") terms=colnames(Xcoef)

	# make sure that all terms are available	
	if (!all(terms %in% colnames(scores))) {
			stop(paste(setdiff(terms, colnames(scores) ), "are not among the available variables"))
		}

##   Construct the model formula to fit mod$Yscores ~ Xscores in original lm()
##   using the mod$scores data.frame
#browser()
  txt <- paste( "lm( cbind(",
              paste(Ycan, collapse = ","),
              ") ~ ",
              paste( terms, collapse = "+"), ", data=scores)" )
  can.mod <- eval(parse(text=txt))
  
##   Construct labels for canonical variables
	canvar <- Ycan[which]   # names of canonical variables to plot
	if (is.logical(suffix) & suffix)
		suffix <- paste( " (", round(pct[which],1), "%)", sep="" ) else suffix <- NULL
	canlab <- paste(prefix, which, suffix, sep="")

  ellipses <- heplot(can.mod, terms=terms, 
  		xlab=canlab[1], ylab=canlab[2], asp=asp, ...)
  
	struc <- mod$structure
  Xstructure <- struc$X.yscores[,which]
  Ystructure <- struc$Y.yscores[,which]
  vec <- rbind(
  	if ("Y" %in% var.vectors) Ystructure else NULL,
  	if ("X" %in% var.vectors) Xstructure else NULL)

	maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		vecrange <- range(vec)
		ellrange <- lapply(ellipses, range)
		vecmax <- maxrms(vec)
		ellmax <- max( maxrms(ellipses$E), unlist(lapply(ellipses$H, maxrms)) )
		scale <- floor(  0.9 * ellmax / vecmax )
		cat("Vector scale factor set to ", scale, "\n")
	}
  
  if ("Y" %in% var.vectors) vectors(Ystructure, scale=scale, col=var.col[1], lwd=var.lwd, cex=var.cex, xpd=var.xpd)
  if ("X" %in% var.vectors) vectors(Xstructure, scale=scale, col=var.col[2], lwd=var.lwd, cex=var.cex, xpd=var.xpd)

	invisible(ellipses)
	

}
