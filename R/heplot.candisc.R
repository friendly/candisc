## heplot methods for a candisc object

# last revised: 10/29/2007 9:54:32 AM
# --- fixed bug in heplot3d.candisc; added prefix= arg to heplot3d.candisc
# --- added test for ndim==1 in heplot.candisc
# --- added test for ndim==1 in heplot.candiscList

# last revised: 6 Oct 2007 by J. Fox
# --- made first arguments (mod) agree with generics

# last revised: 10/3/2007 11:59AM MF
# -- fixed problems in heplot.candisc related to can$terms [thx: Georges]
# -- made asp=1 the default in heplot.candisc
# -- made terms=can$term the default in heplot.candisc
# -- did the same in heplot3d.candisc
# -- moved all heplot-related functions from old candisc.R and candiscList.R here

# last revised: 11 April 2008 by J. Fox
# -- changed default for ask argument of heplot3d.candiscList to interactive() 

# last revised: 10/8/2008 9:31PM by MF
# -- added var.lwd to heplot3d.candisc
# -- changed rgl.* to *3d functions
# last revised: 11/5/2008 by MF
# -- added sufix= to heplot.candisc and heplot3d.candisc
# last revised: 11/12/2008 by MF
# -- added asp= to heplot3d.candisc
# last revised: 5/17/2012 9:41AM by MF
# -- now use plot.candisc for a 1 df term
# heplot.candisc now returns ellipses
# use xpd=TRUE for vector labels
# added rev.axes, var.pos



