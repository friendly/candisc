context("keepCharecter")

data = read.morphodata("../testFiles/sample.txt")

test_that("trying to remove unexisting character",  {
  expect_error(keepCharacter(data, "unexistingCh"), "Character \"unexistingCh\" does not exist.")
})


test_that("keep one character",  {
  subData = keepCharacter(data, "LL")

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(1, dim(subData$data)[2])

  expect_equal(1, ncol(subData$data))

  expect_equal(colnames(subData$data), "LL" )

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})


test_that("keep more characters",  {
  subData = keepCharacter(data, c("LL", "LLW", "MLW"))

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(3, dim(subData$data)[2])

  expect_equal(paste(subData$data[1,], collapse = " "), "11.2 2.87 25.33")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})

test_that("keep all characters",  {
  subData = keepCharacter(data, c("SN","SF","ST","SFT","LL","LW","LLW","LM","LBA","LBS","LS","IL","IW","ILW","CG","ML","MW","MLW","MF","IS","IV","AL","AW","ALW","AP"))

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(dim(data$data)[2], dim(subData$data)[2])

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})


test_that("keep all but one characters",  {
  subData = keepCharacter(data, c("SN","SF","ST","SFT","LL","LW","LLW","LM","LBA","LBS","LS","IL","IW","ILW","CG","ML","MW","MLW","MF","IS","IV","AL","ALW","AP")) # AW

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(dim(data$data)[2]-1, dim(subData$data)[2])

  expect_equal(colnames(subData$data), c("SN","SF","ST","SFT","LL","LW","LLW","LM","LBA","LBS","LS","IL","IW","ILW","CG","ML","MW","MLW","MF","IS","IV","AL","ALW","AP"))

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})




