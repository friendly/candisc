# Canonical discriminant analysis for all terms in an mlm

# Written by: John Fox
# Last updated: 10/29/2007 9:33:42 AM MF
# --- Changed default to ask=interactive() in plot.candiscList

# Last modified: 31 August 2007 by J. Fox




#' Canonical discriminant analyses
#' 
#' `candiscList` performs a generalized canonical discriminant analysis
#' for all terms in a multivariate linear model (i.e., an `mlm` object),
#' computing canonical scores and vectors.
#' 
#' 
#' @aliases candiscList candiscList.mlm plot.candiscList print.candiscList
#'          summary.candiscList
#' @param mod An mlm object, such as computed by lm() with a multivariate
#'          response
#' @param type type of test for the model `term`, one of: "II", "III",
#'          "2", or "3"
#' @param manova the `Anova.mlm` object corresponding to `mod`.
#'       Normally, this is computed internally by `Anova(mod)`
#' @param ndim Number of dimensions to store in the `means`,
#'       `structure`, `scores` and `coeffs.*` components.  
#'       The default is the rank of the H matrix for the hypothesis term.
#' @param object,x A candiscList object
#' @param term The name of one term to be plotted for the `plot` method.
#'       If not specified, one candisc plot is produced for each term in the
#'       `mlm` object.
#' @param ask If `TRUE` (the default, when running interactively), a menu
#'       of terms is presented; if ask is FALSE, canonical plots for all terms are
#'       produced.
#' @param graphics if `TRUE` (the default, when running interactively),
#'       then the menu of terms to plot is presented in a dialog box rather than as a
#'       text menu.
#' @param \dots arguments to be passed down.
#' @return An object of class `candiscList` which is a list of
#'       `"candisc"` objects for the terms in the mlm.
#' @author Michael Friendly and John Fox
#' @seealso [candisc()], [heplots::heplot()], [heplots::heplot3d()]
#' @keywords multivariate hplot
#' @examples
#' 
#' grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#' 
#' grass.canL <-candiscList(grass.mod)
#' names(grass.canL)
#' names(grass.canL$Species)
#' 
#' \dontrun{
#' print(grass.canL)
#' }
#' plot(grass.canL, type="n", ask=FALSE)
#' heplot(grass.canL$Species, scale=6)
#' heplot(grass.canL$Block, scale=2)
#' 
#' 
#' @export candiscList
candiscList <- function(mod, ...){
    UseMethod("candiscList")
    }
    
#' @describeIn candiscList `"mlm"` method.
#' @export
candiscList.mlm <- function(mod, type="2", manova, ndim, ...){
    if (missing(manova)) manova <- Anova(mod, type=type)
    result <- as.list(1:length(manova$terms))
    names(result) <- manova$terms
    for (term in manova$terms){
        result[[term]] <- if (missing(ndim))
            candisc(mod, type=type, manova=manova, term=term)
            else {
                nd <- if(is.list(ndim)) ndim$term
                    else ndim 
                candisc(mod, type=type, manova=manova, ndim=nd, term=term)
                }
        }
    class(result) <- "candiscList"
    result
    }

#' @describeIn candiscList `print()` method for `"candiscList"` objects.
#' @export
print.candiscList <- function(x, ...){
    terms <- names(x)
    for (term in terms){
        cat("\nTerm:", term, "\n")
        print(x[[term]], ...)
        cat("\n")
        }
    }

#' @describeIn candiscList `summary()` method for `"candiscList"` objects.
#' @export
summary.candiscList <- function(object, ...){
    terms <- names(object)
    for (term in terms){
        cat("\nTerm:", term, "\n")
        summary(object[[term]], ...)
        cat("\n")
        }
    }

#' @describeIn candiscList `plot()` method for `"candiscList"` objects.
#' @export
plot.candiscList <- function(x, term, ask=interactive(), graphics = TRUE, ...) {
    if (!missing(term)){
        if (is.character(term)) term <- gsub(" ", "", term)
        plot(x[[term]], ...)
        return(invisible())
        }
    terms <- names(x)
    if (ask){
        repeat {
            selection <- menu(terms, graphics = graphics, title = "Select term to plot")
            if (selection == 0) break
            else plot(x[[selection]], ...)
            }
        }
    else {
        nterms <- length(x)
        for (i in 1:nterms) {
        	plot(x[[i]], ...)
        	}
        }
}
