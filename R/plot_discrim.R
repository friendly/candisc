# originally from: https://stackoverflow.com/questions/63782598/quadratic-discriminant-analysis-qda-plot-in-r
# 
# DONE: ✔️ Make data optional -- get it from the model object
# DONE: ✔️ Use rev() when `vars` is a formula
# DONE: ✔️ Added data ellipses
# DONE: ✔️ Points should be plotted last
# DONE: ✔️ Added ellipse.args to control stat_ellipse() parameters
# DONE: ✔️ Added `labels` and `labels.args` for class labels at group means
# DONE: ✔️ Renamed `modes.means` to `other.levels` and improved documentation
# DONE: ✔️ Added plotting in discriminant space with LD1, LD2, etc.
# DONE: ✔️ Added automatic axis labeling with variance percentages
# DONE: ✔️ Added `rev.axes` parameter for reversing discriminant axes
# DONE: ✔️ Added `xlim`, `ylim` arguments to control axis limits; useful for plots in discrim space.
#
# TODO: ❌ Fix mapping for stat_ellipse() when specifying `geom = "polygon"`
# TODO: Create vignette detailing how to use more generally with ggplot

#' Discriminant Analysis Decision Plot using ggplot.
#' 
#' @description
#' 
#' Discriminant analysis can be more easily understood from plots of the data variables showing how observations are classified.
#' `plot_discrim()` uses the ideas behind **effect plots** (Fox, 1987): Visualize predicted classes of the observations for two focal variables over a
#' grid of their values, with other variables in a model held fixed. This differs from the usual effect plots in that the predicted
#' values to be visualized are discrete categories rather than quantitative.
#' 
#' In the case of discriminant analysis, the predicted values are class membership,
#' so this can be visualized by mapping the categorical predicted class to discrete colors used as the background for the plot, or
#' plotting the **contours** of predicted class membership as lines (for `[MASS::lda()]`) or quadratic curves (for `[MASS::qda()]`) in the plot.
#' The predicted class of any observation in the space of the variables displayed can also be rendered as colored **tiles** or **points**
#' in the background of the plot.
#' 
#' @details
#' 
#' Since `plot_discrim()` returns a `"ggplot"` object, you can easily customize colors and shapes by adding scale layers after 
#' the function call. You can also add other graphic layers, such as annotations, and control the overall appearance of
#' plots using [ggplot2::theme()] components.
#' 
#' **Customizing colors and shapes**
#' 
#' 
#' * Use `scale_color_manual()` **and** `scale_fill_manual()` to control the colors used when using `showgrid = "tile"`, because that maps
#'   both **both** `color` and `fill` to the group variable.
#' * Use `scale_shape_manual()` to control the symbols used for `geom_points()`
#' 
#' **Customizing ellipses**
#' 
#' The `ellipse.args` parameter provides fine control over the appearance of data ellipses. Common arguments include:
#' 
#' * `level`: the confidence level for the ellipse (default: 0.68)
#' * `linewidth`: thickness of the ellipse line (default: 1.2)
#' * `geom`: either `"path"` for unfilled ellipses (default) or `"polygon"` for filled ellipses
#' * `alpha`: transparency when using `geom = "polygon"`
#' 
#' See [ggplot2::stat_ellipse()] for additional parameters.
#' 
#' **Adding class labels**
#' 
#' The `labels` and `labels.args` parameters allow you to add text labels for each class, positioned at the 
#' group means. Common arguments for `labels.args` include:
#' 
#' * `geom`: either `"text"` (default) for simple text or `"label"` for text with a background box
#' * `size`: text size (default: 5)
#' * `fontface`: font style such as `"bold"` or `"italic"`
#' * `nudge_x`, `nudge_y`: offsets for label positioning
#' * `alpha`: transparency for label backgrounds when using `geom = "label"`
#' 
#' See [ggplot2::geom_text()] and [ggplot2::geom_label()] for additional parameters.
#' 
#' **Plotting in discriminant space**
#' 
#' When `vars` specifies discriminant dimensions (e.g., `LD2 ~ LD1`), the function automatically:
#' 
#' 1. Calculates discriminant scores using `predict_discrim()`
#' 2. Creates a new LDA model in the discriminant space
#' 3. Plots the observations and decision boundaries in this transformed space
#' 
#' This is particularly useful for visualizing how well the discriminant dimensions separate the groups,
#' since by construction the groups are maximally separated in discriminant space.
#' 
#' **Reversing discriminant axes**
#' 
#' The orientation of discriminant axes (LD1, LD2, etc.) is arbitrary in the sense that multiplying
#' any discriminant dimension by -1 does not change the discriminant solution or model fit. The `rev.axes`
#' parameter allows you to reverse the direction of one or both axes when plotting in discriminant space.
#' This can be useful for:
#' 
#' * Aligning the discriminant plot with conventional interpretations (e.g., having "positive" on the right)
#' * Making the orientation consistent across different analyses or visualizations
#' * Improving the interpretability of the axes in relation to the original variables
#' 
#' The `rev.axes` parameter **only affects plots of discriminant dimensions** (e.g., `LD2 ~ LD1`) and has no
#' effect when plotting original observed variables. To reverse the horizontal axis (x-axis), set 
#' `rev.axes[1] = TRUE`; to reverse the vertical axis (y-axis), set `rev.axes[2] = TRUE`. Both axes
#' can be reversed simultaneously with `rev.axes = c(TRUE, TRUE)`.
#'
#' @param model   a discriminant analysis model object from `MASS::lda()` or `MASS::qda()`
#' @param vars    either a character vector of length 2 of the names of the `x` and `y` variables, or a formula of form `y ~ x` 
#'                specifying the axes in the plot. Can include discriminant dimensions like `LD1`, `LD2`, etc.
#' @param data    data to use for visualization. Should contain all the data needed to use the `model` for prediction. The default is to use
#'                the data used to fit the `model`.
#' @param resolution number of points in x, y variables to use for visualizing the predicted class boundaries and regions.
#' @param point.size size of the plot symbols use to show the data observations
#' @param showgrid a character string; how to display predicted class regions: `"tile"` for [ggplot2::geom_tile()], `"point"` 
#'                for [ggplot2::geom_point()], or `"none"` for no grid display.
#' @param contour logical (default: `TRUE`); should the plot display the boundaries of the classes by contours? 
#' @param contour.color color of the lines for the contour boundaries (default: `"black"`)
#' @param tile.alpha transparency value for the background tiles of predicted class.
#' @param ellipse  logical; if `TRUE`, 68 percent data ellipses for the groups are added to the plot.
#' @param ellipse.args a named list of arguments passed to [ggplot2::stat_ellipse()]. Common arguments include 
#'                `level` (confidence level, default: 0.68), `linewidth` (line thickness, default: 1.2), 
#'                `geom` (either `"path"` for unfilled ellipses or `"polygon"` for filled ellipses), 
#'                and `alpha` (transparency for filled ellipses). Any valid argument to `stat_ellipse()` can be used.
#' @param labels logical; if `TRUE`, class labels are added to the plot at the group means (default: `FALSE`).
#' @param labels.args a named list of arguments passed to [ggplot2::geom_text()] or [ggplot2::geom_label()]. 
#'                Common arguments include `geom` (either `"text"` or `"label"`, default: `"text"`), 
#'                `size` (text size, default: 5), `fontface` (e.g., `"bold"` or `"italic"`), 
#'                `nudge_x` and `nudge_y` (position offsets), and `alpha` (transparency for label backgrounds). 
#'                Any valid argument to `geom_text()` or `geom_label()` can be used.
#' @param rev.axes a logical vector of length 2 controlling axis reversal for discriminant dimensions. 
#'                `rev.axes[1] = TRUE` reverses the horizontal (x) axis; `rev.axes[2] = TRUE` reverses the 
#'                vertical (y) axis. Only applies when plotting discriminant dimensions (e.g., `LD2 ~ LD1`). 
#'                Default: `c(FALSE, FALSE)`.
#' @param xlim,ylim    numeric vectors of length 2 giving the axis limits. If `NULL` (default), uses the 
#'                range of the variable in the data.
#' @param ...     further parameters passed to `predict()`
#' @param other.levels a named list specifying the fixed values to use for variables in the model that are 
#'                **not** included in `vars` (the non-focal variables). These values are held constant across 
#'                the prediction grid. If not specified, the function uses sensible defaults: means for 
#'                quantitative variables, and the first level for factors or character variables. 
#'                
#' @author Original code by Oliver on SO <https://stackoverflow.com/questions/63782598/quadratic-discriminant-analysis-qda-plot-in-r>. 
#' 
#' Generalized by Michael Friendly
#' @references 
#'    Fox, J. (1987). Effect Displays for Generalized Linear Models. In C. C. Clogg (Ed.), _Sociological Methodology_, 1987 (pp. 347–361). Jossey-Bass
#' @seealso [klaR::partimat()] for pairwise discriminant plots, but with little control of plot details
#' @importFrom ggplot2 ggplot aes geom_point geom_tile geom_contour geom_text geom_label stat_ellipse .data labs
#' @importFrom dplyr group_by summarise across all_of
#' @importFrom insight get_data
#' @importFrom stats as.formula
#' @export
#' @examples
#' library(MASS)
#' library(ggplot2)
#' library(dplyr)
#' 
#' iris.lda <- lda(Species ~ ., iris)
#' # formula call: y ~ x
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width)
#' 
#' # add data ellipses
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              ellipse = TRUE) 
#' 
#' # add filled ellipses with transparency
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              ellipse = TRUE,
#'              ellipse.args = list(geom = "polygon", alpha = 0.2)) 
#' 
#' # customize ellipse level and line thickness
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              ellipse = TRUE,
#'              ellipse.args = list(level = 0.95, linewidth = 2)) 
#' 
#' # without contours
#' # data ellipses
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              contour = FALSE) 
#' 
#' # specifying `vars` as character names for x, y
#' plot_discrim(iris.lda, c("Petal.Width", "Petal.Length"))
#' 
#' # Define custom colors and shapes, modify theme() and legend.position
#' iris.colors <- c("red", "darkgreen", "blue")
#' iris.pch <- 15:17
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width) +
#'   scale_color_manual(values = iris.colors) +
#'   scale_fill_manual(values = iris.colors) +
#'   scale_shape_manual(values = iris.pch) +
#'   theme_bw(base_size = 14) +
#'   theme(legend.position = "inside",
#'         legend.position.inside = c(.8, .25))
#'
#' # Quadratic discriminant analysis gives quite a different result
#' iris.qda <- qda(Species ~ ., iris)
#' plot_discrim(iris.qda, Petal.Length ~ Petal.Width)
#' 
#' # Add class labels, with custom styling
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              labels = TRUE,
#'              labels.args = list(geom = "label", size = 6, fontface = "bold"))
#' 
#' # Add labels with position adjustments
#' plot_discrim(iris.lda, Petal.Length ~ Petal.Width, 
#'              labels = TRUE,
#'              labels.args = list(nudge_y = 0.1, size = 5))
#' 
#' # Plot in discriminant space
#' plot_discrim(iris.lda, LD2 ~ LD1)
#' 
#' # Reverse the horizontal axis in discriminant space
#' plot_discrim(iris.lda, LD2 ~ LD1, rev.axes = c(TRUE, FALSE))
#' 
#' # Control axis limits
#' plot_discrim(iris.lda, LD2 ~ LD1,
#'              xlim = c(-10, 10), ylim = c(-8, 8))
#' 
#' 
plot_discrim <- function(
    model, 
    vars, 
    data = insight::get_data(model),
    resolution = 100,
    point.size = 3,
    showgrid = c("tile", "point", "none"), 
    contour = TRUE,
    contour.color = "black",
    tile.alpha = 0.2,
    ellipse = FALSE,
    ellipse.args = list(level = 0.68, linewidth = 1.2),
    labels = FALSE,
    labels.args = list(geom = "text", size = 5),
    rev.axes = c(FALSE, FALSE),
    xlim = NULL,
    ylim = NULL,
    ...,
    other.levels) {
  if(missing(model) || missing(vars))
    stop('`model` or `vars` is missing')
  
  # Validate rev.axes
  if(!is.logical(rev.axes) || length(rev.axes) != 2) {
    stop('`rev.axes` must be a logical vector of length 2')
  }
  
  # Validate xlim and ylim
  if(!is.null(xlim) && (!is.numeric(xlim) || length(xlim) != 2 || xlim[1] >= xlim[2])) {
    stop('`xlim` must be a numeric vector of length 2 with xlim[1] < xlim[2]')
  }
  if(!is.null(ylim) && (!is.numeric(ylim) || length(ylim) != 2 || ylim[1] >= ylim[2])) {
    stop('`ylim` must be a numeric vector of length 2 with ylim[1] < ylim[2]')
  }

  # check what is supplied as `vars`. If a formula, reverse what is supplied by all.vars()
  if(!(is.character(vars) && 
       length(vars) == 2) && 
     !('formula' %in% class(vars) && 
       length(vars <- rev(all.vars(vars))) == 2))
    stop('`vars` should be either a formula or a character vector of length 2.')
  if(!is.data.frame(data))
    stop('data does not seem to comform with standard types.')
  
  # Validate and match showgrid argument
  showgrid <- match.arg(showgrid)
  
  t <- terms(model)
  
  # name of outcome variable
  class <- lhs <- as.character(t[[2]])
  
  # Check if we're plotting in discriminant space (LD variables)
  is_discrim_space <- all(grepl("^LD[0-9]+$", vars))
  
  if (is_discrim_space) {
    # Extract dimension numbers from LD1, LD2, etc.
    dim_numbers <- as.integer(gsub("LD", "", vars))
    
    # Get discriminant scores
    scores_data <- predict_discrim(model, data, scores = TRUE)
    
    # Apply axis reversal if requested
    if (rev.axes[1]) {
      scores_data[[vars[1]]] <- -1 * scores_data[[vars[1]]]
    }
    if (rev.axes[2]) {
      scores_data[[vars[2]]] <- -1 * scores_data[[vars[2]]]
    }
    
    # Create a new LDA model in discriminant space
    discrim_formula <- as.formula(paste(lhs, "~", paste(vars, collapse = " + ")))
    model <- MASS::lda(discrim_formula, data = scores_data)
    data <- scores_data
    
    # Get proportion of variance explained for axis labels
    svd_vals <- model$svd
    variance_props <- 100 * round(svd_vals^2/sum(svd_vals^2), 3)
    
    # Create axis labels with variance percentages
    # x_label <- sprintf("%s (%.1f%%)", vars[1], variance_props[dim_numbers[1]])
    # y_label <- sprintf("%s (%.1f%%)", vars[2], variance_props[dim_numbers[2]])
    axis_labels <- paste0("Discriminant dimension ", dim_numbers, " (", variance_props[dim_numbers], "%)")

    
    # Update terms for the new model
    t <- terms(model)
  }
  
  if(!all((other.vars <- attr(t, 'term.labels')) %in% colnames(data)))
    stop('data is missing one or more variables in model.')

  # Set up data for prediction, for the data in vars
  # Use custom limits if provided, otherwise use data range
  prd.vars <- lapply(seq_along(vars), function(i){
    x <- data[, vars[i]]
    if(is.character(x) || is.factor(x)){
      unique(x)
    }else{
      # Determine range: use xlim/ylim if provided, otherwise data range
      if(i == 1 && !is.null(xlim)) {
        r <- xlim
      } else if(i == 2 && !is.null(ylim)) {
        r <- ylim
      } else {
        r <- range(x)
      }
      seq(r[1], r[2], length.out = resolution)
    }
  })
  names(prd.vars) <- vars

  # set up data for prediction for the remaining (non-focal) variables
  if(missing(other.levels)){
    other.vars <- other.vars[!other.vars %in% vars]
    if(length(other.vars)){
      other.levels <- lapply(data[, other.vars], function(x){
        if(is.character(x)){
          unique(x)[1]
        }else if(is.factor(x)){
          levels(x)[1]
        }else{
          mean(x)
        }
      }) 
      names(other.levels) <- other.vars
    }else
      other.levels <- NULL
  }else{
    if(is.null(other.vars))
      warning('other.vars is null but other.levels was provided. Please leave this missing.')
    if(!all(other.vars %in% names(other.levels)))
      stop('other.levels are lacking one or more variables.')
    other.levels <- as.list(other.levels)
    if(any(lengths(other.levels) > 1))
      stop('other.levels should only contain a single value for each variable.')
  }

  # Construct the grid of values of all variables in the model to be used for prediction
  pred.grid <- expand.grid(c(prd.vars, other.levels))
  p <- predict(model, pred.grid, ...)
  pred.grid$nm <- if(is.list(p)) 
    p$class 
  else 
    p
  names(pred.grid)[ncol(pred.grid)] <- lhs

  # Calculate class means for the variables being plotted (used for labels if requested)
  if (labels) {
    class_means <- data |>
      dplyr::group_by(.data[[lhs]]) |>
      dplyr::summarise(
        across(all_of(vars), mean, .names = "{.col}"),
        .groups = "drop"
      )
  }
  
  # Create the final plot.
  gg <- ggplot(data = data, 
               aes(.data[[vars[1]]], .data[[vars[2]]])) 

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
      geom_tile(aes(.data[[vars[1]]], .data[[vars[2]]], 
                    fill = .data[[lhs]]), 
                data = pred.grid, 
                alpha = tile.alpha)
  } else if(showgrid == "point") {
    gg <- gg + 
      geom_point(aes(.data[[vars[1]]], .data[[vars[2]]], 
                     col = .data[[lhs]]), 
                 data = pred.grid, 
                 shape = 20, size = 0.5, alpha = 0.4)
  }

  # add ellipses with user-specified arguments
  if (ellipse == TRUE) {
    # Prepare the base aesthetics for stat_ellipse
    ellipse_call <- list(
      mapping = aes(color = .data[[lhs]])
    )
    
    # Merge user-provided ellipse.args with the base call
    ellipse_call <- c(ellipse_call, ellipse.args)
    
    # Add stat_ellipse layer with combined arguments
    gg <- gg + do.call(stat_ellipse, ellipse_call)
  }
  
  # add points
  gg <- gg + geom_point(aes(col = .data[[lhs]], 
                      shape = .data[[lhs]]), 
                  size = point.size)
  
  # add class labels at group means
  if (labels == TRUE) {
    # Extract geom type from labels.args, default to "text"
    label_geom <- if (!is.null(labels.args$geom)) labels.args$geom else "text"
    
    # Remove geom from labels.args since it's not a valid parameter for geom_text/geom_label
    labels.args$geom <- NULL
    
    # Prepare the base aesthetics and data for the label layer
    label_call <- list(
      mapping = aes(x = .data[[vars[1]]], 
                    y = .data[[vars[2]]], 
                    label = .data[[lhs]],
                    color = .data[[lhs]]),
      data = class_means,
      show.legend = FALSE
    )
    
    # Merge user-provided labels.args with the base call
    label_call <- c(label_call, labels.args)
    
    # Add the appropriate geom layer
    if (label_geom == "label") {
      gg <- gg + do.call(geom_label, label_call)
    } else {
      gg <- gg + do.call(geom_text, label_call)
    }
  }
  
  # Add custom axis labels if in discriminant space
  if (is_discrim_space) {
  gg <- gg + labs(x = axis_labels[1], y = axis_labels[2])
    }
  
  # return ggplot object
  gg  

}
