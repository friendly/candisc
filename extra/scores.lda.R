# Extract discriminant score for lda()
# -- but this is similar to predict_discrim


scores.lda <- function(x, class = FALSE, ...) {
  scores <- predict(x)$x
  
  if (class) {
    class <- predict(x)$class
  }
  scores
}