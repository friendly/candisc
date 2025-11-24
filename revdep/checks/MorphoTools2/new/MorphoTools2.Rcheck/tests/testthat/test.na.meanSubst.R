context("naMeanSubst")

test_that("correctnes of repacement",  {
  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                               "Population" = c("Pop1", "Pop1", "Pop1", "Pop1", "Pop3", "Pop3", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "data" = data.frame(
                                 "Ch1" = c(1, 2, NA, 4, 5, 6, NA, 8),
                                 "Ch2" = c(11, NA, 13, NA, 15, NA, 17, 18)))
  morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

  meanMockup = naMeanSubst(morphoMockup)

  expect_is(meanMockup, "morphodata")

  expect_equal(paste(unlist(meanMockup$data), collapse = ","), "1,2,2.333,4,5,6,8,8,11,12,13,12,15,15,17,18")

})

test_that("some NAs remains",  {
  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                               "Population" = c("Pop1", "Pop1", "Pop1", "Pop1", "Pop3", "Pop3", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                                 "Ch1" = c(1, 2, NA, 4, 5, 6, NA, NA),
                                 "Ch2" = c(11, NA, 13, NA, 15, NA, 17, 18))
  morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

  meanMockup = suppressWarnings(naMeanSubst(morphoMockup))

  expect_is(meanMockup, "morphodata")

  expect_equal(paste(unlist(meanMockup$data), collapse = ","), "1,2,2.333,4,5,6,NA,NA,11,12,13,12,15,15,17,18")

  expect_warning(naMeanSubst(morphoMockup), "Unable to replace NAs in characters Ch1 in population Pop4. Probably all values of that character are NA.")
})

