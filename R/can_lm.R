#' Transform a Multivariate Linear model mlm to a Canonical Representation

#' @description
#' 
#' This function uses [candisc()] to transform the responses in a
#' multivariate linear model to scores on canonical variables for a given term and then uses
#' those scores as responses in a linear (lm) or multivariate linear model (mlm).
#'
#' The function constructs a model formula of the form `Can ~ terms` where
#' Can is the canonical score(s) and terms are the terms in the original mlm,
#' then runs lm() with that formula.
#' 
#' 
#' @param mod A `mlm` object
#' @param term One term in that model
#' @param \dots Arguments passed to [candisc()]
#' @return A `lm` object if `term` is a rank 1 hypothesis, otherwise a `mlm` object
#' @author Michael Friendly
#' @seealso [candisc()], [cancor()]
#' @examples
#' 
#' iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
#' iris.can <- can_lm(iris.mod, "Species")
#' iris.can
#' car::Anova(iris.mod)
#' car::Anova(iris.can)
#' 
#' @export can_lm
can_lm <- function(mod, term, ...) {
  if (!(inherits(mod, "mlm"))) stop("model must be a mlm")
  term.names <- gsub(" ", "", labels(terms(mod)))
  which.term <- which(term == term.names)
  if (length(which.term) == 0) stop(term, " does not appear in the model")

  can <- candisc(mod, term, ...)
  #  term <- mod$term                        # term for which candisc was done
  lm.terms <- can$terms # terms in original lm
  scores <- can$scores

  resp <- if (can$rank == 1) {
    "Can1"
  } else {
    paste("cbind(", paste("Can", 1:can$rank, sep = "", collapse = ","), ")")
  }

    txt <- paste(
    "lm(", resp, " ~ ",
    paste(lm.terms, collapse = "+"), ", data=scores)"
  )
  can.mod <- eval(parse(text = txt))
  can.mod
}
