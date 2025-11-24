context("classifSample.lda")

data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))

trainingSet = removePopulation(centaurea, populationName = "SOK")
SOK = keepPopulation(centaurea, populationName = "SOK")





test_that("correct input - NA values", {
  trainingDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                                 "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                                 "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                                 "data" = data.frame(
                                   "Ch1" = c(1,3,NA,6,1,7,12,8),
                                   "Ch2" = c(11, 12,42,12,32,11,22,18)))

  sampDataFrame = data.frame("ID" = c("id1X","id2X"),
                             "Population" = c("PopX", "PopX"),
                             "Taxon" = c("TaxX", "TaxX"),
                             "data" = data.frame(
                               "Ch1" = c(11,13),
                               "Ch2" = c(31, 32)))

  trainingMockup = .morphodataFromDataFrame(trainingDataFrame)
  sampMockup = .morphodataFromDataFrame(sampDataFrame)

  expect_error(classifSample.lda(sampMockup, trainingMockup), "NA values in 'trainingData'.")

  ##############x

  trainingDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                                 "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                                 "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                                 "data" = data.frame(
                                   "Ch1" = c(1,3,3,6,1,7,12,8),
                                   "Ch2" = c(11, 12,42,12,32,11,22,18)))

  sampDataFrame = data.frame("ID" = c("id1X","id2X"),
                             "Population" = c("PopX", "PopX"),
                             "Taxon" = c("TaxX", "TaxX"),
                             "data" = data.frame(
                               "Ch1" = c(NA,13),
                               "Ch2" = c(31, 32)))

  trainingMockup = .morphodataFromDataFrame(trainingDataFrame)
  sampMockup = .morphodataFromDataFrame(sampDataFrame)

  expect_error(classifSample.lda(sampMockup, trainingMockup), "NA values in 'sampleData'.")

})



test_that("correct input - different characters", {
  trainingDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                                 "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                                 "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                                 "data" = data.frame(
                                   "Ch1" = c(1,3,3,6,1,7,12,8),
                                   "Ch2" = c(11, 12,42,12,32,11,22,18)))

  sampDataFrame = data.frame("ID" = c("id1X","id2X"),
                             "Population" = c("PopX", "PopX"),
                             "Taxon" = c("TaxX", "TaxX"),
                             "data" = data.frame(
                               "ChX" = c(11,13),
                               "Ch2" = c(31, 32)))

  trainingMockup = .morphodataFromDataFrame(trainingDataFrame)
  sampMockup = .morphodataFromDataFrame(sampDataFrame)

  expect_error(classifSample.lda(sampMockup, trainingMockup), "Characters of 'sampleData' and 'trainingData' are not the same.")

})


test_that("correctness of calculation",  {
  classif.lda.SOK = suppressWarnings(classifSample.lda(SOK, trainingSet))
  
  expect_is( classif.lda.SOK, "classifdata")

  expect_equal( attr(classif.lda.SOK, "method"), "lda")



  expect_equal(paste(classif.lda.SOK$prob[1,1:3], collapse = ","), "0.0019,0.0072,0.9909")
  expect_equal(paste(classif.lda.SOK$correct, collapse = ","), "")
  expect_equal(paste(unlist(classif.lda.SOK$classif), collapse = ","), "ps,ps,ps,ps,ps,ps,ps,ps,hybr,ps,ps,ps,ps,ps,ps,ps,ps,ps,ps,ps")
  expect_equal(paste(classif.lda.SOK$ID, collapse = ","), "SOK388,SOK389,SOK390,SOK391,SOK392,SOK393,SOK394,SOK395,SOK396,SOK397,SOK398,SOK399,SOK402,SOK403,SOK406,SOK409,SOK414,SOK415,SOK416,SOK417")
})

