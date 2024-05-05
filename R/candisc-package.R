

#' Visualizing Generalized Canonical Discriminant and Canonical Correlation
#' Analysis
#' 
#' This package includes functions for computing and visualizing generalized
#' canonical discriminant analyses and canonical correlation analysis for a
#' multivariate linear model.  The goal is to provide ways of visualizing such
#' models in a low-dimensional space corresponding to dimensions (linear
#' combinations of the response variables) of maximal relationship to the
#' predictor variables.
#' 
#' Traditional canonical discriminant analysis is restricted to a one-way
#' MANOVA design and is equivalent to canonical correlation analysis between a
#' set of quantitative response variables and a set of dummy variables coded
#' from the factor variable. The \code{candisc} package generalizes this to
#' multi-way MANOVA designs for all terms in a multivariate linear model (i.e.,
#' an \code{mlm} object), computing canonical scores and vectors for each term
#' (giving a \code{candiscList} object).
#' 
#' The graphic functions are designed to provide low-rank (1D, 2D, 3D)
#' visualizations of terms in a \code{mlm} via the \code{\link{plot.candisc}}
#' method, and the HE plot \code{\link{heplot.candisc}} and
#' \code{\link{heplot3d.candisc}} methods. For \code{mlm}s with more than a few
#' response variables, these methods often provide a much simpler
#' interpretation of the nature of effects in canonical space than heplots for
#' pairs of responses or an HE plot matrix of all responses in variable space.
#' 
#' Analogously, a multivariate linear (regression) model with quantitative
#' predictors can also be represented in a reduced-rank space by means of a
#' canonical correlation transformation of the Y and X variables to
#' uncorrelated canonical variates, Ycan and Xcan.  Computation for this
#' analysis is provided by \code{\link{cancor}} and related methods.
#' Visualization of these results in canonical space are provided by the
#' \code{\link{plot.cancor}}, \code{\link{heplot.cancor}} and
#' \code{\link{heplot3d.cancor}} methods.
#' 
#' These relations among response variables in linear models can also be useful
#' for \dQuote{effect ordering} (Friendly & Kwan (2003) for \emph{variables} in
#' other multivariate data displays to make the displayed relationships more
#' coherent.  The function \code{\link{varOrder}} implements a collection of
#' these methods.
#' 
#' A new vignette, \code{vignette("diabetes", package="candisc")}, illustrates
#' some of these methods. A more comprehensive collection of examples is
#' contained in the vignette for the \pkg{heplots} package,
#' 
#' \code{vignette("HE-examples", package="heplots")}.
#' 
#' The organization of functions in this package and the \pkg{heplots} package
#' may change in a later version.
#' 
#' @name candisc-package
#' @author Michael Friendly and John Fox
#' 
#' Maintainer: Michael Friendly <friendly@yorku.ca>
#' @seealso 
#' \code{\link[heplots]{heplot}} for details about HE plots.
#' 
#' \code{\link{candisc}}, \code{\link{cancor}} for details about canonical
#' discriminant analysis and canonical correlation analysis.
#' @references 
#' Friendly, M. (2007).  HE plots for Multivariate General Linear
#' Models.  \emph{Journal of Computational and Graphical Statistics},
#' \bold{16}(2) 421--444.  \url{http://datavis.ca/papers/jcgs-heplots.pdf}
#' 
#' Friendly, M. & Kwan, E. (2003). Effect Ordering for Data Displays,
#' \emph{Computational Statistics and Data Analysis}, \bold{43}, 509-539.
#' \doi{10.1016/S0167-9473(02)00290-6}
#' 
#' Friendly, M. & Sigal, M. (2014). Recent Advances in Visualizing Multivariate
#' Linear Models. \emph{Revista Colombiana de Estadistica} , \bold{37}(2),
#' 261-283. 
#' \doi{10.15446/rce.v37n2spe.47934}.
#' 
#' Friendly, M. & Sigal, M. (2017). Graphical Methods for Multivariate Linear
#' Models in Psychological Research: An R Tutorial, \emph{The Quantitative
#' Methods for Psychology}, 13 (1), 20-45.
#' \doi{10.20982/tqmp.13.1.p020}.
#' 
#' Gittins, R. (1985). \emph{Canonical Analysis: A Review with Applications in
#' Ecology}, Berlin: Springer.
#' @aliases candisc-package
#' @keywords package multivariate
"_PACKAGE"





