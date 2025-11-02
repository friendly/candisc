

#' Yields from Nitrogen nutrition of grass species
#' 
#' The data frame `Grass` gives the yield (10 * log10 dry-weight (g)) of
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
#' \item{`Species`}{a factor with levels `B.media`
#'       `D.glomerata` `F.ovina` `F.rubra` `H.pubesens`
#'       `K.cristata` `L.perenne` `P.bertolonii`}
#' \item{`Block`}{a factor with levels `1` `2` `3` `4` `5`} 
#' \item{`N1`}{species yield at 1 ppm Nitrogen}
#' \item{`N9`}{species yield at 9 ppm Nitrogen}
#' \item{`N27`}{species yield at 27 ppm Nitrogen}
#' \item{`N81`}{species yield at 81 ppm Nitrogen}
#' \item{`N243`}{species yield at 243 ppm Nitrogen} 
#' }
#' @source 
#' Gittins, R. (1985), Canonical Analysis: A Review with Applications
#' in Ecology, Berlin: Springer-Verlag, Table A-5.
#' @keywords datasets
#' @concept MANOVA
#' @concept candisc
#' @examples
#' 
#' str(Grass)
#' grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#' car::Anova(grass.mod)
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
#' \item{`id`}{Observation id: a numeric vector} 
#' \item{`gender`}{a factor with levels `male` `female`} 
#' \item{`race`}{Race or ethnicity: a factor with levels
#'      `hispanic` `asian` `african-amer` `white`}
#' \item{`ses`}{Socioeconomic status: a factor with levels `low` `middle` `high`} 
#' \item{`sch`}{School type: a factor with levels `public` `private`} 
#' \item{`prog`}{High school program: a factor with levels `general` `academic`
#'      `vocation`} 
#' \item{`locus`}{Locus of control: a numeric vector}
#' \item{`concept`}{Self-concept: a numeric vector}
#' \item{`mot`}{Motivation: a numeric vector}
#' \item{`career`}{Career plan: a factor with levels `clerical`
#'      `craftsman` `farmer` `homemaker` `laborer`
#'      `manager` `military` `operative` `prof1` `prof2`
#'      `proprietor` `protective` `sales` `school`
#'      `service` `technical` `not working`}
#' \item{`read`}{Standardized reading score: a numeric vector}
#' \item{`write`}{Standardized writing score: a numeric vector}
#' \item{`math`}{Standardized math score: a numeric vector}
#' \item{`sci`}{Standardized science score: a numeric vector}
#' \item{`ss`}{Standardized social science (civics) score: a numeric vector} 
#' }
#' @references High School and Beyond data files:
#' <http://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/7896>
#' @source Tatsuoka, M. M. (1988).  Multivariate Analysis: Techniques for
#' Educational and Psychological Research (2nd ed.). New York: Macmillan,
#' Appendix F, 430-442.
#' 
#' %Retrieved from: %<http://www.gseis.ucla.edu/courses/data/hbs6.dta>
#' @keywords datasets
#' @concept MMRA
#' @concept cancor
#' @examples
#' 
#' str(HSB)
#' # main effects model
#' hsb.mod <- lm( cbind(read, write, math, sci, ss) ~
#' 		gender + race + ses + sch + prog, data=HSB)
#' car::Anova(hsb.mod)
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
#' \item{`Cultivar`}{a factor with levels `barolo` `grignolino` `barbera`} 
#' \item{`Alcohol`}{a numeric vector}
#' \item{`MalicAcid`}{a numeric vector} 
#' \item{`Ash`}{a numeric vector} 
#' \item{`AlcAsh`}{a numeric vector, Alkalinity of ash}
#' \item{`Mg`}{a numeric vector, Magnesium} 
#' \item{`Phenols`}{a numeric vector, Total phenols} 
#' \item{`Flav`}{a numeric vector, Flavanoids} 
#' \item{`NonFlavPhenols`}{a numeric vector}
#' \item{`Proa`}{a numeric vector, Proanthocyanins}
#' \item{`Color`}{a numeric vector, color intensity} 
#' \item{`Hue`}{a numeric vector} 
#' \item{`OD`}{a numeric vector, OD280/OD315 of diluted wines} 
#' \item{`Proline`}{a numeric vector} 
#' }
#' @references In R, a comparable data set is contained in the \pkg{ggbiplot}
#' package.
#' @source This data set was obtained from the UCI Machine Learning Repository,
#' `http://archive.ics.uci.edu/ml/datasets/Wine`. This page references a
#' large number of papers that use this data set to compare different methods.
#' @keywords datasets
#' @concept MANOVA
#' @concept candisc
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
#' (canonical) discriminant analysis, the factors `group` or
#' `location` and `sex` provide alternative parameterizations.
#' 
#' @name Wolves
#' @docType data
#' @format A data frame with 25 observations on the following 11 variables.
#' \describe{ 
#' \item{`group`}{a factor with levels `ar:f` `ar:m`
#'       `rm:f` `rm:m`, comprising the combinations of `location` and `sex`} 
#' \item{`location`}{a factor with levels `ar`=Arctic, `rm`=Rocky Mountain} 
#' \item{`sex`}{a factor with levels `f`=female, `m`=male} 
#' \item{`x1`}{palatal length, a numeric vector} 
#' \item{`x2`}{postpalatal length, a numeric vector}
#' \item{`x3`}{zygomatic width, a numeric vector}
#' \item{`x4`}{palatal width outside first upper molars, a numeric vector} 
#' \item{`x5`}{palatal width inside second upper molars, a numeric vector} 
#' \item{`x6`}{postglenoid foramina width, a numeric vector} 
#' \item{`x7`}{interorbital width, a numeric vector}
#' \item{`x8`}{braincase width, a numeric vector} 
#' \item{`x9`}{crown length, a numeric vector} 
#' }
#' @references Jolicoeur, P. ``Multivariate geographical variation in the wolf
#' *Canis lupis L.*'', *Evolution*, XIII, 283--299.
#' @source Morrison, D. F.  *Multivariate Statistical Methods*, (3rd ed.),
#' 1990.  New York: McGraw-Hill, p. 288-289.
#' 
#' % ~~ reference to a publication or URL from which the data were obtained ~~
#' @keywords datasets
#' @concept candisc
#' @examples
#' 
#' data(Wolves)
#' 
#' # using group
#' wolf.mod <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9) ~ group, data=Wolves)
#' car::Anova(wolf.mod)
#' 
#' wolf.can <-candisc(wolf.mod)
#' plot(wolf.can)
#' heplot(wolf.can)
#' 
#' # using location, sex
#' wolf.mod2 <-lm(cbind(x1,x2,x3,x4,x5,x6,x7,x8,x9) ~ location*sex, data=Wolves)
#' car::Anova(wolf.mod2)
#' 
#' wolf.can2 <-candiscList(wolf.mod2)
#' plot(wolf.can2)
#' 
#' 
NULL


