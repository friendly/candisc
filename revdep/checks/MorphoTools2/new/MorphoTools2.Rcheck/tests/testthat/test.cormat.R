context("cormat")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

test_that("correctness of calculation",  {

  cormatRes = cormat(morphoMockup)

  expect_equal(cormatRes[1,3], -0.119)
  expect_equal(cormatRes[2,3], 1)
})
