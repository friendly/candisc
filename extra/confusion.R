# Confusion matrix for LDA / QDA

confusion <- function(object) {
  
  actual <- insight::get_response(object)
  predicted <- predict(object, type = "prob")$class
  tab <- table(actual = actual,
               predicted = predicted)
  
  accuracy <- sum(diag(tab)) / sum(tab) * 100
  error <- 100 - accuracy
  
  structure(tab, accuracy, error)
  
}