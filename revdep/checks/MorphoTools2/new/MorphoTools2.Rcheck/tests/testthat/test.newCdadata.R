context(".newCdadata")

test_that("check class of new object",  {


  newObject = .newCdadata()

  expect_is(newObject, "cdadata")

  expect_output(str(newObject), "List of 10")

  expect_named(newObject, c('objects', 'eigenvalues', 'eigenvaluesAsPercentages', 'cumulativePercentageOfEigenvalues', 'groupMeans', 'rank',
                            'coeffs.std', 'coeffs.raw', 'totalCanonicalStructure', 'canrsq'))

  expect_named(newObject$objects, c('ID', 'Population', 'Taxon', 'scores'))

})
