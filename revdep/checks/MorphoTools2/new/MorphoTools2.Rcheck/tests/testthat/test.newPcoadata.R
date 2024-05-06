context(".newPcoadata")

test_that("check class of new object",  {


  newObject = .newPcoadata()

  expect_is(newObject, "pcoadata")

  expect_named(newObject, c('objects', 'eigenvalues', 'eigenvaluesAsPercentages', 'cumulativePercentageOfEigenvalues', 'groupMeans', 'distMethod', 'rank'))

  expect_named(newObject$objects, c('ID', 'Population', 'Taxon', 'scores'))

})
