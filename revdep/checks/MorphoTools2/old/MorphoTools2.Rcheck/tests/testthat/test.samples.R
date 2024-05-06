context("samples")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/sample.txt")

  expect_equal(paste(samples(data)[1:8], collapse = ","), "BABL1146,BABL1147,BABL1148,BABL1149,BABL1150,BABL1151,BABL1152,BABL1153")

})




