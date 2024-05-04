## Functions for canonical discriminant HE plots

# version: 0.5-7
# last revised: 10/20/2007 11:07:02 AM
# -- fixed problems in summary.candisc for ndim printed
# -- moved heplot.candisc & heplot3d.candisc to heplot.candisc.R
# -- fixed candisc.mlm and canrsqTable bugs when rank==1
# -- fixed candisc.mlm bug for 1 factor designs
# -- moved plot.candisc to its own file
# -- plot.candisc: added boxplot of canonical scores when ndim==1
# Now refer to car:::predictor.names for car_2.0
# Now just copy predictor.names from car to avoid namespace problem

## ----------------------------------------------------------------------------
# Provides:
#   candisc(), candisc.mlm() -- calculate candisc object from mlm object
#   print.candisc(), coef.candisc(), plot.candisc() -- candisc methods

## ----------------------------------------------------------------------------
## canonical scores and vectors from an mlm object
## TODO: provide a data.frame / formula method

predictor.names <- function(model, ...) {
  UseMethod("predictor.names")
}

predictor.names.default <- function(model, ...) {
  predictors <- attr(terms(model), "variables")
  as.character(predictors[3:length(predictors)])
}



#' Canonical discriminant analysis
#' 
#' \code{candisc} performs a generalized canonical discriminant analysis for
#' one term in a multivariate linear model (i.e., an \code{mlm} object),
#' computing canonical scores and vectors.  It represents a transformation of
#' the original variables into a canonical space of maximal differences for the
#' term, controlling for other model terms.
#' 
#' In typical usage, the \code{term} should be a factor or interaction
#' corresponding to a multivariate test with 2 or more degrees of freedom for
#' the null hypothesis.
#' 
#' Canonical discriminant analysis is typically carried out in conjunction with
#' a one-way MANOVA design. It represents a linear transformation of the
#' response variables into a canonical space in which (a) each successive
#' canonical variate produces maximal separation among the groups (e.g.,
#' maximum univariate F statistics), and (b) all canonical variates are
#' mutually uncorrelated.  For a one-way MANOVA with g groups and p responses,
#' there are \code{dfh} = min( g-1, p) such canonical dimensions, and tests,
#' initially stated by Bartlett (1938) allow one to determine the number of
#' significant canonical dimensions.
#' 
#' Computational details for the one-way case are described in Cooley & Lohnes
#' (1971), and in the \emph{SAS/STAT User's Guide}, "The CANDISC procedure:
#' Computational Details,"
#' \url{http://support.sas.com/documentation/cdl/en/statug/63962/HTML/default/viewer.htm#statug_candisc_sect012.htm}.
#' 
#' A generalized canonical discriminant analysis extends this idea to a general
#' multivariate linear model.  Analysis of each term in the \code{mlm} produces
#' a rank \eqn{df_h}{dfh} H matrix sum of squares and crossproducts matrix that
#' is tested against the rank \eqn{df_e}{dfe} E matrix by the standard
#' multivariate tests (Wilks' Lambda, Hotelling-Lawley trace, Pillai trace,
#' Roy's maximum root test).  For any given term in the \code{mlm}, the
#' generalized canonical discriminant analysis amounts to a standard
#' discriminant analysis based on the H matrix for that term in relation to the
#' full-model E matrix.
#' 
#' The plot method for candisc objects is typically a 2D plot, similar to a
#' biplot. It shows the canonical scores for the groups defined by the
#' \code{term} as points and the canonical structure coefficients as vectors
#' from the origin.
#' 
#' If the canonical structure for a \code{term} has \code{ndim==1}, or
#' \code{length(which)==1}, the 1D representation consists of a boxplot of
#' canonical scores and a vector diagram showing the magnitudes of the
#' structure coefficients.
#' 
#' @aliases candisc candisc.mlm coef.candisc plot.candisc print.candisc
#' summary.candisc
#' @param mod An mlm object, such as computed by \code{lm()} with a
#' multivariate response
#' @param term the name of one term from \code{mod} for which the canonical
#' analysis is performed.
#' @param type type of test for the model \code{term}, one of: "II", "III",
#' "2", or "3"
#' @param manova the \code{Anova.mlm} object corresponding to \code{mod}.
#' Normally, this is computed internally by \code{Anova(mod)}
#' @param ndim Number of dimensions to store in (or retrieve from, for the
#' \code{summary} method) the \code{means}, \code{structure}, \code{scores} and
#' \code{coeffs.*} components.  The default is the rank of the H matrix for the
#' hypothesis term.
#' @param object,x A candisc object
#' @param which A vector of one or two integers, selecting the canonical
#' dimension(s) to plot. If the canonical structure for a \code{term} has
#' \code{ndim==1}, or \code{length(which)==1}, a 1D representation of canonical
#' scores and structure coefficients is produced by the \code{plot} method.
#' Otherwise, a 2D plot is produced.
#' @param conf Confidence coefficient for the confidence circles around
#' canonical means plotted in the \code{plot} method
#' @param col A vector of the unique colors to be used for the levels of the
#' term in the \code{plot} method, one for each level of the \code{term}.  In
#' this version, you should assign colors and point symbols explicitly, rather
#' than relying on the somewhat arbitrary defaults, based on
#' \code{\link[grDevices]{palette}}
#' @param pch A vector of the unique point symbols to be used for the levels of
#' the term in the \code{plot} method
#' @param scale Scale factor for the variable vectors in canonical space.  If
#' not specified, a scale factor is calculated to make the variable vectors
#' approximately fill the plot space.
#' @param asp Aspect ratio for the \code{plot} method.  The \code{asp=1} (the
#' default) assures that the units on the horizontal and vertical axes are the
#' same, so that lengths and angles of the variable vectors are interpretable.
#' @param var.col Color used to plot variable vectors
#' @param var.lwd Line width used to plot variable vectors
#' @param var.labels Optional vector of variable labels to replace variable
#' names in the plots
#' @param var.cex Character expansion size for variable labels in the plots
#' @param var.pos Position(s) of variable vector labels wrt. the end point.  If
#' not specified, the labels are out-justified left and right with respect to
#' the end points.
#' @param rev.axes Logical, a vector of \code{length(which)}. \code{TRUE}
#' causes the orientation of the canonical scores and structure coefficients to
#' be reversed along a given axis.
#' @param ellipse Draw data ellipses for canonical scores?
#' @param ellipse.prob Coverage probability for the data ellipses
#' @param fill.alpha Transparency value for the color used to fill the
#' ellipses.  Use \code{fill.alpha} to draw the ellipses unfilled.
#' @param prefix Prefix used to label the canonical dimensions plotted
#' @param suffix Suffix for labels of canonical dimensions. If
#' \code{suffix=TRUE} the percent of hypothesis (H) variance accounted for by
#' each canonical dimension is added to the axis label.
#' @param titles.1d A character vector of length 2, containing titles for the
#' panels used to plot the canonical scores and structure vectors, for the case
#' in which there is only one canonical dimension.
#' @param points.1d Logical value for \code{plot.candisc} when only one
#' canonical dimension.
#' @param means Logical value used to determine if canonical means are printed
#' @param scores Logical value used to determine if canonical scores are
#' printed
#' @param coef Type of coefficients printed by the summary method. Any one or
#' more of "std", "raw", or "structure"
#' @param digits significant digits to print.
#' @param LRtests logical; should likelihood ratio tests for the canonical
#' dimensions be printed?
#' @param \dots arguments to be passed down.  In particular, \code{type="n"}
#' can be used with the \code{plot} method to suppress the display of canonical
#' scores.
#' @return An object of class \code{candisc} with the following components:
#' \item{dfh }{hypothesis degrees of freedom for \code{term}} \item{dfe }{error
#' degrees of freedom for the \code{mlm}} \item{rank }{number of non-zero
#' eigenvalues of \eqn{HE^{-1}}} \item{eigenvalues }{eigenvalues of
#' \eqn{HE^{-1}}} \item{canrsq }{squared canonical correlations} \item{pct }{A
#' vector containing the percentages of the \code{canrsq} of their total.}
#' \item{ndim }{Number of canonical dimensions stored in the \code{means},
#' \code{structure} and \code{coeffs.*} components} \item{means }{A data.frame
#' containing the class means for the levels of the factor(s) in the term}
#' \item{factors }{A data frame containing the levels of the factor(s) in the
#' \code{term}} \item{term }{name of the \code{term}} \item{terms }{A character
#' vector containing the names of the terms in the \code{mlm} object}
#' \item{coeffs.raw }{A matrix containing the raw canonical coefficients}
#' \item{coeffs.std }{A matrix containing the standardized canonical
#' coefficients} \item{structure }{A matrix containing the canonical structure
#' coefficients on \code{ndim} dimensions, i.e., the correlations between the
#' original variates and the canonical scores.  These are sometimes referred to
#' as Total Structure Coefficients.} \item{scores }{A data frame containing the
#' predictors in the \code{mlm} model and the canonical scores on \code{ndim}
#' dimensions.  These are calculated as \code{Y %*% coeffs.raw}, where \code{Y}
#' contains the standardized response variables.}
#' @author Michael Friendly and John Fox
#' @seealso \code{\link{candiscList}}, \code{\link[heplots]{heplot}},
#' \code{\link[heplots]{heplot3d}}
#' @references Bartlett, M. S. (1938). Further aspects of the theory of
#' multiple regression. Proc. Cambridge Philosophical Society \bold{34}, 33-34.
#' 
#' Cooley, W.W. & Lohnes, P.R. (1971). Multivariate Data Analysis, New York:
#' Wiley.
#' 
#' Gittins, R. (1985). Canonical Analysis: A Review with Applications in
#' Ecology, Berlin: Springer.
#' @keywords multivariate hplot
#' @examples
#' 
#' grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#' Anova(grass.mod, test="Wilks")
#' 
#' grass.can1 <-candisc(grass.mod, term="Species")
#' plot(grass.can1)
#' 
#' # library(heplots)
#' heplot(grass.can1, scale=6, fill=TRUE)
#' 
#' # iris data
#' iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
#' iris.can <- candisc(iris.mod, data=iris)
#' #-- assign colors and symbols corresponding to species
#' col <- c("red", "brown", "green3")
#' pch <- 1:3
#' plot(iris.can, col=col, pch=pch)
#' 
#' heplot(iris.can)
#' 
#' # 1-dim plot
#' iris.can1 <- candisc(iris.mod, data=iris, ndim=1)
#' plot(iris.can1)
#' 
#' 
#' @export candisc
candisc <-
  function(mod, ...) UseMethod("candisc")


