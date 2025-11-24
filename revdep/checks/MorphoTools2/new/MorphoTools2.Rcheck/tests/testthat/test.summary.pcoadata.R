context("summary.pcoadata")


test_that("correct info about class structure", {
  bin = read.morphodata("../testFiles/bin.txt")

  pcoaRes = pcoa.calc(bin, distMethod = "jaccard")


  output = capture.output(summary(pcoaRes))

  expect_equal(output[1], "Object of class 'pcoadata'; storing results of principal coordinates analysis")
  expect_equal(output[6], "Eigenvalues                          2.1794 1.8067 1.2899 0.7263")
})




