# originally from: https://stackoverflow.com/questions/63782598/quadratic-discriminant-analysis-qda-plot-in-r

#' Create a discriminant analysis decision plot using ggplot.
#' 
#' Discriminant analysis can be more easily understood from plots of the data variables showing how observations are classified.
#' `plot_discrim()` uses the ideas behind effect plots: Visualize predicted values for two focal variables over a
#' grid, with other variables in a model held fixed.
#' 
#' @details
#' In setting up this plot for [ggplot2::ggplot()], this function maps color and shape of class-specific elements of the plot to the value of
#' the class variable in the discriminant analysis. But it simply uses the ggplot defaults...
#' 
#'
#' @md
#' @param model   a discriminant analysis model object from `MASS::lda()` or `MASS::qda()`
#' @param vars    either a character vector of length 2 of the names of variables, or a formula of form V1 ~ V2 specifying y and x axis in the plot respectively.
#' @param data    data to use for visualization. Should contain all the data needed to use the model
#' @param resolution number of points in x, y variables to use for visualizating the predicted class boundaries and regions.
#' @param contour logical; should the plot display the boundaries of the classes by contours?
#' @param contour.color color of the lines for the contour boundaries
#' @param showgrid a character string; how to display predicted class regions: `"tile"` for [ggplot2::geom_tile()], `"point"` 
#'        for [ggplot2::geom_point()], or "none" for no grid display.
#' @param point.size size of the plot symbols use to show the data observations
#' @param ... further parameters passed to `predict()`
#' @param modes.means   levels to use for evaluating predictions using the variables **not* specified in `vars`. If not specified, the function uses the means for quantitative variables, ...
#' @author Original code by Oliver on SO <https://stackoverflow.com/questions/63782598/quadratic-discriminant-analysis-qda-plot-in-r>. Generalized by Michael Friendly
#' @seealso [klaR::partimat()]
#' @importFrom ggplot2 ggplot aes geom_point geom_tile geom_contour .data 
#' @export
#' @examples
#' library(MASS)
#' library(ggplot2)
#' library(dplyr)
#' library(candisc)
#' 
#' iris.lda <- lda(Species ~ ., iris)
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile")
#' 
plot_discrim <- function(model, 
                        vars, 
                        data, 
                        resolution = 100,
                        contour = TRUE,
                        contour.color = "black",
                        point.size = 3,
                        showgrid = c("tile", "point", "none"), 
                        ...,
                        modes.means) {
  if(missing(model) || missing(vars) || missing(data))
    stop('model, vars or data is missing')
  
  # check what is supplied as `vars`
  if(!(is.character(vars) && 
       length(vars) == 2) && 
     !('formula' %in% class(vars) && 
       length(vars <- all.vars(vars)) == 2))
    stop('`vars` should be either a formula or a character vector of length 2.')
  if(!is.data.frame(data))
    stop('data does not seem to comform with standard types.')
  
  # Validate and match showgrid argument
  showgrid <- match.arg(showgrid)
  
  t <- terms(model)
  if(!all((other.vars <- attr(t, 'term.labels')) %in% colnames(data)))
    stop('data is missing one or more variables in model.')

  # name of outcome variable
  class <- lhs <- as.character(t[[2]])

  # Set up data for prediction, for the data in vars
  prd.vars <- lapply(data[, vars], function(x){
    if(is.character(x) || is.factor(x)){
      unique(x)
    }else{
      r <- range(x)
      seq(r[1], r[2], length.out = resolution)
    }
  })
  names(prd.vars) <- vars

  # set up data for prediction for the remaining data
  if(missing(modes.means)){
    other.vars <- other.vars[!other.vars %in% vars]
    if(length(other.vars)){
      modes.means <- lapply(data[, other.vars], function(x){
        if(is.character(x)){
          unique(x)[1]
        }else if(is.factor(x)){
          levels(x)[1]
        }else{
          mean(x)
        }
      }) 
      names(modes.means) <- other.vars
    }else
      modes.means <- NULL
  }else{
    if(is.null(other.vars))
      warning('other.vars is null but modes.means was provided. Please leave this missing.')
    if(!all(other.vars %in% names(modes.means)))
      stop('modes.means are lacking one or more variables.')
    modes.means <- as.list(modes.means)
    if(any(lengths(modes.means) > 1))
      stop('modes.means should only contain a single values for all variables.')
  }

#browser()
  # Construct the grid of values of all variables in the model to be used for prediction
  pred.grid <- expand.grid(c(prd.vars, modes.means))
  p <- predict(model, pred.grid, ...)
  pred.grid$nm <- if(is.list(p)) 
    p$class 
  else 
    p
  names(pred.grid)[ncol(pred.grid)] <- lhs

  # class_means <- data |>
  #   group_by(!!!class) |>
  #   select(!!!vars) |>
  #   summarise(across(vars), mean)
  
  # Create the final plot.
  gg <- ggplot(data = data, 
               aes(.data[[vars[1]]], .data[[vars[2]]])) + 
    geom_point(aes(col = .data[[lhs]], shape = .data[[lhs]]), size = point.size)

  # Draw contour of the decision boundaries
  if (contour) {
    gg <- gg + 
      geom_contour(aes(.data[[vars[1]]], .data[[vars[2]]], 
                       z = as.integer(.data[[lhs]]) + 1L), 
                   color = contour.color,
                   data = pred.grid, inherit.aes = FALSE)
    
  }
  # Add grid visualization based on showgrid option
  if(showgrid == "tile") {
    gg <- gg + 
      geom_tile(aes(.data[[vars[1]]], .data[[vars[2]]], fill = .data[[lhs]]), 
                data = pred.grid, 
                alpha = 0.3)
  } else if(showgrid == "point") {
    gg <- gg + 
      geom_point(aes(.data[[vars[1]]], .data[[vars[2]]], col = .data[[lhs]]), 
                 data = pred.grid, 
                 shape = 20, size = 0.5, alpha = 0.4)
  }
  # if showgrid == "none", don't add anything
  gg
}


