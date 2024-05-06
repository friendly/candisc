context(".descrByGroup")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = 1:8,
                               "Ch2" = 11:18))

#morphoDataFrame = data.frame("ID" = c("id1","id2"), "Population" = c("Pop1", "Pop1"), "Taxon" = c("TaxA", "TaxA"), "data" = data.frame("Ch1" = 1:2))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

morphoMockup$all = as.factor( rep("all", length(morphoMockup$Taxon)))


test_that("checking accuracy of computation for level Taxon",  {
  result = .descrByGroup(morphoMockup, "Taxon", 3)

  expect_match(paste(result[,,"TaxA"][1,], collapse = ", "), "4, 2.5, 1.291, 1, 1.15, 1.75, 2.5, 3.25, 3.85, 4")
  expect_match(paste(result[,,"TaxB"][1,], collapse = ", "), "4, 6.5, 1.291, 5, 5.15, 5.75, 6.5, 7.25, 7.85, 8")
  expect_match(paste(result[,,"TaxB"][2,], collapse = ", "), "4, 16.5, 1.291, 15, 15.15, 15.75, 16.5, 17.25, 17.85, 18")
})

test_that("checking accuracy of computation for level Population",  {
  result = .descrByGroup(morphoMockup, "Population", 3)

  expect_match(paste(result[,,"Pop1"][1,], collapse = ", "), "2, 1.5, 0.707, 1, 1.05, 1.25, 1.5, 1.75, 1.95, 2")
  expect_match(paste(result[,,"Pop1"][2,], collapse = ", "), "2, 11.5, 0.707, 11, 11.05, 11.25, 11.5, 11.75, 11.95, 12")
  expect_match(paste(result[,,"Pop4"][2,], collapse = ", "), "2, 17.5, 0.707, 17, 17.05, 17.25, 17.5, 17.75, 17.95, 18")
})

test_that("checking accuracy of computation for level All",  {

  result = .descrByGroup(morphoMockup, "all", 3)

  expect_match(paste(result[,,"all"][1,], collapse = ", "), "8, 4.5, 2.449, 1, 1.35, 2.75, 4.5, 6.25, 7.65, 8")
  expect_match(paste(result[,,"all"][2,], collapse = ", "), "8, 14.5, 2.449, 11, 11.35, 12.75, 14.5, 16.25, 17.65, 18")
})

