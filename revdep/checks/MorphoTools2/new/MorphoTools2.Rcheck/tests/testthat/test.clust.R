context("clust")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18)))

morphoDataFrame_NA = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = c(1,3,NA,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18)))




morphoMockup = .morphodataFromDataFrame(morphoDataFrame)
morphoMockup_NA = .morphodataFromDataFrame(morphoDataFrame_NA)

test_that("notsupported methods",  {
  expect_error(clust(morphoMockup, distMethod = "notsupported"), "distMethod \"notsupported\" is not supported.")
  expect_error(clust(morphoMockup, clustMethod = "notsupported"), "clustMethod \"notsupported\" is not supported.")
})

test_that("NA in data",  {
  expect_warning(clust(morphoMockup_NA), "Values of some characters are NA.")

})

test_that("clustering",  {
  clustRes = clust(morphoMockup, clustMethod = "UPGMA")

  expect_equal(clustRes$method, "average")
  expect_equal(paste(clustRes$labels, collapse = " "), "id1 id2 id3 id4 id5 id6 id7 id8")
})




