candisc.mlm <- function(mod,
                        term,
                        type = "2",
                        manova,
                        ndim = rank, ...) {
  if (!inherits(mod, "mlm")) stop("Not an mlm object")
  if (missing(manova)) manova <- Anova(mod, type = as.character(type))
  terms <- manova$terms
  if (missing(term)) term <- terms[1]
  E <- manova$SSPE
  H <- manova$SSP[[term]]
  dfe <- manova$error.df
  dfh <- manova$df[[term]]
  Sp <- E / dfe

  # from discproj.R in library(fpc)
  tdecomp <- function(m) {
    wm <- eigen(m, symmetric = TRUE)
    p <- ncol(m)
    wmd <- wm$values
    out <- t(wm$vectors %*% diag(sqrt(wmd)))
    out
  }

  Tm <- tdecomp(E)
  eInv <- solve(Tm)
  eHe <- t(eInv) %*% H %*% eInv
  dc <- eigen(eHe, symmetric = TRUE)
  rank <- min(dfh, sum(dc$values > 0))
  pct <- 100 * dc$values / sum(dc$values)

  if (ndim > rank) {
    warning(paste("You asked for", ndim, "dimensions, but rank is", rank, ". ndim has been reset to", rank))
    ndim <- rank
  }

  coeffs.raw <- eInv %*% dc$vectors * sqrt(dfe)
  # should we drop the coeffs corresponding to 0 eigenvalues here or at the end?
  coeffs.raw <- as.matrix(coeffs.raw[, 1:ndim])
  rownames(coeffs.raw) <- rownames(H)
  colnames(coeffs.raw) <- cn <- paste("Can", 1:ndim, sep = "")

  # These are what SAS calls pooled within-class std. can. coefficients
  coeffs.std <- diag(sqrt(diag(Sp))) %*% coeffs.raw
  rownames(coeffs.std) <- rownames(H)
  colnames(coeffs.std) <- cn

  data <- model.frame(mod)
  Y <- model.response(data)
  Y <- scale(Y, center = TRUE, scale = FALSE)

  scores <- Y %*% coeffs.raw
  scores <- as.matrix(scores[, 1:ndim])
  colnames(scores) <- cn

  # Get the factor(s) corresponding to the term...
  all.factors <- data[, sapply(data, is.factor), drop = FALSE]
  factor.names <- unlist(strsplit(term, ":"))
  factors <- data[factor.names]

  # Canonical means for levels of the factor(s)
  means <- aggregate(scores, factors, mean)
  rownames(means) <- do.call(paste, c(means[factor.names], sep = ":"))
  means <- means[, -(1:length(factor.names))]

  # These are what SAS calls total canonical structure coefficients
  # and what I plot as vectors in my canplot macro
  structure <- cor(Y, scores)

  canrsq <- dc$values[1:ndim] / (1 + dc$values[1:ndim])

  # make scores into a data frame containing factors in mod
  # 	scores <- cbind( model.frame(mod)[,-1], scores )
  #### FIXME: scores should also include regressors in the model
  #  scores <- cbind( all.factors, as.data.frame(scores) )
  scores <- cbind(model.frame(mod)[predictor.names(mod)], as.data.frame(scores))
  result <- list(
    dfh = dfh, dfe = dfe,
    eigenvalues = dc$values, canrsq = canrsq,
    pct = pct, rank = rank, ndim = ndim, means = means,
    factors = factors, term = term, terms = terms,
    coeffs.raw = coeffs.raw, coeffs.std = coeffs.std,
    structure = structure,
    scores = scores
  )
  class(result) <- "candisc"
  result
}