#' Yields from Nitrogen nutrition of grass species
#' 
#' The data frame \code{Grass} gives the yield (10 * log10 dry-weight (g)) of
#' eight grass Species in five replicates (Block) grown in sand culture at five
#' levels of nitrogen.
#' 
#' Nitrogen (NaNO3) levels were chosen to vary from what was expected to be
#' from critically low to almost toxic.  The amount of Nitrogen can be
#' considered on a log3 scale, with levels 0, 2, 3, 4, 5.  Gittins (1985, Ch.
#' 11) treats these as equally spaced for the purpose of testing polynomial
#' trends in Nitrogen level.
#' 
#' The data are also not truly multivariate, but rather a split-plot
#' experimental design.  For the purpose of exposition, he regards Species as
#' the experimental unit, so that correlations among the responses refer to a
#' composite representative of a species rather than to an individual exemplar.
#' 
#' @name Grass
#' @docType data
#' @format A data frame with 40 observations on the following 7 variables.
#' \describe{ 
#' \item{\code{Species}}{a factor with levels \code{B.media}
#'       \code{D.glomerata} \code{F.ovina} \code{F.rubra} \code{H.pubesens}
#'       \code{K.cristata} \code{L.perenne} \code{P.bertolonii}}
#' \item{\code{Block}}{a factor with levels \code{1} \code{2} \code{3} \code{4} \code{5}} 
#' \item{\code{N1}}{species yield at 1 ppm Nitrogen}
#' \item{\code{N9}}{species yield at 9 ppm Nitrogen}
#' \item{\code{N27}}{species yield at 27 ppm Nitrogen}
#' \item{\code{N81}}{species yield at 81 ppm Nitrogen}
#' \item{\code{N243}}{species yield at 243 ppm Nitrogen} 
#' }
#' @source 
#' Gittins, R. (1985), Canonical Analysis: A Review with Applications
#' in Ecology, Berlin: Springer-Verlag, Table A-5.
#' @keywords datasets
#' @examples
#' 
#' str(Grass)
#' grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#' Anova(grass.mod)
#' 
#' grass.canL <-candiscList(grass.mod)
#' names(grass.canL)
#' names(grass.canL$Species)
#' 
#' 
NULL





#' High School and Beyond Data
#' 
#' The High School and Beyond Project was a longitudinal study of students in
#' the U.S. carried out in 1980 by the National Center for Education
#' Statistics.  Data were collected from 58,270 high school students (28,240
#' seniors and 30,030 sophomores) and 1,015 secondary schools.  The HSB data
#' frame is sample of 600 observations, of unknown characteristics, originally
#' taken from Tatsuoka (1988).
#' 
#' 
#' @name HSB
#' @docType data
#' @format A data frame with 600 observations on the following 15 variables.
#' There is no missing data.  
#' \describe{ 
#' \item{\code{id}}{Observation id: a numeric vector} 
#' \item{\code{gender}}{a factor with levels \code{male} \code{female}} 
#' \item{\code{race}}{Race or ethnicity: a factor with levels
#'      \code{hispanic} \code{asian} \code{african-amer} \code{white}}
#' \item{\code{ses}}{Socioeconomic status: a factor with levels \code{low} \code{middle} \code{high}} 
#' \item{\code{sch}}{School type: a factor with levels \code{public} \code{private}} 
#' \item{\code{prog}}{High school program: a factor with levels \code{general} \code{academic}
#'      \code{vocation}} 
#' \item{\code{locus}}{Locus of control: a numeric vector}
#' \item{\code{concept}}{Self-concept: a numeric vector}
#' \item{\code{mot}}{Motivation: a numeric vector}
#' \item{\code{career}}{Career plan: a factor with levels \code{clerical}
#'      \code{craftsman} \code{farmer} \code{homemaker} \code{laborer}
#'      \code{manager} \code{military} \code{operative} \code{prof1} \code{prof2}
#'      \code{proprietor} \code{protective} \code{sales} \code{school}
#'      \code{service} \code{technical} \code{not working}}
#' \item{\code{read}}{Standardized reading score: a numeric vector}
#' \item{\code{write}}{Standardized writing score: a numeric vector}
#' \item{\code{math}}{Standardized math score: a numeric vector}
#' \item{\code{sci}}{Standardized science score: a numeric vector}
#' \item{\code{ss}}{Standardized social science (civics) score: a numeric vector} 
#' }
#' @references High School and Beyond data files:
#' \url{http://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/7896}
#' @source Tatsuoka, M. M. (1988).  Multivariate Analysis: Techniques for
#' Educational and Psychological Research (2nd ed.). New York: Macmillan,
#' Appendix F, 430-442.
#' 
#' %Retrieved from: %\url{http://www.gseis.ucla.edu/courses/data/hbs6.dta}
#' @keywords datasets
#' @examples
#' 
#' str(HSB)
#' # main effects model
#' hsb.mod <- lm( cbind(read, write, math, sci, ss) ~
#' 		gender + race + ses + sch + prog, data=HSB)
#' Anova(hsb.mod)
#' 
#' # Add some interactions
#' hsb.mod1 <- update(hsb.mod, . ~ . + gender:race + ses:prog)
#' heplot(hsb.mod1, col=palette()[c(2,1,3:6)], variables=c("read","math"))
#' 
#' hsb.can1 <- candisc(hsb.mod1, term="race")
#' heplot(hsb.can1, col=c("red", "black"))
#' 
#' # show canonical results for all terms
#' \dontrun{
#' hsb.can <- candiscList(hsb.mod)
#' hsb.can
#' }
#' 
#' 
NULL





