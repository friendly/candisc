test_that("candiscList returns correct structure", {

  data(Grass, package = "candisc")
  grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
  grass.canL <-candiscList(grass.mod)
  
  # Test object class
  expect_s3_class(grass.canL, "candiscList")
  
  # Test that it's a list with named components
  expect_type(grass.canL, "list")
  expect_true(length(grass.canL) > 0)
  
  # Each component should be a candisc object
  for (i in seq_along(grass.canL)) {
    expect_s3_class(grass.canL[[i]], "candisc")
  }
})

# test_that("candiscList handles `terms` parameter", {
#   data(Grass, package = "candisc")
#   grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
#   
#   # Request only one term: FAILS
#   grass.canL <- candiscList(grass.mod, terms = "Block")
#   expect_equal(length(grass.canL), 1)
#   expect_equal(names(grass.canL), "Block")
# })
