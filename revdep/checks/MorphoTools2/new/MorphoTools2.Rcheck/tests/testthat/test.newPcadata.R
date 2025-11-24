context(".newPcadata")

test_that("check class of new object",  {


  newObject = .newPcadata()

  expect_is(newObject, "pcadata")

  expect_named(newObject, c('objects', 'eigenvectors', 'eigenvalues', 'eigenvaluesAsPercentages', 'cumulativePercentageOfEigenvalues', 'groupMeans', 'rank', 'center', 'scale'))

  expect_named(newObject$objects, c('ID', 'Population', 'Taxon', 'scores'))

})
