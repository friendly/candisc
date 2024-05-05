# canonical correlation analysis, as a more general method, with method functions
# Updated to implement weights
#
# compare with :
#      stats::cancor (very basic),
#      yacca::cca (fairly complete, but very messy return structure)
#      CCA::cc (fairly complete, but very messy return structure, no longer maintained)



#' Canonical Correlation Analysis
#'
#'@description 
#' The function \code{cancor} generalizes and regularizes computation for
#' canonical correlation analysis in a way conducive to visualization using
#' methods in the \code{\link[heplots]{heplots}} package.
#' 
#' The package provides the following display, extractor and plotting methods for \code{"cancor"} objects
#' \describe{
#'    \item{\code{print(), summary()}}{Print and summarise the CCA}
#'    \item{\code{coef()}}{Extract coefficients for X, Y, or both }
#'    \item{\code{scores()}}{Extract observation scores on the canonical variables}
#'    \item{\code{redundancy()}}{Redundancy analysis}
#'    \item{\code{plot()}}{Plot pairs of canonical scores}
#'    \item{\code{heplot()}}{HE plot of the Y canonical variables showing effects of the X variables and projections
#'          of the Y variables in this space.}
#' }
#' 
#' @details
#' Canonical correlation analysis (CCA), as traditionally presented is used to
#' identify and measure the associations between two sets of quantitative
#' variables, X and Y.  It is often used in the same situations for which a
#' multivariate multiple regression analysis (MMRA) would be used.  
#' 
#' However,
#' CCA is is \dQuote{symmetric} in that the sets X and Y have equivalent
#' status, and the goal is to find orthogonal linear combinations of each
#' having maximal (canonical) correlations. On the other hand, MMRA is
#' \dQuote{asymmetric}, in that the Y set is considered as responses,
#' \emph{each one} to be explained by \emph{separate} linear combinations of
#' the Xs.
#' 
#' Let \eqn{\mathbf{Y}_{n \times p}} and \eqn{\mathbf{X}_{n \times q}} be two sets of variables over which 
#' CCA is computed. We find canonical coefficients \eqn{\mathbf{A}_{p \times k}} and 
#' \eqn{\mathbf{B}_{q \times k}, k=\min(p,q)} such that the canonical variables 
#' \eqn{\mathbf{U}_{n \times k}} and \eqn{\mathbf{V}_{n \times k}} have maximal, diagonal correlation structure.
#' That is, the coefficients \eqn{\mathbf{A}} and \eqn{\mathbf{B}} are chosen such that the correlations between
#' each pair \eqn{r_i = \text{cor}(\mathbf{u}_i, \mathbf{v}_i), i=1, 2, \dots , k} 
#' are maximized and all other pairs are uncorrelated,
#' \eqn{r_{ij} = \text{cor}(\mathbf{u}_i, \mathbf{v}_j) = 0,  i \ne j}
#' 
#' For visualization using HE plots, it is most natural to consider
#' plots representing the relations among the canonical variables for the Y
#' variables in terms of a multivariate linear model predicting the Y canonical
#' scores, using either the X variables or the X canonical scores as
#' predictors.  Such plots, using \code{\link{heplot.cancor}} provide a
#' low-rank (1D, 2D, 3D) visualization of the relations between the two sets,
#' and so are useful in cases when there are more than 2 or 3 variables in each
#' of X and Y.
#' 
#' The connection between CCA and HE plots for MMRA models can be developed as
#' follows. CCA can also be viewed as a principal component transformation of
#' the predicted values of one set of variables from a regression on the other
#' set of variables, in the metric of the error covariance matrix.
#' 
#' For example, regress the Y variables on the X variables, giving predicted
#' values \eqn{\hat{Y} = X (X'X)^{-1} X' Y} and residuals \eqn{R = Y -
#' \hat{Y}}. The error covariance matrix is \eqn{E = R'R/(n-1)}.  Choose a
#' transformation Q that orthogonalizes the error covariance matrix to an
#' identity, that is, \eqn{(RQ)'(RQ) = Q' R' R Q = (n-1) I}, and apply the same
#' transformation to the predicted values to yield, say, \eqn{Z = \hat{Y} Q}.
#' Then, a principal component analysis on the covariance matrix of Z gives
#' eigenvalues of \eqn{E^{-1} H}, and so is equivalent to the MMRA analysis of
#' \code{lm(Y ~ X)} statistically, but visualized here in canonical space.
#' 
#' @aliases cancor cancor.default cancor.formula print.cancor summary.cancor
#'          coef.cancor scores scores.cancor
#' @param formula A two-sided formula of the form \code{cbind(y1, y2, y3, \dots) ~ x1 + x2 + x3 + \dots}
#' @param data The data.frame within which the formula is evaluated
#' @param subset an optional vector specifying a subset of observations to be
#'        used in the calculations.
#' @param weights Observation weights. If supplied, this must be a vector of
#'        length equal to the number of observations in X and Y, typically within
#'        [0,1].  In that case, the variance-covariance matrices are computed using
#'        \code{\link[stats]{cov.wt}}, and the number of observations is taken as the
#'        number of non-zero weights.
#' @param na.rm logical, determining whether observations with missing cases
#'        are excluded in the computation of the variance matrix of (X,Y).  See Notes
#'        for details on missing data.
#' @param method the method to be used for calculation; currently only
#'        \code{method = "gensvd"} is supported;
#' @param x Varies depending on method. For the \code{cancor.default} method,
#'        this should be a matrix or data.frame whose columns contain the X variables
#' @param y For the \code{cancor.default} method, a matrix or data.frame whose
#'        columns contain the Y variables
#' @param X.names,Y.names Character vectors of names for the X and Y variables.
#' @param row.names Observation names in \code{x}, \code{y}
#' @param xcenter,ycenter logical. Center the X, Y variables? [not yet implemented]
#' @param xscale,yscale logical. Scale the X, Y variables to unit variance? [not yet implemented]
#' @param ndim Number of canonical dimensions to retain in the result, for
#'        scores, coefficients, etc.
#' @param set.names A vector of two character strings, giving names for the
#'        collections of the X, Y variables.
#' @param prefix A vector of two character strings, giving prefixes used to
#'        name the X and Y canonical variables, respectively.
#' @param use argument passed to \code{var} determining how missing data are
#'        handled.  Only the default, \code{use="complete"} is allowed when
#'        observation weights are supplied.
#' @param object A \code{cancor} object for related methods.
#' @param digits Number of digits passed to \code{print} and \code{summary} methods
#' @param \dots Other arguments, passed to methods
#' @param type For the \code{coef} method, the type of coefficients returned,
#'        one of \code{"x"}, \code{"y"}, \code{"both"}. For the \code{scores} method,
#'        the same list, or \code{"data.frame"}, which returns a data.frame containing
#'        the X and Y canonical scores.
#' @param standardize For the \code{coef} method, whether coefficients should
#'        be standardized by dividing by the standard deviations of the X and Y
#'        variables.
#' @return An object of class \code{cancorr}, a list with the following
#'        components: 
#'    \item{cancor}{Canonical correlations, i.e., the correlations
#'        between each canonical variate for the Y variables with the corresponding
#'        canonical variate for the X variables.} 
#'    \item{names}{Names for various
#'        items, a list of 4 components: \code{X}, \code{Y}, \code{row.names}, \code{set.names}} 
#'    \item{ndim}{Number of canonical dimensions extracted, \code{<= min(p,q)}} 
#'    \item{dim}{Problem dimensions, a list of 3 components:
#'          \code{p} (number of X variables), \code{q} (number of Y variables), \code{n} (sample size)} 
#'     \item{coef}{Canonical coefficients, a list of 2 components:
#' \code{X}, \code{Y}} % 
#'     \item{scores}{Canonical variate scores, a list of 2 components: \code{X}, \code{Y}} 
#'     \item{scores}{Canonical variate scores, a list of 2 components: 
#'      \describe{ 
#'         \item{list("X")}{Canonical variate scores for the X variables} 
#'         \item{list("Y")}{Canonical variate scores for the Y variables} } 
#'         } 
#'     \item{X}{The matrix X} \item{Y}{The matrix Y}
#' \item{weights}{Observation weights, if supplied, else \code{NULL}} %
#' \item{structure}{Structure correlations, a list of 4 components:
#'     \code{X.xscores}, \code{Y.xscores}, \code{X.yscores}, \code{Y.yscores}}
#' 
#' \item{structure}{Structure correlations ("loadings"), a list of 4
#' components: 
#'   \describe{ 
#'      \item{X.xscores}{Structure correlations of the X variables with the Xcan canonical scores} 
#'      \item{Y.xscores}{Structure correlations of the Y variables with the Xcan canonical scores}
#'      \item{X.yscores}{Structure correlations of the X variables with the Ycan canonical scores} 
#'      \item{Y.yscores}{Structure correlations of the Y variables with the Ycan canonical scores} 
#'  }
#' 
#' The formula method also returns components \code{call} and \code{terms} }
#' @note Not all features of CCA are presently implemented: standardized vs.
#' raw scores, more flexible handling of missing data, other plot methods, ...
#' @author Michael Friendly
#' @seealso Other implementations of CCA: \code{\link[stats]{cancor}} (very
#' basic), \code{\link[yacca]{cca}} in the \pkg{yacca} (fairly complete, but
#' very messy return structure), \code{\link[CCA]{cc}} in \pkg{CCA} (fairly
#' complete, very messy return structure, no longer maintained).
#' 
#' \code{\link{redundancy}}, for redundancy analysis;
#' \code{\link{plot.cancor}}, for enhanced scatterplots of the canonical
#' variates.
#' 
#' \code{\link{heplot.cancor}} for CCA HE plots and
#' \code{\link[heplots]{heplots}} for generic heplot methods.
#' 
#' \code{\link{candisc}} for related methods focused on multivariate linear
#' models with one or more factors among the X variables.
#' @references Gittins, R. (1985). \emph{Canonical Analysis: A Review with
#' Applications in Ecology}, Berlin: Springer.
#' 
#' Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979). \emph{Multivariate
#' Analysis}. London: Academic Press.
#' @keywords multivariate
#' @examples
#' 
#' data(Rohwer, package="heplots")
#' X <- as.matrix(Rohwer[,6:10])  # the PA tests
#' Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables
#' 
#' # visualize the correlation matrix using corrplot()
#' if (require(corrplot)) {
#' M <- cor(cbind(X,Y))
#' corrplot(M, method="ellipse", order="hclust", addrect=2, addCoef.col="black")
#' }
#' 
#' 
#' (cc <- cancor(X, Y, set.names=c("PA", "Ability")))
#' 
#' ## Canonical correlation analysis of:
#' ##       5   PA  variables:  n, s, ns, na, ss 
#' ##   with        3   Ability  variables:  SAT, PPVT, Raven 
#' ## 
#' ##     CanR  CanRSQ   Eigen percent    cum                          scree
#' ## 1 0.6703 0.44934 0.81599   77.30  77.30 ******************************
#' ## 2 0.3837 0.14719 0.17260   16.35  93.65 ******                        
#' ## 3 0.2506 0.06282 0.06704    6.35 100.00 **                            
#' ## 
#' ## Test of H0: The canonical correlations in the 
#' ## current row and all that follow are zero
#' ## 
#' ##      CanR  WilksL      F df1   df2  p.value
#' ## 1 0.67033 0.44011 3.8961  15 168.8 0.000006
#' ## 2 0.38366 0.79923 1.8379   8 124.0 0.076076
#' ## 3 0.25065 0.93718 1.4078   3  63.0 0.248814
#' 
#' 
#' # formula method
#' cc <- cancor(cbind(SAT, PPVT, Raven) ~  n + s + ns + na + ss, data=Rohwer, 
#'     set.names=c("PA", "Ability"))
#' 
#' # using observation weights
#' set.seed(12345)
#' wts <- sample(0:1, size=nrow(Rohwer), replace=TRUE, prob=c(.05, .95))
#' (ccw <- cancor(X, Y, set.names=c("PA", "Ability"), weights=wts) )
#' 
#' # show correlations of the canonical scores 
#' zapsmall(cor(scores(cc, type="x"), scores(cc, type="y")))
#' 
#' # standardized coefficients
#' coef(cc, type="both", standardize=TRUE)
#' 
#' plot(cc, smooth=TRUE)
#' 
#' ##################
#' data(schooldata)
#' ##################
#' 
#' #fit the MMreg model
#' school.mod <- lm(cbind(reading, mathematics, selfesteem) ~ 
#' education + occupation + visit + counseling + teacher, data=schooldata)
#' car::Anova(school.mod)
#' pairs(school.mod)
#' 
#' # canonical correlation analysis
#' school.cc <- cancor(cbind(reading, mathematics, selfesteem) ~ 
#' education + occupation + visit + counseling + teacher, data=schooldata)
#' school.cc
#' heplot(school.cc, xpd=TRUE, scale=0.3)
#' 
#' 
#' @export cancor
cancor <- function(x, ...) {
  UseMethod("cancor", x)
}

