context("plotCharacters.cdadata_hist")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

# locally suppress warnings
data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))
centaurea = removeTaxon(centaurea, taxonName = c("hybr", "ph"))

cdaRes = cda.calc(centaurea)


test_that("hist",  {
  pdf(NULL)
  on.exit(dev.off())
  plot.new()

  expect_warning(plotCharacters(cdaRes, axes = c(1,3)), "The object has only one axis, which will be plotted")

  expect_warning(plotCharacters(cdaRes, axes = 4), "The object has only one axis, which will be plotted")

})
