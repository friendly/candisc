context(".morphodataFromDataFrame")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = 1:8,
                               "Ch2" = 11:18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)


test_that("checking correctness of parsing dataframe to morphodata",  {

  expect_is(morphoMockup, "morphodata")

  expect_equal(paste(morphoMockup$ID, collapse = " "), "id1 id2 id3 id4 id5 id6 id7 id8")

  expect_equal(paste(morphoMockup$Population, collapse = " "), "Pop1 Pop1 Pop2 Pop2 Pop3 Pop3 Pop4 Pop4")

  expect_equal(paste(morphoMockup$Taxon, collapse = " "), "TaxA TaxA TaxA TaxA TaxB TaxB TaxB TaxB")

  expect_equal(paste(morphoMockup$data, collapse = " "), "1:8 11:18")
})

wrongDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Pop" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Tax" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = 1:8,
                               "Ch2" = 11:18))


test_that("trying to parse wrong formated data",  {

  expect_error(.morphodataFromDataFrame(wrongDataFrame))


})
