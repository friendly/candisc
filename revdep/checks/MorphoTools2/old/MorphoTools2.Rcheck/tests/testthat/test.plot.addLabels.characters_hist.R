context("plotAddLabels.characters_hist")

data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))

cdaRes = cda.calc(centaurea, passiveSamples = c("hybr", "ph"))

test_that("cda wrong input",  {

  pdf(NULL)
  on.exit(dev.off())
  plot.new()

  expect_warning(plotAddLabels.characters(cdaRes, axes = 2), "The object has only one axis, which will be plotted.", fixed = TRUE)


  expect_warning(plotAddLabels.characters(cdaRes, axes = c(2,26)), "The object has only one axis, which will be plotted.")

  expect_error(plotAddLabels.characters(cdaRes, labels = "eeee", pos = 4, cex = 1), "Label \"eeee\" does not exist.")

})
