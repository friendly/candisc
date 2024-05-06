context(".newMorphodata")

test_that("check class of new object",  {


  newObject = .newMorphodata()

  expect_is(newObject, "morphodata")

  expect_output(str(newObject), "List of 4")

  expect_named(newObject, c('ID', 'Population', 'Taxon', 'data'))


})
