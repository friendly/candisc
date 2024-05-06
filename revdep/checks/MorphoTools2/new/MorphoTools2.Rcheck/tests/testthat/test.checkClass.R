context(".checkClass")

dataMockup = list("ID" = factor(x = c(1,2,3,4,5,6,7,8)),
                    "Population" = factor(x = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4")),
                    "Taxon" = factor(x = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB")),
                    "data" = data.frame(
                      "Ch1" = 1:8,
                      "Ch2" = 11:18))



test_that("checkung class morphodata",  {

  attr(dataMockup, "class") <- "morphodata"

  .checkClass(dataMockup, "morphodata" )

  expect_error(.checkClass(dataMockup, "class" ), "Object is not of class 'class'.")
})


