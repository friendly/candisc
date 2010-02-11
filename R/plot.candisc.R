## plot method for a candisc object

# last revised: 10/29/2007 10:32:52 AM by MF
# --- Added code to draw boxplots and variable vectors when ndim==1
# --- Fixed bug when then term is an interaction
# last revised: 11/6/2008 by MF
# --- added suffix argument
# last revised: 12/16/2008 by JF
# --- fixed plotting of variable names in 1D case
# last revised: 12/18/2008 by MF
# --- better allocation of horizontal space in 1D case
# last revised: 2/11/2010 by MF
# --- allow 1D plots for ndim>1 by specifying which

plot.candisc <- function (
		x,		     # output object from candisc
		which=1:2,   # canonical dimensions to plot
		conf=0.95,   # confidence coverage of circles for class means
		col,         # list of colors used for plotting the canonical scores
		pch,         # list of point symbols
		scale,       # scale factor for variable vectors in can space
		asp=1,       # aspect ratio, to ensure equal units
		var.col="blue",
		var.lwd=par("lwd"),
		prefix = "Can",  # prefix for labels of canonical dimensions
		suffix = TRUE,   # add label suffix with can % ?
		titles.1d = c("Canonical scores", "Structure"),
		...         # extra args passed to plot
) {
	
	term <- x$term
	factors <- x$factors
	if (x$ndim < 2 || length(which)==1) {
		which <- which[1]
		### is there a better way to show the 1D distributions of canonical scores?
		### Show the canonical structure coeffs -- vectors from 0
		op <- par(no.readonly = TRUE) # save default, for resetting...
		ng <- length(x$means)
		structure <- as.vector(x$structure[,which])
		ns <- length(structure)
		wid <- if (ns < 2*ng) c(2,1) else c(1.2,1)
		#cat("ng:", ng, "\tns:", ns, "\twid:", wid, "\n")
		layout(matrix(c(1,2),1,2), widths=wid)
		par(mar=c(5,4,4,0)+.1)
		canvar <- paste('Can', which, sep="")   # names of canonical variable to plot
		if (is.logical(suffix) & suffix)
			suffix <- paste( " (", round(x$pct[which],1), "%)", sep="" ) else suffix <- NULL
		canlab <- paste(prefix, which, suffix, sep="")
		scores <- x$scores[,canvar]
		formule <- formula( paste(canvar, " ~", term, sep="") )
		boxplot(formule, data=x$scores, ylab=canlab, xlab=term, main=titles.1d[1])
		xx <- 1:ns
		par(mar=c(5,0,4,1)+.1)
# TODO: should set ylim = c(0,1) or c(-1,1) and maybe draw tick marks
		plot(xx, structure, type="n", ylab="", xlab="", xaxt="n", yaxt="n", main=titles.1d[2])
		arrows(xx, 0, xx, structure, length=.1, 	angle=15,
				col=var.col, lwd=var.lwd )	
		abline(h=0, lty=2, col="gray")	
		vars <- rownames(x$structure)
		adj1 <- as.vector(ifelse (structure > 0, 1, 0))
		adj2 <- rep(-0.3, ns)
		adj2[1] <- 1.1
		for (i in 1:ns) text(xx[i], structure[i], paste("  ", vars[i] ,"  "), 
					adj=c(adj1[i], adj2[i]),  col=var.col, srt=90, xpd=TRUE)
		par(op)
		return(invisible())
	}
	
	canvar <- paste('Can', which, sep="")   # names of canonical variables to plot
#	canlab <- paste(prefix, which, " (", round(x$pct[which],1), "%)", sep="")
	if (is.logical(suffix) & suffix)
		suffix <- paste( " (", round(x$pct[which],1), "%)", sep="" ) else suffix <- NULL
	canlab <- paste(prefix, which, suffix, sep="")
	
	nlev <- nrow(x$means)                 # number of groups
	# TODO: can we be more clever about assigning default col & pch by taking the
	# structure of x$factors into account?
	if (missing(col)) col <- rep(palette(), length.out=nlev)
	if (missing(pch)) pch <- rep(1:18, length.out=nlev)
	
	scores <- x$scores[,canvar]
	means <- x$means[,which]
	labels <- rownames(x$means)
	structure <- x$structure[,which]
	
	# use asp=1 to make the plot equally scaled
#	Ind <- dataIndex(scores,term)
#	plot(scores, asp=asp, xlab=canlab[1], ylab=canlab[2], col=col[Ind], pch=pch[Ind], ...) 
	plot(scores, asp=asp, xlab=canlab[1], ylab=canlab[2], col=col, pch=pch, ...) 
	points(means[,1], means[,2], col=col, pch="+", cex=2)
	pos <- ifelse(means[,2]>0, 3, 1)
	text(means[,1], means[,2], labels=labels, pos=pos)
	
	# plot variable vectors
	maxrms <- function(x) { max(sqrt(apply(x^2, 1, sum))) }
	if (missing(scale)) {
		vecmax <- maxrms(structure)
		scrmax <- maxrms(scores)
		scale <- floor(  0.9 * scrmax / vecmax )
		cat("Vector scale factor set to ", scale, "\n")
	}
	cs <- scale * structure
	arrows(0, 0, cs[,1], cs[,2], length=.1, angle=15, col=var.col, lwd=var.lwd)
	vars <- rownames(structure)
	pos <- ifelse(cs[,1]>0, 4, 2)
	text(cs[,1], cs[,2], vars, pos=pos,  col=var.col)
	
	### why doesn't this work???
	circle <- function( center, radius, segments=41, ...) {
		angles <- (0:segments) * 2 * pi/segments
		unit.circle <- cbind(cos(angles), sin(angles))
#    browser()
		circle <- t(center + radius*t(unit.circle))
		lines(circle, col = col, ...)
	}
	
	# plot confidence circles for canonical means
	if ( conf>0 ) {
		n <- as.vector(table(factors))
		radii <- qchisq(conf, 2) / n
		symbols(means, circles=radii, inches=FALSE, add=TRUE, fg=col)
#	  for (i in 1:nrow(means)) {
#	  	circle(means[i,1:2], radii[i],  ...)
#	  	ellipse(as.vector(means[i,]), diag(2), radii[i], col=col, ...)
#	  }
	}
}

