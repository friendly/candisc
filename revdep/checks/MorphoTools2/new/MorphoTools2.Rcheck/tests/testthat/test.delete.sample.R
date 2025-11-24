context("removeSample")

data = read.morphodata("../testFiles/sample.txt")

test_that("wrong input",  {
  expect_error(removeSample(data, "unexisting"), "Sample \"unexisting\" does not exist." )

  expect_error(removeSample(data), "One of the arguments: 'sampleName' or 'missingPercentage' has to be specified." )

  expect_error(removeSample(data, sampleName = "ds", missingPercentage = 2), "Not implemented, use arguments 'sampleName' and 'missingPercentage' in separate runs." )

  expect_error(removeSample(data, sampleName = 2), "Sample \"2\" does not exist." )

  expect_error(removeSample(data, missingPercentage = "ds"), "'missingPercentage' is not numeric." )
})


test_that("remove sample by name",  {
  subData = removeSample(data, sampleName = "RTE3")

  expect_equal(length(levels(data$Population)), length(levels(subData$Population)))
  expect_equal(length(data$Population) - 1, length(subData$Population))
  expect_equal(paste(head(subData$ID), collapse = ","), "RTE1,RTE2,RTE4,RTE5,RTE6,RTE7")


  subData = removeSample(data, sampleName = c("RTE3", "RTE4","RTE6"))

  expect_equal(length(levels(data$Population)), length(levels(subData$Population)))
  expect_equal(length(data$ID) - 3, length(subData$Population))
  expect_equal(paste(head(subData$ID), collapse = ","), "RTE1,RTE2,RTE5,RTE7,RTE8,RTE9")

})


test_that("remove sample by %",  {

  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8", "id9", "id10"),
                               "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8,NA, NA),
                               "Ch2" = c(11, 12,42,12,32,11,11,2,NA,18))

  morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

  subData = removeSample(morphoMockup, missingPercentage = 1)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8,id9,id10")

  subData = removeSample(morphoMockup, missingPercentage = 0.6)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) -1 , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8,id10")

  subData = removeSample(morphoMockup, missingPercentage = 0.2)
  expect_equal(length(levels(morphoMockup$Population)), length(levels(subData$Population)))
  expect_equal(length(morphoMockup$Population) -2 , length(subData$Population))
  expect_equal(paste((subData$ID), collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8")

})
