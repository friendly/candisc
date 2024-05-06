context(".formatDescrStatistic")

morphoMockup = list("ID" = factor(x = c(1,2,3,4,5,6,7,8)),
                    "Population" = factor(x = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4")),
                    "Taxon" = factor(x = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB")),
                    "all" = factor(x = c("all", "all", "all", "all", "all", "all", "all", "all")),
                    "data" = data.frame(
                      "Ch1" = 1:8,
                      "Ch2" = 11:18))

result = .descrByGroup(morphoMockup, "Taxon", 3)
taxa =  levels(morphoMockup$Taxon)
characters = colnames(morphoMockup$data)

test_that("checking correctness of output",  {

  output = .formatDescrStatistic(groups = taxa, characters = characters, descrStatistic = result, format = "$MEAN" )
  expect_equal(output[3,2], "2.5")
  expect_equal(output[4,3], "16.5")

  output = .formatDescrStatistic(groups = taxa, characters = characters, descrStatistic = result, format = "$SD" )
  expect_equal(output[3,2], "1.291")

  output = .formatDescrStatistic(groups = taxa, characters = characters, descrStatistic = result, format = "$SD" )
  expect_equal(output[3,2], "1.291")

  output = .formatDescrStatistic(groups = taxa, characters = characters, descrStatistic = result, format = "$95%" )
  expect_equal(output[3,2], "3.85")

  output = .formatDescrStatistic(groups = taxa, characters = characters, descrStatistic = result, format = "$MEDIAN" )
  expect_equal(output[3,3], "6.5")
})
