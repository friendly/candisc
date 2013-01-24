# canonical correlation analysis, as a more general method, with method functions
#
# compare with :
#      stats::cancor (very basic),
#      yacca::cca (fairly complete, but very messy return structure)
#      CCA::cc (fairly complete, but very messy return structure, no longer maintained)

cancor <- function (X, Y, 
		X.names = colnames(X),
		Y.names = colnames(Y),
		row.names = rownames(X),
		xcenter = TRUE, ycenter = TRUE,    # not yet implemented (used implicitly)
		xscale = FALSE, yscale = FALSE,    # not yet implemented
		ndim=min(p,q),
		set.names=c("X", "Y"), 
		prefix=c("Xcan", "Ycan"),   # s/b: paste0(set.names, "can")
		use = "complete.obs"
		) 
{
    X = as.matrix(X)
    Y = as.matrix(Y)
    p = ncol(X)
    q = ncol(Y)
    n <- length(complete.cases(X,Y))  # TODO: honor use=
 
    Cxx <- var(X, na.rm = TRUE, use = use) 
    Cyy <- var(Y, na.rm = TRUE, use = use) 
    Cxy <- cov(X, Y, use = use)
    res <- gensvd(Cxy, Cxx, Cyy, nu=ndim, nv=ndim)
    names(res) <- c("cor", "xcoef", "ycoef")
    colnames(res$xcoef) <- paste(prefix[1], 1:ndim, sep="")
    colnames(res$ycoef) <- paste(prefix[2], 1:ndim, sep="")
    
    scores <- can.scores(X, Y, res$xcoef, res$ycoef)
    colnames(scores$xscores) <- paste(prefix[1], 1:ndim, sep="")
    colnames(scores$yscores) <- paste(prefix[2], 1:ndim, sep="")
    
    structure <- can.structure(X, Y, scores, use=use)
    result <- list(cancor = res$cor, 
    		names = list(X = X.names, Y = Y.names, 
    				row.names = row.names, set.names=set.names),
    		ndim = ndim,
    		dim = list(p=p, q=q, n=n),
    		coef = list(X = res$xcoef, Y= res$ycoef),
    		scores = list(X = scores$xscores, Y=scores$yscores),
    		X = X, Y = Y, 
        structure = structure)
    class(result) <- "cancor"
    return(result)
     
}

# scores on canonical variates
can.scores <- function (X, Y, xcoef, ycoef) 
{
    X.aux = scale(X, center=TRUE, scale=FALSE)  # TODO: incorporate xscale, yscale, etc here
    Y.aux = scale(Y, center=TRUE, scale=FALSE)
    X.aux[is.na(X.aux)] = 0
    Y.aux[is.na(Y.aux)] = 0

    xscores = X.aux %*% xcoef
    yscores = Y.aux %*% ycoef
    return(list(xscores = xscores, yscores = yscores)) 
}

# canonical structure coefficients: correlations 
can.structure <- function (X, Y, scores, use="complete.obs") {
	xscores <- scores$xscores
	yscores <- scores$yscores
    X.xscores = cor(X, xscores, use = use)
    Y.xscores = cor(Y, xscores, use = use)
    X.yscores = cor(X, yscores, use = use)
    Y.yscores = cor(Y, yscores, use = use)

    return(list( 
        X.xscores = X.xscores, 
        Y.xscores = Y.xscores, 
        X.yscores = X.yscores, 
        Y.yscores = Y.yscores))
}

# TODO: replace with equivalent qr stuff
gensvd <- function (Rxy, Rxx, Ryy, nu=p, nv=q) 
{
    p <- dim(Rxy)[1]
    q <- dim(Rxy)[2]

    if (missing(Rxx)) Rxx <- diag(p)
    if (missing(Ryy)) Ryy <- diag(q)
    
    if (dim(Rxx)[1] != dim(Rxx)[2]) stop("Rxx must be square")
    if (dim(Ryy)[1] != dim(Ryy)[2]) stop("Ryy must be square")

    s <- min(p, q)
    if (max(abs(Rxx - t(Rxx)))/max(abs(Rxx)) > 1e-10) { 
        warning("Rxx not symmetric.")
    		Rxx <- (Rxx + t(Rxx))/2
        }
    if (max(abs(Ryy - t(Ryy)))/max(abs(Ryy)) > 1e-10) {
        warning("Ryy not symmetric.")
    		Ryy <- (Ryy + t(Ryy))/2
        }
 
    Rxxinv <- solve(chol(Rxx))
    Ryyinv <- solve(chol(Ryy))
    Dform <- t(Rxxinv) %*% Rxy %*% Ryyinv
    if (p >= q) {
        result <- svd(Dform, nu=nu, nv=nv)
        values <- result$d
        Xmat <- Rxxinv %*% result$u
        Ymat <- Ryyinv %*% result$v
    }
    else {
        result <- svd(t(Dform), nu=nv, nv=nu)
        values <- result$d
        Xmat <- Rxxinv %*% result$v
        Ymat <- Ryyinv %*% result$u
    }
    gsvdlist <- list(values=values, Xmat=Xmat, Ymat=Ymat)
    return(gsvdlist)
}

# TODO: move the printout of coefficients to a summary method
print.cancor <- function(x, digits=max(getOption("digits") - 2, 3), ...) {
	names <- x$names
  cat("Canonical correlation analysis of:\n")
  cat(      "\t", x$dim$p, " ", names$set.names[1], " variables: ", paste(names$X, collapse=', '), "\n") 
  cat("  with\t", x$dim$q, " ", names$set.names[2], " variables: ", paste(names$Y, collapse=', '), "\n") 
  cat("\n")
  canr <- x$cancor
  lambda <- canr^2 / (1-canr^2)
  pct = 100*lambda / sum(lambda)
  cum = cumsum(pct)
  # TODO: add stars column, showing pct
  canrdf <- data.frame("CanR"=canr, "CanRSQ"=canr^2, "Eigen"=lambda, "percent"=pct, "cum"=cum)
  print(canrdf, digits=4)

	tests <- Wilks.cancor(x) 
	print(tests, digits=digits) 
  cat("\nRaw canonical coefficients\n")
  cat("\n  ", names$set.names[1], " variables: \n")
  print(x$coef$X, digits=digits)
  cat("\n  ", names$set.names[2], " variables: \n")
  print(x$coef$Y, digits=digits)
}

# for now, same as print()
summary.cancor <- function(object, digits=max(getOption("digits") - 2, 3), ...) {
	names <- object$names
	print(object, ...)
}



# extractor functions
scores <- function(x, ...) {
	UseMethod("scores")
}

# TODO: check rownames
scores.cancor <- function(x, type=c("x", "y", "both", "list", "data.frame"), ...) {
	type <- match.arg(type)
	switch(type,
		x = x$scores$X,
		y = x$scores$Y,
		both = x$scores,
		list = x$scores,
		data.frame = data.frame(x$scores$X, x$scores$Y)
		)
}

coef.cancor <- function(object, type=c("x", "y", "both", "list"), standardize=FALSE, ...) {
	coef <- object$coef
	if (standardize) {
		coef$X <- diag(sqrt(diag(cov(object$X)))) %*% coef$X
		coef$Y <- diag(sqrt(diag(cov(object$Y)))) %*% coef$Y
		rownames(coef$X) <- rownames(object$coef$X)
		rownames(coef$Y) <- rownames(object$coef$Y)
	}
	type <- match.arg(type)
	switch(type,
			x = coef$X,
			y = coef$Y,
			both = list(coef$X, coef$Y),
			list = list(coef$X, coef$Y)
	)
}


