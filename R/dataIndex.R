# find sequential indices for observations in a data frame
# corresponding to the unique combinations of the levels
# of a given model term from a model object or a data frame
#



#' Indices of observations in a model data frame
#' 
#' Find sequential indices for observations in a data frame corresponding to
#' the unique combinations of the levels of a given model term from a model
#' object or a data frame
#' 
#' 
#' @param x Either a data frame or a model object
#' @param term The name of one term in the model, consisting only of factors
#' @return A vector of indices.
#' @author Michael Friendly
#' @keywords utilities manip
#' @examples
#' 
#' factors <- expand.grid(A=factor(1:3),B=factor(1:2),C=factor(1:2))
#' n <- nrow(factors)
#' responses <-data.frame(Y1=10+round(10*rnorm(n)),Y2=10+round(10*rnorm(n)))
#' 
#' test <- data.frame(factors, responses)
#' mod <- lm(cbind(Y1,Y2) ~ A*B, data=test)
#' 
#' dataIndex(mod, "A")
#' dataIndex(mod, "A:B")
#' 
#' 
#' @export dataIndex
dataIndex <- function(x, term){
	data <- if (is.data.frame(x)) x else
			if (inherits(x, "lm")) model.frame(x) else stop("Not a data frame or model object")

    factors <- data[, sapply(data, is.factor), drop=FALSE]
    term.factors <- unlist(strsplit(term, ":"))
    if (any(which <- !term.factors %in% colnames(factors))) 
        stop(paste(term.factors[which], collapse=", "), " not a factor in the model or data")
    n.factors <- length(term.factors)
    factor.values <- factors[,term.factors, drop=FALSE]
    rows <- nrow(levs <- unique(factor.values))
    levs <- apply(levs, 1, paste, collapse=":")

		m <- match(term.factors,colnames(factors))
		data.levs <- apply(factors[m], 1, paste, collapse=":")
    match(data.levs, levs) 
}

