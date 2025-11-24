context(".setValuesForVector")




test_that("vector and symbol equally long",  {

  vector = as.factor(c("TaxA", "TaxB", "TaxB", "TaxC", "TaxD", "TaxD", "TaxD", "TaxE"))
  symbols = c("A", "B", "C", "D", "E")

  replacedVector = .setValuesForVector(vector, symbols)

  expect_equal(paste(replacedVector, collapse = ","), "A,B,B,C,D,D,D,E")
})


test_that("symbol are longer than vector",  {

  vector = as.factor(c("TaxA", "TaxB", "TaxB", "TaxC", "TaxD", "TaxD", "TaxD", "TaxE"))
  symbols = c("A", "B", "C", "D", "E", "F", "G")

  replacedVector = .setValuesForVector(vector, symbols)

  expect_equal(paste(replacedVector, collapse = ","), "A,B,B,C,D,D,D,E")
})

test_that("symbol are shorter than vector",  {

  vector = as.factor(c("TaxA", "TaxB", "TaxB", "TaxC", "TaxD", "TaxD", "TaxD", "TaxE"))
  symbols = c("A", "B", "C")

  replacedVector = .setValuesForVector(vector, symbols)

  expect_equal(paste(replacedVector, collapse = ","), "A,B,B,C,A,A,A,B")
})