#' @name PsyAcad
#' @aliases PsyAcad
#' @docType data
#' @title
#' Psychological Measures and Academic Achievement
#'
#' @description
#' A researcher collected data on three psychological variables, four academic variables 
#' (standardized test scores) and gender for 600 college freshman. 
#' She is interested in how the set of psychological variables relates to the academic variables and gender. 
#' In particular, the researcher is interested in how many dimensions (canonical variables) are necessary to 
#' understand the association between the two sets of variables.
#'
#' @usage data("PsyAcad")
#' @format
#'  A data frame with 600 observations on the following 8 variables.
#'  \describe{
#'    \item{`LocControl`}{locus of control, a numeric vector}
#'    \item{`SelfConcept`}{self concept, a numeric vector}
#'    \item{`Motivation`}{motivation, a numeric vector}
#'    \item{`Read`}{reading score, a numeric vector}
#'    \item{`Write`}{writing score, a numeric vector}
#'    \item{`Math`}{mathematics score, a numeric vector}
#'    \item{`Science`}{science score, a numeric vector}
#'    \item{`Sex`}{a factor with levels `M`, `F`}
#'  }
#'
#' @source 
#' Taken from <http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis>
#'
#' @concept cancor
#' @examples
#' data(PsyAcad)
#' PsyAcad$Sex <- as.numeric(PsyAcad$Sex)
#' PsyAcad.can <- cancor(cbind(LocControl, SelfConcept, Motivation) ~ 
#'        Read + Write + Math + Science + Sex, data = PsyAcad)
#'
#' PsyAcad.can
#' 
#' # redundancy analysis
#' redundancy(PsyAcad.can)
#' 
#' # Plots
#' canR <- PsyAcad.can$cancor
#' plot(PsyAcad.can, pch=16, id.n = 3)
#' text(-2, 3, paste("Can R =", round(canR[1], 3)), pos = 3)
#' 
#' plot(PsyAcad.can, which = 2, pch=16, id.n = 3)
#' text(-2, 3.5, paste("Can R =", round(canR[2], 3)), pos = 3)
#'
#' @keywords datasets
NULL

