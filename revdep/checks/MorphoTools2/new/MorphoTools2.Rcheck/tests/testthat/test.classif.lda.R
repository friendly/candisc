context("classif.lda")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)


test_that("correct input", {
  data("centaurea")
  expect_error(classif.lda(centaurea), "NA values in 'object'.")

  expect_error(classif.lda(morphoMockup, crossval = "ee"), "Invalid crossvalidation unit. Consider using \"indiv\" or \"pop\".")
})

test_that("correctness of calculation",  {
  c = suppressWarnings(classif.lda(morphoMockup))

  expect_is( c, "classifdata")

  expect_equal( attr(c, "method"), "lda")

  expect_equal(paste(unlist(c$prob)[1:4], collapse = ","), "0.7523,0.6484,3e-04,0.4131")
  expect_equal(paste(unlist(c$correct)[1:4], collapse = ","), "TRUE,TRUE,FALSE,FALSE")
  expect_equal(paste(unlist(c$classif), collapse = ","), "TaxA,TaxA,TaxB,TaxB,TaxA,TaxA,TaxB,TaxB")
  expect_equal(paste(c$ID, collapse = ","), "id1,id2,id3,id4,id5,id6,id7,id8")
})


test_that("correctness of calculation  -to iste 2 metodami",  {

  data = read.morphodata("../testFiles/samplePlnaMatica.txt")


  bezRTE = removePopulation(data, populationName = "RTE")
  RTE = keepPopulation(data, populationName = "RTE")

  RTE.classif = suppressWarnings(classifSample.lda(RTE, bezRTE))
  class_vsetko = suppressWarnings(classif.lda(data, crossval = "pop"))

  expect_equal(class_vsetko$ID[473:492], RTE.classif$ID)
  expect_equal(as.character(class_vsetko$Population[473:492]), as.character(RTE.classif$Population))
  expect_equal(paste(class_vsetko$classif[473:492]), paste(RTE.classif$classif[1:20]))
  expect_equal(class_vsetko$prob[473:492,], RTE.classif$prob)

})


