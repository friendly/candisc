context("taxa")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/sample.txt")

  expect_equal(paste(taxa(data), collapse = ","), "hybr,ph,ps,st")

})




