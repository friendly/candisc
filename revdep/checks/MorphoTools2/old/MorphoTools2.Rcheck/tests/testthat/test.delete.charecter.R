context("deleteCharecter")

data = read.morphodata("../testFiles/sample.txt")

test_that("trying to remove unexisting character",  {
  expect_error(removeCharacter(data, "unexistingCh"), "Character \"unexistingCh\" does not exist")
})


test_that("remove one character",  {
  subData = removeCharacter(data, "LL")

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(dim(data$data)[2] - 1, dim(subData$data)[2])

  expect_equal(paste(subData$data[1,], collapse = " "), "35.2 23.6 58.8 0.4 3.9 2.87 0 1 0 0 1.7 1.3 1.31 0 13.6 0.5 25.33 16 1 1 1 NA NA NA")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})

test_that("remove more characters",  {
  subData = removeCharacter(data, c("LL", "LLW", "MLW"))

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(dim(data$data)[2] - 3, dim(subData$data)[2])

  expect_equal(paste(subData$data[1,], collapse = " "), "35.2 23.6 58.8 0.4 3.9 0 1 0 0 1.7 1.3 1.31 0 13.6 0.5 16 1 1 1 NA NA NA")

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})

test_that("remove all but one characters",  {
  subData = removeCharacter(data, c("SN","SF","ST","SFT","LL","LW","LLW","LM","LBA","LBS","LS","IL","IW","ILW","CG","ML","MW","MLW","MF","IS","IV","AL","AW","ALW"))

  expect_equal(dim(data$data)[1], dim(subData$data)[1])

  expect_equal(1, dim(subData$data)[2])

  expect_equal("AP", colnames(subData$data))


  expect_equal(subData$data[12,], 1.2)

  expect_output(str(subData), "List of 4")
  expect_is(subData, "morphodata")
})