#' Canonical Discriminant HE plots
#' 
#' These functions plot ellipses (or ellipsoids in 3D) in canonical
#' discriminant space representing the hypothesis and error
#' sums-of-squares-and-products matrices for terms in a multivariate linear
#' model. They provide a low-rank 2D (or 3D) view of the effects for that term
#' in the space of maximum discrimination.
#' 
#' The generalized canonical discriminant analysis for one term in a \code{mlm}
#' is based on the eigenvalues, \eqn{\lambda_i}{lambda_i}, and eigenvectors, V,
#' of the H and E matrices for that term.  This produces uncorrelated canonical
#' scores which give the maximum univariate F statistics. The canonical HE plot
#' is then just the HE plot of the canonical scores for the given term.
#' 
#' For \code{heplot3d.candisc}, the default \code{asp="iso"} now gives a
#' geometrically correct plot, but the third dimension, CAN3, is often small.
#' Passing an expanded range in \code{zlim} to \code{\link[heplots]{heplot3d}}
#' usually helps.
#' 
#' @aliases heplot.candisc heplot3d.candisc
#' @param mod A \code{candisc} object for one term in a \code{mlm}
#' @param which A numeric vector containing the indices of the canonical
#' dimensions to plot.
#' @param scale Scale factor for the variable vectors in canonical space.  If
#' not specified, the function calculates one to make the variable vectors
#' approximately fill the plot window.
#' @param asp Aspect ratio for the horizontal and vertical dimensions. The
#' defaults, \code{asp=1} for \code{heplot.candisc} and \code{asp="iso"} for
#' \code{heplot3d.candisc} ensure equal units on all axes, so that angles and
#' lengths of variable vectors are interpretable. As well, the standardized
#' canonical scores are uncorrelated, so the Error ellipse (ellipsoid) should
#' plot as a circle (sphere) in canonical space.  For \code{heplot3d.candisc},
#' use \code{asp=NULL} to suppress this transformation to iso-scaled axes.
#' @param var.col Color for variable vectors and labels
#' @param var.lwd Line width for variable vectors
#' @param var.cex Text size for variable vector labels
#' @param var.pos Position(s) of variable vector labels wrt. the end point.  If
#' not specified, the labels are out-justified left and right with respect to
#' the end points.
#' @param rev.axes Logical, a vector of \code{length(which)}. \code{TRUE}
#' causes the orientation of the canonical scores and structure coefficients to
#' be reversed along a given axis.
#' @param prefix Prefix for labels of canonical dimensions.
#' @param suffix Suffix for labels of canonical dimensions. If
#' \code{suffix=TRUE} the percent of hypothesis (H) variance accounted for by
#' each canonical dimension is added to the axis label.
#' @param terms Terms from the original \code{mlm} whose H ellipses are to be
#' plotted in canonical space.  The default is the one term for which the
#' canonical scores were computed.  If \code{terms=TRUE}, all terms are
#' plotted.
#' @param \dots Arguments to be passed down to \code{\link[heplots]{heplot}} or
#' \code{\link[heplots]{heplot3d}}
#' @return \code{heplot.candisc} returns invisibly an object of class
#' \code{"heplot"}, with coordinates for the various hypothesis ellipses and
#' the error ellipse, and the limits of the horizontal and vertical axes.
#' 
#' Similarly, \code{heploted.candisc} returns an object of class
#' \code{"heplot3d"}.
#' @author Michael Friendly and John Fox
#' @seealso \code{\link{candisc}}, \code{\link{candiscList}},
#' \code{\link[heplots]{heplot}}, \code{\link[heplots]{heplot3d}},
#' \code{\link[rgl]{aspect3d}}
#' @references Friendly, M. (2006). Data Ellipses, HE Plots and Reduced-Rank
#' Displays for Multivariate Linear Models: SAS Software and Examples
#' \emph{Journal of Statistical Software}, 17(6), 1-42.  %
#' \url{https://www.jstatsoft.org/v17/i06/}
#' \doi{10.18637/jss.v017.i06}
#' 
#' Friendly, M. (2007).  HE plots for Multivariate General Linear Models.  
#' \emph{Journal of Computational and Graphical Statistics},
#' \bold{16}(2) 421--444.  \url{http://datavis.ca/papers/jcgs-heplots.pdf},
#' \doi{10.1198/106186007X208407}.
#'
#' @keywords multivariate hplot
#' @export
#' @examples
#' 
#' ## Pottery data, from car package
#' data(Pottery, package = "carData")
#' pottery.mod <- lm(cbind(Al, Fe, Mg, Ca, Na) ~ Site, data=Pottery)
#' pottery.can <-candisc(pottery.mod)
#' 
#' heplot(pottery.can, var.lwd=3)
#' if(requireNamespace("rgl")){
#' heplot3d(pottery.can, var.lwd=3, scale=10, zlim=c(-3,3), wire=FALSE)
#' }
#' 
#' 
#' # reduce example for CRAN checks time
#' \donttest{
#' grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#' 
#' grass.can1 <-candisc(grass.mod,term="Species")
#' grass.canL <-candiscList(grass.mod)
#' 
#' heplot(grass.can1, scale=6)
#' heplot(grass.can1, scale=6, terms=TRUE)
#' heplot(grass.canL, terms=TRUE, ask=FALSE)
#' 
#' heplot3d(grass.can1, wire=FALSE)
#' # compare with non-iso scaling
#' rgl::aspect3d(x=1,y=1,z=1)
#' # or,
#' # heplot3d(grass.can1, asp=NULL)
#' }
#' 
#' ## Can't run this in example
#' # rgl::play3d(rgl::spin3d(axis = c(1, 0, 0), rpm = 5), duration=12)
#' 
#' # reduce example for CRAN checks time
#' \donttest{
#' ## FootHead data, from heplots package
#' library(heplots)
#' data(FootHead)
#' 
#' # use Helmert contrasts for group
#' contrasts(FootHead$group) <- contr.helmert
#' 
#' foot.mod <- lm(cbind(width, circum,front.back,eye.top,ear.top,jaw)~group, data=FootHead)
#' foot.can <- candisc(foot.mod)
#' heplot(foot.can, main="Candisc HE plot", 
#'  hypotheses=list("group.1"="group1","group.2"="group2"),
#'  col=c("red", "blue", "green3", "green3" ), var.col="red")
#' }
#' 
#' 
heplot.candisc <- function (
	mod,		         # output object from candisc
	which=1:2,       # canonical dimensions to plot
	scale,           # scale factor for variable vectors in can space
	asp=1,           # aspect ratio, to ensure equal units
	var.col="blue",  # color for variable vectors and labels
	var.lwd=par("lwd"),
	var.cex=par("cex"),
	var.pos,
	rev.axes=c(FALSE, FALSE),
	prefix = "Can",  # prefix for labels of canonical dimensions
	suffix = TRUE,   # add label suffix with can % ?
	terms=mod$term,  # terms to be plotted in canonical space / TRUE=all
	...              # extra args passed to heplot
	) {

  if (!inherits(mod, "candisc")) stop("Not a candisc object")
	if (mod$ndim < 2 || length(which)==1) {
		# using stop() here would terminate heplot.candiscList
	   message("Can't do a 1 dimensional canonical HE plot; using plot.candisc instead")
	   plot(mod, which=which, var.col=var.col, var.lwd=var.lwd, prefix=prefix, suffix=suffix, ...) 
	   return()
	}

	factors <- mod$factors                  # factor variable(s) from candisc
	nf <- ncol(factors)
	term <- mod$term                        # term for which candisc was done
	lm.terms <- mod$terms                   # terms in original lm
	scores <- mod$scores
	structure <- mod$structure
  structure <- mod$structure[,which]


  rev.axes <- rep(rev.axes, length.out=2)
  if(isTRUE(rev.axes[1])) {
    scores[, nf+which[1]] <- -scores[, nf+which[1]]
    structure[, 1] <- -structure[, 1]
  }
  if(isTRUE(rev.axes[2])) {
    scores[, nf+which[2]] <- -scores[, nf+which[2]]
    structure[, 2] <- -structure[, 2]
  }

##   Construct the model formula to fit mod$scores ~ terms in original lm()
##   with the mod$scores data.frame

  txt <- paste( "lm( cbind(",
              paste("Can",1:mod$rank,sep="", collapse = ","),
              ") ~ ",
              paste( lm.terms, collapse = "+"), ", data=scores)" )
  can.mod <- eval(parse(text=txt))

  
##   Construct labels for canonical variables
	canvar <- paste('Can', which, sep="")   # names of canonical variables to plot
	if (is.logical(suffix) & suffix)
		suffix <- paste( " (", round(mod$pct[which],1), "%)", sep="" ) else suffix <- NULL
	canlab <- paste(prefix, which, suffix, sep="")

	# Get H, E ellipses for the canonical scores
	# Allow to select the H terms to be plotted.
	
  if ((is.logical(terms) && terms)) {
  	terms <- lm.terms
	}
#	else terms <- mod$term
	
  ellipses <- heplot(can.mod, terms=terms, 
  		factor.means=term,
  		xlab=canlab[1], ylab=canlab[2],  asp=asp, ...)
  abline(h=0, v=0, col="gray")
  

  # DONE: replaced previous scaling with vecscale()
#  maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		scale <- vecscale(structure)
		cat("Vector scale factor set to ", scale, "\n")
	}

  # DONE: replaced with a call to vectors(); but NB: can't pass ... to vectors()
  cs <- scale * structure
  vectors(cs, col=var.col, cex=var.cex, lwd=var.lwd, pos=var.pos, xpd=TRUE)
  
  invisible(ellipses)
}

