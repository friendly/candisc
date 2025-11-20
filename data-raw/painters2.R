#' Extended Painters Data with Art Historical Variables
#'
#' An extended version of the \code{\link[MASS]{painters}} dataset from the MASS package,
#' adding categorical variables that capture art historical distinctions among schools
#' of painting based on their chronological period, artistic emphasis, style, and
#' treatment of light.
#'
#' @format A data frame with 54 observations on 9 variables:
#' \describe{
#'   \item{Composition}{Composition score (0-20) assigned by de Piles}
#'   \item{Drawing}{Drawing score (0-20) assigned by de Piles}
#'   \item{Colour}{Colour score (0-20) assigned by de Piles}
#'   \item{Expression}{Expression score (0-20) assigned by de Piles}
#'   \item{School}{School of painter: "Renaissance", "Mannerist", "Sciento", 
#'     "Venetian", "Lombard", "16th C", "17th C", "French"}
#'   \item{Period}{Historical period: "Early" (1400-1520: Renaissance, Venetian, Lombard),
#'     "Transition" (1500-1600: 16th C, Mannerist), 
#'     "Baroque" (1600-1750: Sciento, 17th C, French)}
#'   \item{Emphasis}{Primary artistic focus: "Form" (emphasis on drawing, composition, 
#'     classical ideals), "Color" (emphasis on color and light effects), 
#'     "Drama" (emphasis on dramatic realism and emotional intensity)}
#'   \item{Style}{Aesthetic approach: "Classical" (balanced, harmonious, adherence to 
#'     classical ideals), "Expressive" (emotional intensity, dramatic effects), 
#'     "Regional" (distinctive regional characteristics)}
#'   \item{Light}{Treatment of light and shadow: "Balanced" (even, harmonious lighting),
#'     "Luminous" (rich color and atmospheric light effects), 
#'     "Dramatic" (strong chiaroscuro, dramatic contrasts)}
#' }
#'
#' @details
#' The original data are from the \code{\link[MASS]{painters}} dataset, based on
#' the subjective assessments of 54 classical painters by the 18th century art critic
#' Roger de Piles. The painters were rated on four characteristics: composition,
#' drawing, color and expression, and grouped according to "school" based on
#' nationality, era, and style.
#'
#' The four new categorical variables (Period, Emphasis, Style, Light) were constructed
#' to reflect art historical distinctions among the schools:
#' \itemize{
#'   \item \strong{Period} groups schools by broad historical era
#'   \item \strong{Emphasis} captures the primary artistic focus of each school
#'   \item \strong{Style} reflects the aesthetic approach and philosophical orientation
#'   \item \strong{Light} distinguishes approaches to light and shadow treatment
#' }
#'
#' These variables can be useful for exploring how art historical categories relate
#' to de Piles' quantitative ratings, and for demonstrating multivariate discriminant
#' analysis techniques.
#'
#' @source
#' Venables, W. N. and Ripley, B. D. (2002) \emph{Modern Applied Statistics with S}.
#' Fourth edition. Springer.
#'
#' @seealso \code{\link[MASS]{painters}}
#'
#' @examples
#' data(painters2)
#' 
#' # Compare original School with new Period grouping
#' with(painters2, table(School, Period))
#' 
#' # Summary of de Piles ratings by Period
#' aggregate(cbind(Composition, Drawing, Colour, Expression) ~ Period,
#'           data = painters2, FUN = mean)
#'
#' @keywords datasets
"painters2"

