context("plotAddLabels.characters_scatter")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxB", "TaxB", "TaxC", "TaxC", "TaxC", "TaxC"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))
morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))


test_that("pca wrong input",  {
  pcaRes = pca.calc(centaurea)

  expect_error(plotAddLabels.characters(pcaRes, axes = 2), "You have to specify 2 axes (e.g., axes = c(1,2)).", fixed = TRUE)
  expect_error(plotAddLabels.characters(pcaRes, axes = c(2,26)), "Specified axes are out of bounds. Object has only 25 axes.")

  expect_error(plotAddLabels.characters(pcaRes, labels = "eeee", pos = 4, cex = 1), "Label \"eeee\" does not exist.")

  expect_error(plotAddLabels.characters(pcaRes, include = FALSE), "No labels to plot. You specified to exclude (include = FALSE) all labels.", fixed = TRUE)

})