if(FALSE){

  library(MASS)
  library(ggplot2)
  library(dplyr)

  iris.lda <- lda(Species ~ ., iris)
  # Test with tile display (default)
  plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile")
  
  # Test with point display
  plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "point")
  
  # Test with no grid
  plot_discrim(iris.lda, Petal.Length ~ Petal.Width, data=iris, showgrid = "none")


  iris.qda <- qda(Species ~ ., iris)
  plot_discrim(iris.qda, Petal.Length ~ Petal.Width, data=iris, showgrid = "tile")
  
  # Define custom colors and shapes
  iris.colors <- c("red", "darkgreen", "blue")
  iris.pch <- 15:17
  
  # Fit the model
  iris.lda <- lda(Species ~ ., iris)
  
  # Create plot with custom colors and shapes
  plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
              data = iris, showgrid = "tile") +
    scale_color_manual(values = iris.colors) +
    scale_fill_manual(values = iris.colors) +
    scale_shape_manual(values = iris.pch)
  
  
#   data(peng, package = "heplots")
# #  source("R/penguin/penguin-colors.R")
#   source("C:/R/Projects/Vis-MLM-book/R/penguin/penguin-colors.R")
#   
#   # use penguin colors
#   peng.lda <- lda(species ~  bill_length + bill_depth + flipper_length + body_mass, data = peng)
#   plot_discrim(peng.lda, bill_length ~ bill_depth, data=peng, showgrid = "tile") +
#     scale_color_penguins()
#   
#   peng.qda <- qda(species ~  bill_length + bill_depth + flipper_length + body_mass, data = peng)
#   plot_discrim(peng.qda, bill_length ~ bill_depth, data=peng, showgrid = "point") +
#     scale_color_penguins()
  
}