#' @describeIn cancor \code{"formula"} method.
#' @export
cancor.formula <- function(formula, data, subset, weights,
                           na.rm = TRUE,           # DONE: now just use na.rm
                           method = "gensvd",      # "qr" not implemented
                           # 		contrasts = NULL,  # would it make any sense to allow factors? should we test for factors in X?
                           ...) {

  # remove the intercept [solution by John Fox]
  formula <- update(formula, . ~ . - 1)
  cl <- match.call()
  cl$formula <- formula
  mf <- match.call(expand.dots = FALSE)
  mf$formula <- formula
  m <- match(c("formula", "data", "subset", "weights"), names(mf), 0L)
  mf <- mf[c(1L, m)]


  mf[[1L]] <- as.name("model.frame")
  mf <- eval(mf, parent.frame())
  mt <- attr(mf, "terms")

  y <- model.response(mf, "numeric")
  w <- as.vector(model.weights(mf))
  if (!is.null(w) && !is.numeric(w)) {
    stop("'weights' must be a numeric vector")
  }

  x <- model.matrix(mt, mf, contrasts)
  z <- cancor.default(x, y, weights = w, na.rm = na.rm, ...)

  z$call <- cl
  z$terms <- mt
  z
}


# var-cov matrix allowing weights
# Without weights, honors na.rm and use
# With weights, na.rm --> use='complete'

