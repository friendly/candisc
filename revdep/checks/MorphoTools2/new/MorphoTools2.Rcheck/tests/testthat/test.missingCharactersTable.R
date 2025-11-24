context("missingCharactersTable")

data = read.morphodata("../testFiles/sample.txt")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8", "id9", "id10"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "Ch1" = c(1,3,4,6,1,7,12,8,NA, NA),
                             "Ch2" = c(11, 12,42,12,32,11,11,2,NA,NA),
                             "Ch4" = c(11, 12,42,12,32,11,NA,2,NA,18))

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)

test_that("wrong input",  {
  expect_error(missingCharactersTable(data, "unexisting"), "Invalid level of grouping. Consider using \"taxon\", \"pop\" or \"indiv\"")
})


test_that("missingCharactersTable",  {
  t = missingCharactersTable(data, "taxon")
  expect_equal(paste(t[1,], collapse = ";"), "1;120;0.05;139")
  expect_equal(paste(dim(t), collapse = ";"), "4;4")

  t = missingCharactersTable(data, "pop")
  expect_equal(paste(t[1,], collapse = ";"), "1;3;20;0.03;16")
  expect_equal(paste(dim(t), collapse = ";"), "33;5")

  t = missingCharactersTable(data, "indiv")
  expect_equal(paste(t[1,], collapse = ";"), "1;1;3;1;0;0")
  expect_equal(paste(dim(t), collapse = ";"), "652;6")

  t = missingCharactersTable(morphoMockup, "pop")
  expect_equal(paste(t[1,], collapse = ";"), "1;1;2;0;0")
  expect_equal(paste(dim(t), collapse = ";"), "4;5")
})

