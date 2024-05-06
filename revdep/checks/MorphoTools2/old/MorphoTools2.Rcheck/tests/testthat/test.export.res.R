context("exportRes")


test_that("class morphodata: read and export same data",  {

  data = read.morphodata("../testFiles/sample_mockup.txt")

  file0 = tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".txt")
  exportRes(data, file = file0)

  exportedData = read.morphodata(file0)

  expect_identical(data, exportedData)
})


test_that("class data.frame: read and export same data",  {

  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                               "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "data" = data.frame(
                                 "Ch1" = 1:8,
                                 "Ch2" = 11:18))

  file1 = tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".txt")
  exportRes(morphoDataFrame, file = file1)

  morphoDataFrame.imported = read.morphodata(file1)

  morphoDataFrame.morphodata = .morphodataFromDataFrame(morphoDataFrame)

  expect_identical(morphoDataFrame.imported, morphoDataFrame.morphodata)
})

test_that("class data.frame: compare as tables",  {

  morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                               "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                               "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "data" = data.frame(
                                 "Ch1" = 1:8,
                                 "Ch2" = 11:18))

  file2 = tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".txt")
  exportRes(morphoDataFrame, file = file2)

  DFImported = read.delim(file2)

  expect_identical(morphoDataFrame, DFImported)
})