Var <- function(x, na.rm = TRUE, use, weights) {
  if (missing(weights) || is.null(weights)) {
    res <- var(x, na.rm = na.rm, use = use)
  } else {
    # cov.wt doesn't allow for missing data, and doesn't allow x, y=NULL, ...
    if (na.rm) {
      if (!pmatch(use, "complete")) warning("Use of weights only supports use='complete'")
      OK <- complete.cases(x)
      x <- x[OK, ]
    }
    res <- cov.wt(x, wt = weights)$cov
  }
  res
}

# DONE:  add weights component to result
# DONE:  add a method=argument
# TODO:  should replace X, Y by x, y throughout to avoid another copy
# DONE:  allow weights, by use of cov.wt() as in dataEllipse()
# FIXED: row.names should refer to original x, because as.matrix() strips them

#' @describeIn cancor \code{"default"} method.
#' @export
cancor.default <- function(x, y,
                           weights,
                           X.names = colnames(x),
                           Y.names = colnames(y),
                           row.names = rownames(x),
                           xcenter = TRUE, ycenter = TRUE, # not yet implemented (used implicitly)
                           xscale = FALSE, yscale = FALSE, # not yet implemented
                           ndim = min(p, q),
                           set.names = c("X", "Y"),
                           prefix = c("Xcan", "Ycan"), # s/b: paste0(set.names, "can")
                           na.rm = TRUE,
                           use = if (na.rm) "complete" else "pairwise",
                           method = "gensvd",
                           ...) {
  X <- as.matrix(x)
  Y <- as.matrix(y)
  p <- ncol(X)
  q <- ncol(Y)
  n <- length(complete.cases(X, Y)) # DONE: take account of 0 weights
  if (!missing(weights)) n <- n - sum(weights == 0)

  C <- Var(cbind(X, Y), na.rm = TRUE, use = use, weights = weights)
  Cxx <- C[1:p, 1:p]
  Cyy <- C[-(1:p), -(1:p)]
  Cxy <- C[1:p, -(1:p)]

  res <- gensvd(Cxy, Cxx, Cyy, nu = ndim, nv = ndim)
  names(res) <- c("cor", "xcoef", "ycoef")
  colnames(res$xcoef) <- paste(prefix[1], 1:ndim, sep = "")
  colnames(res$ycoef) <- paste(prefix[2], 1:ndim, sep = "")

  scores <- can.scores(X, Y, res$xcoef, res$ycoef)
  colnames(scores$xscores) <- paste(prefix[1], 1:ndim, sep = "")
  colnames(scores$yscores) <- paste(prefix[2], 1:ndim, sep = "")

  structure <- can.structure(X, Y, scores, use = use)
  result <- list(
    cancor = res$cor,
    names = list(
      X = X.names, Y = Y.names,
      row.names = row.names, set.names = set.names
    ),
    ndim = ndim,
    dim = list(p = p, q = q, n = n),
    coef = list(X = res$xcoef, Y = res$ycoef),
    scores = list(X = scores$xscores, Y = scores$yscores),
    X = X, Y = Y,
    weights = if (missing(weights)) NULL else weights,
    structure = structure
  )
  class(result) <- "cancor"
  return(result)
}