# print method for candisc objects

print.candisc <- function(x, digits = max(getOption("digits") - 2, 3), LRtests = TRUE, ...) {
  table <- canrsqTable(x)
  cat(paste("\nCanonical Discriminant Analysis for ", x$term, ":\n\n", sep = ""))
  print(table, digits = digits, na.print = "")

  if (LRtests) {
    # rank <- x$rank
    # eigs <- x$eigenvalues[1:rank]
    # tests <- seqWilks(eigs, rank, x$dfh, x$dfe)
    # tests <- structure(as.data.frame(tests),
    #                    heading = paste("\nTest of H0: The canonical correlations in the",
    #                                    "\ncurrent row and all that follow are zero\n") ,
    #                    class = c("anova", "data.frame"))
    tests <- Wilks(x)
    print(tests)
  }
  invisible(x)
}


## calculate table of canonical results
canrsqTable <- function(obj) {
  rank <- obj$rank
  table <- matrix(NA, rank, 5)
  diff <- obj$eigenvalues[1:rank] - c(obj$eigenvalues[2:rank], NA) ## John
  table[, 1] <- obj$canrsq
  table[, 2] <- obj$eigenvalues[1:rank] ## John
  table[, 3] <- ifelse(rank > 1, diff, NA)
  table[, 4] <- obj$pct[1:rank] ## John
  table[, 5] <- cumsum(obj$pct[1:rank]) ## John
  rownames(table) <- 1:rank
  colnames(table) <- c("CanRsq", "Eigenvalue", "Difference", "Percent", "Cumulative")
  table
}

