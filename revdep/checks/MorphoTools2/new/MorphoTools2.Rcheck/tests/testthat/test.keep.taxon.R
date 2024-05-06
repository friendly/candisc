context("keepTaxon")

data = read.morphodata("../testFiles/sample.txt")

test_that("keeping unexisting taxon",  {
  expect_error(keepTaxon(data, "unexisting"), "Taxon \"unexisting\" does not exist." )
})

test_that("keep one taxon",  {
  subData = keepTaxon(data, "hybr")

  expect_equal(1, length(levels(subData$Taxon)))

  expect_equal(120, dim(subData$data)[1])

  expect_equal(paste(subData$data[,1], collapse = " "), "35.2 39 24.8 30 30.6 20.8 12.6 29.1 16.5 18 54 45.5 49.8 64.4 30.4 23.7 19.9 30.4 18 35.3 39.3 34.2 42.6 42.1 48 36.9 45.3 45.3 43.8 44.3 39.8 57.8 56.7 49.4 46.2 43 46.3 47.1 31 27.2 18.6 29.1 13.1 15 31.4 50.4 41.4 35.7 21.2 10 21.2 24.3 34.3 51.9 30.8 44.9 26.4 24.6 43.2 38.9 36.8 44.3 48.4 41.6 44.5 45.6 44 44 37.6 35.5 39.2 46.3 33.5 46 16.9 31.1 34.1 57.8 46.4 43 75.4 91.6 61.3 93 87 82.2 124.1 65.5 69.3 93.8 79.8 47.5 92 113.7 85.2 101.2 101.4 82.9 73.7 61.7 101.8 49.4 53.5 51.5 34.4 45.3 63 78.1 72.3 57.5 88.6 70.6 40.8 59.5 57.6 79.4 36.3 41.6 61.7 56.3")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})

test_that("keep two taxon",  {
  subData = keepTaxon(data, c("hybr", "ps"))

  expect_equal(2, length(levels(subData$Taxon)))
  expect_equal(c("hybr", "ps"), levels(subData$Taxon))

  expect_equal(360, dim(subData$data)[1])
})

test_that("keep all",  {
  subData = keepTaxon(data, c("hybr", "ph", "ps", "st"))

  expect_equal(4, length(levels(subData$Taxon)))
  expect_equal(levels(data$Taxon), levels(subData$Taxon))

  expect_equal(652, dim(subData$data)[1])
})