# scores on canonical variates
can.scores <- function(X, Y, xcoef, ycoef) {
  X.aux <- scale(X, center = TRUE, scale = FALSE) # TODO: incorporate xscale, yscale, etc here
  Y.aux <- scale(Y, center = TRUE, scale = FALSE)
  X.aux[is.na(X.aux)] <- 0
  Y.aux[is.na(Y.aux)] <- 0

  xscores <- X.aux %*% xcoef
  yscores <- Y.aux %*% ycoef
  return(list(xscores = xscores, 
              yscores = yscores))
}

# canonical structure coefficients: correlations
can.structure <- function(X, Y, scores, use = "complete.obs") {
  xscores <- scores$xscores
  yscores <- scores$yscores
  X.xscores <- cor(X, xscores, use = use)
  Y.xscores <- cor(Y, xscores, use = use)
  X.yscores <- cor(X, yscores, use = use)
  Y.yscores <- cor(Y, yscores, use = use)

  return(list(
    X.xscores = X.xscores,
    Y.xscores = Y.xscores,
    X.yscores = X.yscores,
    Y.yscores = Y.yscores
  ))
}

# TODO: replace with equivalent qr stuff
gensvd <- function(Rxy, Rxx, Ryy, nu = p, nv = q) {
  p <- dim(Rxy)[1]
  q <- dim(Rxy)[2]

  if (missing(Rxx)) Rxx <- diag(p)
  if (missing(Ryy)) Ryy <- diag(q)

  if (dim(Rxx)[1] != dim(Rxx)[2]) stop("Rxx must be square")
  if (dim(Ryy)[1] != dim(Ryy)[2]) stop("Ryy must be square")

  s <- min(p, q)
  if (max(abs(Rxx - t(Rxx))) / max(abs(Rxx)) > 1e-10) {
    warning("Rxx not symmetric.")
    Rxx <- (Rxx + t(Rxx)) / 2
  }
  if (max(abs(Ryy - t(Ryy))) / max(abs(Ryy)) > 1e-10) {
    warning("Ryy not symmetric.")
    Ryy <- (Ryy + t(Ryy)) / 2
  }

  Rxxinv <- solve(chol(Rxx))
  Ryyinv <- solve(chol(Ryy))
  Dform <- t(Rxxinv) %*% Rxy %*% Ryyinv
  if (p >= q) {
    result <- svd(Dform, nu = nu, nv = nv)
    values <- result$d
    Xmat <- Rxxinv %*% result$u
    Ymat <- Ryyinv %*% result$v
  } else {
    result <- svd(t(Dform), nu = nv, nv = nu)
    values <- result$d
    Xmat <- Rxxinv %*% result$v
    Ymat <- Ryyinv %*% result$u
  }
  gsvdlist <- list(values = values, Xmat = Xmat, Ymat = Ymat)
  return(gsvdlist)
}


