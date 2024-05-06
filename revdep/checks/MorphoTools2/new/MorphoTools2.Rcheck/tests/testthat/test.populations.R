context("populations")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/sample.txt")

  expect_equal(paste(populations(data)[1:8], collapse = ","), "BABL,BABU,BOL,BRT,BUK,CERM,CERV,CZLE")

})