## heplot3d method for candisc object
## TODO: How to set par3d(scale) or aspect3d based on bbox of E matrix?
#      (This should be an option, because sometimes the equal-scaling
#       dimensions will be extremely thin on the 3rd dimension.)
#  TODO: Complete the calculation of scale when missing

#' @export
heplot3d.candisc <- function (
	mod,		    # output object from candisc
	which=1:3,  # canonical dimensions to plot
	scale,       # scale factor for variable vectors in can space
	asp="iso",           # aspect ratio, to ensure equal units
	var.col="blue",
	var.lwd=par("lwd"),
	var.cex=rgl::par3d("cex"),
	prefix = "Can",  # prefix for labels of canonical dimensions
	suffix = FALSE,   # add label suffix with can % ?
	terms=mod$term,  # terms to be plotted in canonical space / TRUE=all
	...         # extra args passed to heplot3d
	) {

#	factors <- mod$factors                  # factor variable(s) from candisc
	term <- mod$term                        # term for which candisc was done
	lm.terms <- mod$terms                   # terms in original lm
#	canvar <- paste('Can', which, sep="")   # names of canonical variables to plot
	# maybe the canlab labels are too long for the plot?
	if (is.logical(suffix) & suffix)
		suffix <- paste( " (", round(mod$pct[which],1), "%)", sep="" ) else suffix <- NULL
	canlab <- paste(prefix, which, suffix, sep="")
	scores <- mod$scores
	# fit can.mod for the canonical scores
  txt <- paste( "lm( cbind(",
              paste("Can",1:mod$rank,sep="", collapse = ","),
              ") ~ ",
              paste( lm.terms, collapse = "+"), ", data=scores)" )
  can.mod <- eval(parse(text=txt))

  if ((is.logical(terms) && terms)) {
  	terms <- lm.terms
	}

  ellipses <-heplot3d(can.mod, terms=terms,
  		factor.means=term,
  		xlab=canlab[1], ylab=canlab[2], zlab=canlab[3], ...)

  structure <- mod$structure[,which]
	maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		vecmax <- maxrms(structure)
		vecrange <- range(structure)
		ellrange <- lapply(ellipses, range)
		vecmax <- maxrms(structure)
		# get bbox of the 3d plot
        bbox <- matrix(rgl::par3d("bbox"),3,2,byrow=TRUE)
#    TODO: calculate scale so that vectors reasonably fill the plot
		scale <- 5
		cat("Vector scale factor set to ", scale, "\n")
#	  browser()
	}
  cs <- scale * mod$structure
  #  can this be simplified?
  for(i in 1:nrow(mod$structure)) {
  	rgl::lines3d( c(0, cs[i,1]),
  	              c(0, cs[i,2]),
  	              c(0, cs[i,3]), col=var.col, lwd=var.lwd)
  }