#' Chemical composition of three cultivars of wine
#' 
#' These data are the results of a chemical analysis of wines grown in the same
#' region in Italy but derived from three different cultivars.  The analysis
#' determined the quantities of 13 constituents found in each of the three
#' types of wines.
#' 
#' This data set is a classic in the machine learning literature as an easy
#' high-D classification problem, but is also of interest for examples of
#' MANOVA and discriminant analysis.
#' 
#' The precise definitions of these variables is unknown: units, how they were
#' measured, etc.
#' 
#' @name Wine
#' @docType data
#' @format A data frame with 178 observations on the following 14 variables.
#' \describe{ 
#' \item{\code{Cultivar}}{a factor with levels \code{barolo} \code{grignolino} \code{barbera}} 
#' \item{\code{Alcohol}}{a numeric vector}
#' \item{\code{MalicAcid}}{a numeric vector} 
#' \item{\code{Ash}}{a numeric vector} 
#' \item{\code{AlcAsh}}{a numeric vector, Alkalinity of ash}
#' \item{\code{Mg}}{a numeric vector, Magnesium} 
#' \item{\code{Phenols}}{a numeric vector, Total phenols} 
#' \item{\code{Flav}}{a numeric vector, Flavanoids} 
#' \item{\code{NonFlavPhenols}}{a numeric vector}
#' \item{\code{Proa}}{a numeric vector, Proanthocyanins}
#' \item{\code{Color}}{a numeric vector, color intensity} 
#' \item{\code{Hue}}{a numeric vector} 
#' \item{\code{OD}}{a numeric vector, OD280/OD315 of diluted wines} 
#' \item{\code{Proline}}{a numeric vector} 
#' }
#' @references In R, a comparable data set is contained in the \pkg{ggbiplot}
#' package.
#' @source This data set was obtained from the UCI Machine Learning Repository,
#' \code{http://archive.ics.uci.edu/ml/datasets/Wine}. This page references a
#' large number of papers that use this data set to compare different methods.
#' @keywords datasets
#' @examples
#' 
#' data(Wine)
#' str(Wine)
#' #summary(Wine)
#' 
#' Wine.mlm <- lm(as.matrix(Wine[, -1]) ~ Cultivar, data=Wine)
#' Wine.can <- candisc(Wine.mlm)
#' Wine.can
#' 
#' 
#' plot(Wine.can, ellipse=TRUE)
#' plot(Wine.can, which=1)
#' 
#' 
#' 
NULL





#' Wolf skulls
#' 
#' Skull morphometric data on Rocky Mountain and Arctic wolves (Canis Lupus L.)
#' taken from Morrison (1990), originally from Jolicoeur (1959).
#' 
#' All variables are expressed in millimeters.
#' 
#' The goal was to determine how geographic and sex differences among the wolf
#' populations are determined by these skull measurements.  For MANOVA or
#' (canonical) discriminant analysis, the factors \code{group} or
#' \code{location} and \code{sex} provide alternative parameterizations.
#' 
#' @name Wolves
#' @docType data
#' @format A data frame with 25 observations on the following 11 variables.
#' \describe{ 
#' \item{\code{group}}{a factor with levels \code{ar:f} \code{ar:m}
#'       \code{rm:f} \code{rm:m}, comprising the combinations of \code{location} and \code{sex}} 
#' \item{\code{location}}{a factor with levels \code{ar}=Arctic, \code{rm}=Rocky Mountain} 
#' \item{\code{sex}}{a factor with levels \code{f}=female, \code{m}=male} 
#' \item{\code{x1}}{palatal length, a numeric vector} 
#' \item{\code{x2}}{postpalatal length, a numeric vector}
#' \item{\code{x3}}{zygomatic width, a numeric vector}
#' \item{\code{x4}}{palatal width outside first upper molars, a numeric vector} 
#' \item{\code{x5}}{palatal width inside second upper molars, a numeric vector} 
#' \item{\code{x6}}{postglenoid foramina width, a numeric vector} 
#' \item{\code{x7}}{interorbital width, a numeric vector}
#' \item{\code{x8}}{braincase width, a numeric vector} 
#' \item{\code{x9}}{crown length, a numeric vector} 
#' }
#' @references Jolicoeur, P. ``Multivariate geographical variation in the wolf
#' \emph{Canis lupis L.}'', \emph{Evolution}, XIII, 283--299.
#' @source Morrison, D. F.  \emph{Multivariate Statistical Methods}, (3rd ed.),
#' 1990.  New York: McGraw-Hill, p. 288-289.
#' 
#' % ~~ reference to a publication or URL from which the data were obtained ~~
#' @keywords datasets
#' @examples
#' 
#' data(Wolves)
#' 
#' # using group
#' wolf.mod <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9) ~ group, data=Wolves)
#' Anova(wolf.mod)
#' 
#' wolf.can <-candisc(wolf.mod)
#' plot(wolf.can)
#' heplot(wolf.can)
#' 
#' # using location, sex
#' wolf.mod2 <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9) ~ location*sex, data=Wolves)
#' Anova(wolf.mod2)
#' 
#' wolf.can2 <-candiscList(wolf.mod2)
#' plot(wolf.can2)
#' 
#' 
NULL



