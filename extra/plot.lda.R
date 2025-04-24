plot.lda <- function(
    x,
    which=1:2,   # canonical dimensions to plot
    conf=0.95,   # confidence coverage of circles for class means
    col,         # vector of unique colors used for plotting the canonical scores
    pch,         # vector of unique point symbols
    scale,       # scale factor for variable vectors in can space
    asp=1       # aspect ratio, to ensure equal units
) {
  
  
  scores <- data.frame(
    Species = iris$Species,
    predict(iris.lda)$x)
  
}