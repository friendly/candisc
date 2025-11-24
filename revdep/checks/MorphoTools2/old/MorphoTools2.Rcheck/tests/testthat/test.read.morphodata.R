context("read.morphodata: unvalid input")


test_that("input file is too short", {
  expect_error(read.morphodata("../testFiles/shortFile.txt"), "Incorrect data format.")
})

test_that("input file contains NaN", {
  expect_error(read.morphodata("../testFiles/sample_NaNs.txt"), "Input contains non-numeric data.")
})

test_that("decimal point character is \",\" - UNcorrectly stated",  {
  expect_error(read.morphodata("../testFiles/sample_NaNs.txt"), "Input contains non-numeric data.")
})

test_that("numeric names of pops and taxa",  {
  expect_error(read.morphodata("../testFiles/sample_numericNames.txt"), "Input do not contain required columns.")
})


context("read.morphodata: valid input")

test_that("decimal point character is \",\" - correctly stated",  {
  data = read.morphodata("../testFiles/sample_decComa.txt", dec=",")

  expect_output(str(data), "List of 4")
  expect_is(data, "morphodata")
})

test_that("collums delimited by space",  {
  data = read.morphodata("../testFiles/sample_whitespaceDelim.txt", sep = " ")

  expect_output(str(data), "List of 4")
  expect_is(data, "morphodata")
})
