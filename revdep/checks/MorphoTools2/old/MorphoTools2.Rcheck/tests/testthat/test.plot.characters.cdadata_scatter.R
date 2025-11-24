context("plotCharacters.cdadata_scatter")

# locally suppress warnings
data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))

cdaRes = cda.calc(centaurea)

test_that("ploting with error parameters",  {

  expect_error(plotCharacters(cdaRes, axes = c(3,5)), "Specified axes are out of bounds. Object has only 3 axes.", fixed = TRUE)

  expect_error(plotCharacters(cdaRes, axes = c(1,1,2)), "You have to specify 2 axes (e.g., axes = c(1,2)).", fixed = TRUE) #
})

