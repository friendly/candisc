context("summary.pcadata")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/samplePlnaMatica.txt")

  pcaRes = pca.calc(data)


  output = capture.output(summary(pcaRes))

  expect_equal(output[1], "Object of class 'pcadata'; storing results of principal component analysis")
  #expect_equal(output[5], "Eigenvalues     2.2722 1.8884 1.6320 1.3175 1.2340 1.1796 1.0987 0.9774")
})




