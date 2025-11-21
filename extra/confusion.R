# Confusion matrix for LDA / QDA
# TODO: Provide a print method

confusion <- function(object) {
  
  actual <- insight::get_response(object)
  predicted <- predict(object, type = "prob")$class
  tab <- table(actual = actual,
               predicted = predicted)
  
  accuracy <- sum(diag(tab)) / sum(tab) * 100
  error <- 100 - accuracy
  
  attributes(tab) <- list(accuracy = accuracy, error = error)
  
  tab
  
}