# Args:
#    eig: eigenvalues of HE^{-1}
#    p:  number of response variables
#    df.h:  degrees of freedom for H
#    df.e:  degrees of freedom for E
# See:
#    http://www.gseis.ucla.edu/courses/ed231a1/notes2/can1.html
#    http://www.gseis.ucla.edu/courses/ed231a1/notes3/manova.html
# Now only on wayback machine:
#    https://web.archive.org/web/20100205104138/http://www.gseis.ucla.edu/courses/ed231a1/notes2/can1.html
#    https://web.archive.org/web/20090309033727/http://www.gseis.ucla.edu/courses/ed231a1/notes3/manova.html

seqWilks <- function(eig, p, df.h, df.e) {
  p.full <- length(eig)
  result <- matrix(0, p.full, 4)
  m <- df.e + df.h - (p.full + df.h + 1) / 2
  for (i in seq(p.full)) {
    test <- prod(1 / (1 + eig[i:p.full]))
    p <- p.full + 1 - i
    q <- df.h + 1 - i
    s <- p^2 + q^2 - 5
    s <- if (s > 0) {
      sqrt(((p * q)^2 - 4) / s)
    } else {
      1
    }
    df1 <- p * q
    df2 <- m * s - (p * q) / 2 + 1
    result[i, ] <- c(
      test, ((test^(-1 / s) - 1) * (df2 / df1)),
      df1, df2
    )
  }
  result <- cbind(result, pf(result[, 2], result[, 3], result[, 4], lower.tail = FALSE))
  colnames(result) <- c("LR test stat", "approx F", "num Df", "den Df", "Pr(> F)")
  rownames(result) <- 1:p.full
  result
}