#' @name cereal
#' @aliases cereal
#' @docType data
#' @title
#' Breakfast Cereal Dataset
#'
#' @description
#' A multivariate dataset describing seventy-seven commonly available breakfast cereals, based on the information 
#' now available on the FDA food label. The variable `rating` is a likely response variable in
#' statistical models.
#'
#'
#' @usage data("cereal")
#' @format
#'  A data frame with 77 observations on the following 16 variables.
#'  \describe{
#'    \item{`name`}{cereal name, a character vector}
#'    \item{`mfr`}{manufacturer (A  G  K  N  P  Q  R), a character vector}
#'    \item{`type`}{type (cold/hot), a character vector}
#'    \item{`calories`}{calories (number), a numeric vector}
#'    \item{`protein`}{protein(g), a numeric vector}
#'    \item{`fat`}{fat(g), a numeric vector}
#'    \item{`sodium`}{sodium(mg), a numeric vector}
#'    \item{`fiber`}{dietary fiber(g), a numeric vector}
#'    \item{`carbo`}{complex carbohydrates(g), a numeric vector}
#'    \item{`sugars`}{sugars(g), a numeric vector}
#'    \item{`potass`}{potassium(mg), a numeric vector}
#'    \item{`vitamins`}{vitamins & minerals (0, 25, or 100, respectively indicating "none added"; 
#'          "enriched"; "FDA recommended"), a numeric vector}
#'    \item{`shelf`}{display shelf (1, 2, or 3, counting from the floor), a numeric vector}
#'    \item{`weight`}{weight (in ounces) of one serving (serving size), a numeric vector}
#'    \item{`cups`}{cups per serving, a numeric vector}
#'    \item{`rating`}{health rating of the cereal (unknown calculation method), a numeric vector}
#'  }
#'
#' @details 
#' This dataset was used in the poster competition for the American Statistical association 1993 Statistical Graphics Exposition,
#' titled *Serial Correlation or Cereal Correlation ??*.
#' 
#' The call for participation reads: 
#' "A multivariate dataset describing seventy-seven commonly available breakfast cereals, based on the information now available on
#' the newly-mandated F&DA food label.  What are you getting when you eat a bowl of cereal?  Can you get a lot of fiber without 
#' a lot of calories?  Can you describe what cereals are displayed on high, low, and middle shelves?  The good news is that none 
#' of the cereals for which we collected data had any cholesterol, and manufacturers rarely use artificial sweeteners and colors,
#' nowadays.  However, there is still a lot of data for the consumer to understand while choosing a good breakfast cereal." 
#' 
#' Further details on the variables and suggested analyses are available at
#' <https://community.amstat.org/jointscsg-section/dataexpo/dataexpo1993>
#' 
#' The abbreviations for manufacturer, `mfr`, stand for:
#' \describe{
#'    \item{`A`}{American Home Food Products}
#'    \item{`G`}{General Mills}
#'    \item{`K`}{Kellog}
#'    \item{`N`}{Nabisco}
#'    \item{`P`}{Post}
#'    \item{`Q`}{Quaker Oats}
#'    \item{`R`}{Ralston Purina}
#'  }
#'
#' 
#' @source From the American Statistical Association 1993 Statistical Graphics Exposition, 'Serial Correlation or Cereal Correlation ??',
#' <https://community.amstat.org/jointscsg-section/dataexpo/dataexpo1993>.
#' @seealso 
#' [MASS::UScereal] has a similar dataset with fewer observations and variables, but with the variables normalized to a portion of one US cup.
#' 
#' @references 
#' Jean Dos Santos, Breakfast Cereals: Data Analysis and Clustering, 
#' <https://www.kaggle.com/code/jeandsantos/breakfast-cereals-data-analysis-and-clustering>. Does a bunch of data cleaning
#' and exploratory data analysis in R.
#'
#' @concept MMRA
#' @concept cancor
#' @examples
#' data(cereal)
#' str(cereal)
#' 
#' # Add explicit name of manufacturer
#' # names for manufacturers
#' mfr_names <- c(
#'   "A" = "American Home Foods",
#'   "G" = "General Mills",
#'   "K" = "Kellog",
#'   "N" = "Nabisco",
#'   "P" = "Post",
#'   "Q" = "Quaker Oats",
#'   "R" = "Ralston Purina"
#' )
#'
#' # recode `mfr` as `mfr_name`
#' cereal <- cereal |>
#'   mutate(mfr_name = recode(mfr, !!!mfr_names))
#' 
#' # density plot of ratings
#' library(ggplot2)
#' ggplot(data = cereal,
#'        aes(x = rating, fill = mfr_name, color = mfr_name)) +
#'   geom_density(alpha = 0.1) +
#'   theme_classic(base_size = 14) + 
#'   theme(legend.position = "bottom")

#'
#' @keywords datasets
NULL
