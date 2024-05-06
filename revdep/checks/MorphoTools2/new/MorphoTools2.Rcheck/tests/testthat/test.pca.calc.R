context("pca.calc")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))

morphoDataFrameConstant = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "Ch1" = c(1,3,4,6,1,7,12,8),
                             "Ch2" = c(11, 11,11,11,11,11,11,11))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)
constantMockup = .morphodataFromDataFrame(morphoDataFrameConstant)

test_that("correctness of calculation",  {
  pca_princomp = princomp(morphoDataFrame[,4:5], cor = TRUE)
  #pca_prcomp = prcomp(morphoDataFrame[,4:5])

  pcaRes = pca.calc(morphoMockup)

  expect_is(pcaRes, "pcadata")


  names(pca_princomp$sdev) = colnames(pcaRes$eigenvectors)
  colnames(pca_princomp$loadings) = colnames(pcaRes$eigenvectors)
  colnames(pca_princomp$scores) = colnames(pcaRes$eigenvectors)


  expect_equal(pcaRes$center, pca_princomp$center)
  expect_equal(pcaRes$scale, pca_princomp$scale)
  expect_equal(as.data.frame(pcaRes$objects$scores, row.names = NA), as.data.frame(pca_princomp$scores, row.names = NA))
  expect_equal(pcaRes$eigenvectors[,], pca_princomp$loadings[,])
  expect_equal(pcaRes$eigenvalues, sapply(pca_princomp$sdev,function(x) x^2))
  expect_true(is.numeric(pcaRes$eigenvaluesAsPercentages))
  expect_true(is.numeric(pcaRes$cumulativePercentageOfEigenvalues))
})

test_that("constant values",  {

  expect_error(pca.calc(constantMockup), "Characters \"Ch2\" are invariant.")


})
