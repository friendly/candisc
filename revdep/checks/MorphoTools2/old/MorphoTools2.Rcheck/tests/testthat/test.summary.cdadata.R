context("summary.cdadata")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/samplePlnaMatica.txt")

  cdaRes = cda.calc(data)


  output = capture.output(summary(cdaRes))

  expect_equal(output[1], "Object of class 'cdadata'; storing results of canonical discriminant analysis")
  #expect_equal(output[5], "1 0.8155     4.4194                 0.6512                0.6512")
  #expect_equal(output[11], "SN  -0.145904966  0.143816194  0.187457229")
})




