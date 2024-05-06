context("summary.classifdata")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/samplePlnaMatica.txt")

  c.lda = suppressWarnings(classif.lda(data))
  
  output = capture.output(summary(c.lda))

  expect_equal(output[1], "Object of class 'classifdata'; storing results of classificatory discriminant analysis")
})




