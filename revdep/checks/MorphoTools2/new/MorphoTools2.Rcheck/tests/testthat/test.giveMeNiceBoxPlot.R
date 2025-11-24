
context(".giveMeNiceBoxPlot")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "data" = data.frame(
                               "Ch1" = c(1,3,4,6,1,7,12,8),
                               "Ch2" = c(11, 12,42,12,32,11,22,18)))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

test_that("correctness of calculation",  {

  bxplot = .giveMeNiceBoxPlot(morphoMockup, "data.Ch1", 0.95, 0.05)

  expect_equal(paste(bxplot$stats, collapse = " "), "1.3 2 3.5 5 5.7 1.9 4 7.5 10 11.4")
  expect_equal(paste(bxplot$out, collapse = " "), "1 6 1 12")
  expect_equal(paste(bxplot$names, collapse = " "), "TaxA TaxB")

})