# vector of stars, of max. width, corresponding to proportions
stars <- function(p, width = 30) {
  p <- p / sum(p)
  reps <- round(p * width / max(p))
  res1 <- sapply(reps, function(x) paste(rep("*", x), sep = "", collapse = ""))
  res2 <- sapply(reps, function(x) paste(rep(" ", width - x), sep = "", collapse = ""))
  res <- paste(res1, res2, sep = "")
  res
}

# DONE: move the printout of coefficients to a summary method
#' @describeIn cancor \code{print()} method for \code{"cancor"} objects.
#' @export
print.cancor <- function(x, digits = max(getOption("digits") - 2, 3), ...) {
  names <- x$names
  cat("\nCanonical correlation analysis of:\n")
  cat("\t", x$dim$p, " ", names$set.names[1], " variables: ", paste(names$X, collapse = ", "), "\n")
  cat("  with\t", x$dim$q, " ", names$set.names[2], " variables: ", paste(names$Y, collapse = ", "), "\n")
  cat("\n")
  canr <- x$cancor
  lambda <- canr^2 / (1 - canr^2)
  pct <- 100 * lambda / sum(lambda)
  cum <- cumsum(pct)
  # DONE: add stars column, showing pct
  stwidth <- getOption("width") - 40
  scree <- stars(pct, width = min(30, stwidth))
  canrdf <- data.frame("CanR" = canr, 
                       "CanRSQ" = canr^2, 
                       "Eigen" = lambda, 
                       "percent" = pct, 
                       "cum" = cum, 
                       "scree" = scree)
  print(canrdf, digits = 4)

  tests <- Wilks.cancor(x)
  print(tests, digits = digits)

  invisible(x)
}

