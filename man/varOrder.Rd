\name{varOrder}
\alias{varOrder}
\alias{varOrder.mlm}
\alias{varOrder.data.frame}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Order variables according to canonical structure or other criteria
}
\description{
The \code{varOrder} function implements some features of \dQuote{effect ordering}
(Friendly & Kwan (2003)
for \emph{variables} in a multivariate data display to make the
displayed relationships more coherent.

This can be used in pairwise HE plots, scatterplot matrices, parallel
coordinate plots, plots of multivariate means, and so forth.

For a numeric data frame, the most useful displays often order
variables according to the angles of variable vectors in a
2D principal component analysis or biplot. For a multivariate
linear model, the analog is to use the angles of the variable
vectors in a 2D canonical discriminant biplot.
}
\usage{

varOrder(x, ...)

\method{varOrder}{mlm}(x, term, variables, 
      type = c("can", "pc"), 
      method = c("angles", "dim1", "dim2", "alphabet", "data", "colmean"), 
      names = FALSE, descending = FALSE, ...)

\method{varOrder}{data.frame}(x, variables, 
      method = c("angles", "dim1", "dim2", "alphabet", "data", "colmean"),
      names = FALSE, descending = FALSE, ...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{x}{
  A multivariate linear model or a numeric data frame
}

  \item{term}{
For the \code{mlm} method, one term in the model for which the canonical structure coefficients
are found.
}
  \item{variables}{indices or names of the variables to be ordered;
    defaults to all response variables an MLM or all numeric variables in a data frame.}

  \item{type}{
For an MLM, \code{type="can"} uses the canonical structure coefficients for the given \code{term};
\code{type="pc"} uses the principal component variable eigenvectors.
}
  \item{method}{
One of \code{c("angles", "dim1", "dim2", "alphabet", "data", "colmean")} giving the effect ordering method.
	\describe{
		\item{"angles"}{Orders variables according to the angles their vectors make with dimensions 1 and 2, 
		counter-clockwise starting from the lower-left quadrant in a 2D biplot or candisc display.}
		\item{"dim1"}{Orders variables in increasing order of their coordinates on dimension 1}
		\item{"dim2"}{Orders variables in increasing order of their coordinates on dimension 2}
		\item{"alphabet"}{Orders variables alphabetically}
		\item{"data"}{Uses the order of the variables in the data frame or the list of responses in the MLM}
		\item{"colmean"}{Uses the order of the column means of the variables in the data frame or the list of responses in the MLM}
	}
}
  \item{names}{
logical; if \code{TRUE} the effect ordered names of the variables are returned;
otherwise, their indices in \code{variables} are returned.
}
  \item{descending}{If \code{TRUE}, the ordered result is reversed to a descending order.}
  \item{\dots}{
Arguments passed to methods
}

}
%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
A vector of integer indices of the variables or a character vector of their names.
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Friendly, M. & Kwan, E. (2003).
Effect Ordering for Data Displays,
\emph{Computational Statistics and Data Analysis}, \bold{43}, 509-539.
}
\author{
Michael Friendly
}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
data(Wine, package="candisc")
Wine.mod <- lm(as.matrix(Wine[, -1]) ~ Cultivar, data=Wine)
Wine.can <- candisc(Wine.mod)
plot(Wine.can, ellipse=TRUE)

# pairs.mlm HE plot, variables in given order
pairs(Wine.mod, fill=TRUE, fill.alpha=.1, var.cex=1.5)

order <- varOrder(Wine.mod)
pairs(Wine.mod, variables=order, fill=TRUE, fill.alpha=.1, var.cex=1.5)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}
\keyword{multivariate}% __ONLY ONE__ keyword per line
