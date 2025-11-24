context("transformCharacter")

data("centaurea")

test_that("transform",  {


  newdata =  transformCharacter(centaurea, character = "SF", FUN = function(x) log(x+1))

  expect_equal(paste(centaurea$data$SF[1:5], collapse = ","), "23.6,11.8,23.4,25.5,27.8")
  expect_equal(paste(newdata$data$SF[1:5], collapse = ","), "3.20274644293832,2.54944517092557,3.19458313229916,3.27714473299218,3.3603753871419")

  newdata2 =  transformCharacter(centaurea, character = "SF", FUN = function(x) log(x+1), newName = "SF_log")

  expect_equal(newdata$data$SF, newdata2$data$SF_log)

})