## summary method for a candisc object

summary.candisc <- function(object, means = TRUE, scores = FALSE,
                            coef = c("std"),
                            ndim, # default is min(3, rank, #cumsum(object$pct) < 99) unless ndim<rank
                            digits = max(getOption("digits") - 2, 4), ...) {
  table <- canrsqTable(object)
  cat(paste("\nCanonical Discriminant Analysis for ", object$term, ":\n\n", sep = ""))
  print(table, digits = digits, na.print = "")


  if (missing(ndim)) {
    if (object$ndim < object$rank) {
      ndim <- object$ndim
    } # ndim was set, use that
    else if (object$rank > 3) {
      ndim <- min(3, object$rank, sum(cumsum(object$pct) < 99))
    } else {
      ndim <- object$rank
    }
  }

  if (means) {
    cat("\nClass means:\n\n")
    if (ndim < 2) {
      print(object$means, digits = digits)
    } else {
      print(as.matrix(object$means[, 1:ndim]), digits = digits)
    }
  }
  # allow for printing any of raw, std, structure coeffs, or none (NULL)
  if (!is.null(coef)) {
    coef <- match.arg(coef, c("std", "raw", "structure"), several.ok = TRUE)
    for (typ in coef) {
      cat("\n", typ, "coefficients:\n")
      coeffs <- coef(object, type = typ)[, 1:ndim]
      print(coeffs, digits = digits)
    }
  }

  if (scores) {
    cat("\nCanonical scores:\n\n")
    print(object$scores[, paste("Can", 1:ndim, sep = "")], digits = digits)
  }

  invisible(NULL)
}

## coef method for a candisc object
coef.candisc <- function(object, type = c("std", "raw", "structure"), ...) {
  type <- match.arg(type)
  switch(type,
    std = object$coeffs.std,
    raw = object$coeffs.raw,
    structure = object$structure
  )
}
