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

## TODO:

heplot.candisc <- function (
	mod,		         # output object from candisc
	which=1:2,       # canonical dimensions to plot
	scale,           # scale factor for variable vectors in can space
	asp=1,           # aspect ratio, to ensure equal units
	var.col="blue",  # color for variable vectors and labels
	var.lwd=par("lwd"),
	prefix = "Can",  # prefix for labels of canonical dimensions
	terms=mod$term,  # terms to be plotted in canonical space / TRUE=all
	...              # extra args passed to heplot
	) {

  if (!inherits(mod, "candisc")) stop("Not a candisc object")
# using stop() here would terminate heplot.candiscList
	if (mod$ndim < 2) {
	   warning("Can't do a 1 dimensional HE plot")
	   return()
	}

	factors <- mod$factors                  # factor variable(s) from candisc
	term <- mod$term                        # term for which candisc was done
	lm.terms <- mod$terms                   # terms in original lm
	canvar <- paste('Can', which, sep="")   # names of canonical variables to plot
	canlab <- paste(prefix, which, " (", round(mod$pct[which],1), "%)", sep="")
	scores <- mod$scores

##   Construct the model formula to fit mod$scores ~ terms in original lm()
##   in  the mod$scores data.frame

  txt <- paste( "lm( cbind(",
              paste("Can",1:mod$rank,sep="", collapse = ","),
              ") ~ ",
              paste( lm.terms, collapse = "+"), ", data=scores)" )
  can.mod <- eval(parse(text=txt))

	# Get H, E ellipses for the canonical scores
	# Allow to select the H terms to be plotted.
	
  if ((is.logical(terms) && terms)) {
  	terms <- lm.terms
	}
#	else terms <- mod$term
	
  ellipses <- heplot(can.mod, terms=terms, 
  		factor.means=term,
  		xlab=canlab[1], ylab=canlab[2],  asp=asp, ...)
  
  structure <- mod$structure[,which]

	maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		vecrange <- range(structure)
		ellrange <- lapply(ellipses, range)
		vecmax <- maxrms(structure)
		ellmax <- max( maxrms(ellipses$E), unlist(lapply(ellipses$H, maxrms)) )
		scale <- floor(  0.9 * ellmax / vecmax )
		cat("Vector scale factor set to ", scale, "\n")
	}
	cs <- scale * structure
	arrows(0, 0, cs[,1], cs[,2], length=.1, angle=15, col=var.col, lwd=var.lwd)
  vars <- rownames(structure)
  pos<-ifelse(cs[,1]>0, 4, 2)
  text(cs[,1], cs[,2], vars, pos=pos,  col=var.col)

}

## heplot3d method for candisc object
## TODO:
#    - How to set par3d(scale) or aspect3d based on bbox of E matrix?
#      (This should be an option, because sometimes the equal-scaling
#       dimensions will be extremely thin on the 3rd dimension.)
#    - Complete the calculation of scale when missing

heplot3d.candisc <- function (
	mod,		    # output object from candisc
	which=1:3,  # canonical dimensions to plot
	scale,       # scale factor for variable vectors in can space
	var.col="blue",
	var.lwd=par("lwd"),
	prefix = "Can",  # prefix for labels of canonical dimensions
	terms=mod$term,  # terms to be plotted in canonical space / TRUE=all
	...         # extra args passed to heplot3d
	) {

#	factors <- mod$factors                  # factor variable(s) from candisc
	term <- mod$term                        # term for which candisc was done
	lm.terms <- mod$terms                   # terms in original lm
#	canvar <- paste('Can', which, sep="")   # names of canonical variables to plot
	# maybe the canlab labels are too long for the plot?
	suffix <- paste( " (", round(mod$pct[which],1), "%)", sep="" )
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

  heplot3d(can.mod, terms=terms,
  		factor.means=term,
  		xlab=canlab[1], ylab=canlab[2], zlab=canlab[3], ...)

  structure <- mod$structure[,which]
	maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		vecmax <- maxrms(structure)
    # get bbox of the 3d plot
    bbox <- matrix(par3d("bbox"),3,2,byrow=TRUE)
#    TODO: calculate scale so that vectors reasonably fill the plot
		scale <- 5
		cat("Vector scale factor set to ", scale, "\n")
#	  browser()
	}
  cs <- scale * mod$structure
  #  can this be simplified?
  for(i in 1:nrow(mod$structure)) {
#  	rgl.lines( c(0, cs[i,1]),
#  	           c(0, cs[i,2]),
#  	           c(0, cs[i,3]), col=var.col)
  	lines3d( c(0, cs[i,1]),
  	         c(0, cs[i,2]),
  	         c(0, cs[i,3]), col=var.col, lwd=var.lwd)
  }
#  rgl.texts( cs, text=rownames(cs), col=var.col)
  texts3d( cs, text=rownames(cs), col=var.col)

}

heplot.candiscList <- function(mod, term, ask=interactive(), ...) {
    if (!missing(term)){
        if (is.character(term)) term <- gsub(" ", "", term)
        heplot(mod[[term]], ...)
        return(invisible())
        }
    terms <- names(mod)
    if (ask){
        repeat {
            selection <- menu(terms)
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

heplot3d.candiscList <- function(mod, term, ask=interactive(), ...) {
    if (!missing(term)){
        if (is.character(term)) term <- gsub(" ", "", term)
        heplot3d(mod[[term]], ...)
        return(invisible())
        }
    terms <- names(mod)
    if (ask){
        repeat {
            selection <- menu(terms)
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

