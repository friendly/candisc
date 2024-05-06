context("keepSample")

data = read.morphodata("../testFiles/sample.txt")


test_that("wrong input",  {
  expect_error(keepSample(data, "unexisting"), "Sample \"unexisting\" does not exist." )

  expect_error(keepSample(data), "One of the arguments: 'sampleName' or 'missingPercentage' has to be specified." )

  expect_error(keepSample(data, sampleName = "ds", missingPercentage = 2), "Not implemented, use arguments 'sampleName' and 'missingPercentage' in separate runs." )

  expect_error(keepSample(data, sampleName = 2), "'sampleName' is not a string." )

  expect_error(keepSample(data, missingPercentage = "ds"), "'missingPercentage' is not numeric." )
})


test_that("keep sample by name",  {
  subData = keepSample(data, sampleName = "RTE3")

  expect_equal(1, length(levels(subData$Population)))
  expect_equal(1, length(subData$Population))
  expect_equal(paste(subData$ID), "RTE3")


  subData = keepSample(data, sampleName = c("RTE3", "RTE4","RTE6"))

  expect_equal(1, length(levels(subData$Population)))
  expect_equal(3, length(subData$Population))
  expect_equal(paste(subData$ID, collapse = ","), "RTE3,RTE4,RTE6")
})


test_that("keep sample by %",  {

  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8", "id9", "id10"),
                               "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8,NA, NA),
                               "Ch2" = c(11, 12,42,12,32,11,11,2,NA,NA),
                               "Ch4" = c(11, 12,42,12,32,11,NA,2,NA,18))

  morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

  subData = keepSample(morphoMockup, missingPercentage = 1)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8,id9,id10")

  subData = removeSample(morphoMockup, missingPercentage = 0.7)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) -1 , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8,id10")

  subData = removeSample(morphoMockup, missingPercentage = 0.4)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) -2 , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8")

  subData = removeSample(morphoMockup, missingPercentage = 0.1)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) -3 , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id8")

})