#  rgl.texts( cs, text=rownames(cs), col=var.col)
  rgl::texts3d( cs, texts=rownames(cs), col=var.col, cex=var.cex)

  if (!is.null(asp)) rgl::aspect3d(asp)
  
  invisible(ellipses)
}



#' Canonical Discriminant HE plots
#' 
#' These functions plot ellipses (or ellipsoids in 3D) in canonical
#' discriminant space representing the hypothesis and error
#' sums-of-squares-and-products matrices for terms in a multivariate linear
#' model. They provide a low-rank 2D (or 3D) view of the effects for that term
#' in the space of maximum discrimination.
#' 
#' 
#' @aliases heplot.candiscList heplot3d.candiscList
#' @param mod A \code{candiscList} object for terms in a \code{mlm}
#' @param term The name of one term to be plotted for the \code{heplot} and
#' \code{heplot3d} methods. If not specified, one plot is produced for each
#' term in the \code{mlm} object.
#' @param ask If \code{TRUE} (the default), a menu of terms is presented; if
#' ask is FALSE, canonical HE plots for all terms are produced.
#' @param graphics if \code{TRUE} (the default, when running interactively),
#' then the menu of terms to plot is presented in a dialog box rather than as a
#' text menu.
#' @param \dots Arguments to be passed down
#' @return No useful value; used for the side-effect of producing canonical HE
#' plots.
#' @author Michael Friendly and John Fox
#' @seealso \code{\link{candisc}}, \code{\link{candiscList}},
#' \code{\link[heplots]{heplot}}, \code{\link[heplots]{heplot3d}}
#' @references 
#' Friendly, M. (2006). Data Ellipses, HE Plots and Reduced-Rank
#' Displays for Multivariate Linear Models: SAS Software and Examples 
#' \emph{Journal of Statistical Software}, 17(6), 1-42.
#' \url{https://www.jstatsoft.org/v17/i06/}
#' \doi{10.18637/jss.v017.i06}.
#' 
#' Friendly, M. (2007).  HE plots for Multivariate General Linear Models.  
#' \emph{Journal of Computational and Graphical Statistics},
#' \bold{16}(2) 421--444.  \url{http://datavis.ca/papers/jcgs-heplots.pdf},
#' \doi{10.1198/106186007X208407}.
#' 
#' @keywords multivariate hplot
#' @importFrom utils menu
#' @importFrom heplots heplot heplot3d
#' @export
heplot.candiscList <- function(mod, term, ask=interactive(), graphics = TRUE, ...) {
    if (!missing(term)){
        if (is.character(term)) term <- gsub(" ", "", term)
        heplot(mod[[term]], ...)
        return(invisible())
        }
    terms <- names(mod)
    if (ask){
        repeat {
            selection <- menu(terms, graphics = graphics, title = "Select term to plot")
            if (selection == 0) break
            else {
              if (mod[[selection]]$ndim >1) heplot(mod[[selection]], ...)
              else cat("Can't do a 1 dimensional HE plot for ", terms[selection],"\n", sep="")
            }
          }
        }
    else {
        nterms <- length(mod)
        for (i in 1:nterms) {
        	heplot(mod[[i]], ...)
        	}
        }
}

#' @export
heplot3d.candiscList <- function(mod, term, ask=interactive(), graphics = TRUE, ...) {
    if (!missing(term)){
        if (is.character(term)) term <- gsub(" ", "", term)
        heplot3d(mod[[term]], ...)
        return(invisible())
        }
    terms <- names(mod)
    if (ask){
        repeat {
            selection <- menu(terms, graphics = graphics, title = "Select term to plot")
            if (selection == 0) break
            else heplot3d(mod[[selection]], ...)
            }
        }
    else {
        nterms <- length(mod)
        for (i in 1:nterms) {
        	heplot3d(mod[[i]], ...)
        	}
        }
}

