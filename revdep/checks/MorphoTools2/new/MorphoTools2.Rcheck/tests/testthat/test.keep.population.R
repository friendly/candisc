context("keepPopulation")

data = read.morphodata("../testFiles/sample.txt")

test_that("keep unexisting population",  {
  expect_error(removePopulation(data, "unexisting"), "Population \"unexisting\" does not exist." )
})

test_that("keep one population",  {
  subData = keepPopulation(data, "BABL")

  expect_equal(1, length(levels(subData$Population)))

  expect_equal(20, dim(subData$data)[1])

  expect_equal(paste(subData$data[,1], collapse = " "), "35 34.9 37.8 37.2 27.1 32.5 70.2 37 37.2 34.3 35.3 40.2 20.4 34.7 20.2 23.9 64.7 30.1 23.6 61.2")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})

test_that("keep N population",  {
  subData = keepPopulation(data, c("BABL","CERM", "DUB" ))

  expect_equal(3, length(levels(subData$Population)))

  expect_equal(60, dim(subData$data)[1])

  expect_equal(paste(subData$data[,1], collapse = " "), "35 34.9 37.8 37.2 27.1 32.5 70.2 37 37.2 34.3 35.3 40.2 20.4 34.7 20.2 23.9 64.7 30.1 23.6 61.2 39.5 49.9 37.4 43.9 23.1 49.6 57.1 44.6 58 51.7 55.3 46 28.6 36.4 38.8 32.5 42.9 37.2 29.1 34.7 46 26.7 29.8 33.5 43.4 33.6 35.3 41.1 35.6 46.3 65.7 51.9 39.6 47.8 55.6 57.9 62.6 51.8 68.7 51.3")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})
