context("pca.calc")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)


test_that("correct input", {
  data("centaurea")
  expect_error(cda.calc(centaurea), "NA values in 'object'")

  expect_error(cda.calc(morphoMockup, passiveSamples = "ee"), "Taxon \"ee\" was not found in attached data.")
})

test_that("correctness of calculation",  {
  library(candisc)

  d = as.matrix(morphoDataFrame[,4:5])
  x = lm(d ~ morphoDataFrame$Taxon)
  candisc_cda = candisc::candisc(x, term="morphoDataFrame$Taxon")

  cdaRes = cda.calc(morphoMockup)

  expect_is(cdaRes, "cdadata")

  names(candisc_cda$eigenvalues) = names(cdaRes$eigenvalues)
  names(candisc_cda$pct) = names(cdaRes$eigenvalues)


  expect_equal(cdaRes$rank, candisc_cda$rank)
  expect_equal(cdaRes$eigenvalues, candisc_cda$eigenvalues[1:cdaRes$rank])
  expect_equal(cdaRes$canrsq, candisc_cda$canrsq)
  expect_equal(cdaRes$eigenvaluesAsPercentages, candisc_cda$pct[1:cdaRes$rank] / 100)
  expect_equal(cdaRes$coeffs.raw, candisc_cda$coeffs.raw)
  expect_equal(cdaRes$coeffs.std, candisc_cda$coeffs.std)
  expect_equal(cdaRes$totalCanonicalStructure, candisc_cda$structure)

  expect_equal(cdaRes$objects$ID, morphoMockup$ID)
  expect_equal(cdaRes$objects$Taxon, morphoMockup$Taxon)

  expect_equal(cdaRes$objects$scores$Can1, candisc_cda$scores$Can1)

  expect_true(is.numeric(cdaRes$eigenvaluesAsPercentages) )
  expect_true(is.numeric(cdaRes$cumulativePercentageOfEigenvalues) )
  expect_true(is.numeric(cdaRes$groupMeans$Can1) )




})


test_that("correctness of calculation - passive sample",  {
  library(candisc)
  d = as.matrix(morphoDataFrame[1:6,4:5])
  m = morphoDataFrame$Taxon[1:6]
  x = lm(d ~ m)
  candisc_cda = candisc::candisc(x, term="m")

  cdaRes = cda.calc(morphoMockup, passiveSamples = "Pop4")

  names(candisc_cda$eigenvalues) = names(cdaRes$eigenvalues)
  names(candisc_cda$pct) = names(cdaRes$eigenvalues)

  expect_equal(cdaRes$rank, candisc_cda$rank)
  expect_equal(cdaRes$eigenvalues, candisc_cda$eigenvalues[1:cdaRes$rank])
  expect_equal(cdaRes$canrsq, candisc_cda$canrsq)
  expect_equal(cdaRes$eigenvaluesAsPercentages, candisc_cda$pct[1:cdaRes$rank] / 100)
  expect_equal(cdaRes$coeffs.raw, candisc_cda$coeffs.raw)
  expect_equal(cdaRes$coeffs.std, candisc_cda$coeffs.std)
  expect_equal(cdaRes$totalCanonicalStructure, candisc_cda$structure)

  expect_equal(cdaRes$objects$ID, morphoMockup$ID)
  expect_equal(cdaRes$objects$Taxon, morphoMockup$Taxon)

  expect_equal(cdaRes$objects$scores$Can1[1:6], candisc_cda$scores$Can1)

})