# moved printout of coefficients here
#' @describeIn cancor \code{summary()} method for \code{"cancor"} objects.
#' @export
summary.cancor <- function(object, digits = max(getOption("digits") - 2, 3), ...) {
  names <- object$names
  print(object, digits = digits, ...)

  cat("\nRaw canonical coefficients\n")
  cat("\n  ", names$set.names[1], " variables: \n")
  print(object$coef$X, digits = digits)
  cat("\n  ", names$set.names[2], " variables: \n")
  print(object$coef$Y, digits = digits)
}



# extractor functions
#' @export
scores <- function(x, ...) {
  UseMethod("scores")
}

# TODO: check rownames
#' @describeIn cancor \code{scores()} method for \code{"cancor"} objects.
#' @export
scores.cancor <- function(x, 
                          type = c("x", "y", "both", "list", "data.frame"), ...) {
  type <- match.arg(type)
  switch(type,
    x = x$scores$X,
    y = x$scores$Y,
    both = x$scores,
    list = x$scores,
    data.frame = data.frame(x$scores$X, x$scores$Y)
  )
}

#' @describeIn cancor \code{coef()} method for \code{"cancor"} objects.
#' @export
coef.cancor <- function(object, 
                        type = c("x", "y", "both", "list"), 
                        standardize = FALSE, ...) {
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
