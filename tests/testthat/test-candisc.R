
library(candisc)

test_that("candisc returns correct structure", {
  # Setup test data
  data(Pottery, package = "carData")
  pottery.mod <- lm(cbind(Al, Fe, Mg, Ca, Na) ~ Site, data = Pottery)
  pottery.can <- candisc(pottery.mod)
  
  # Test object class
  expect_s3_class(pottery.can, "candisc")
  
  # Test essential components exist
  expect_true(all(c("dfh", "dfe", "eigenvalues", "canrsq", 
                    "pct", "ndim", "means", "structure", 
                    "coeffs.raw", "coeffs.std", "scores") %in% 
                    names(pottery.can)))
  
  # Test dimensions
  expect_equal(pottery.can$ndim, min(pottery.can$dfh, ncol(pottery.mod$model[[1]])))
  
  # Test eigenvalues are non-negative: NO: can be very near -0
  #expect_true(all(pottery.can$eigenvalues >= 0))
  
  # Test canonical R-squared is between 0 and 1
  expect_true(all(pottery.can$canrsq >= 0 & pottery.can$canrsq <= 1))
})

test_that("candisc handles 1D case correctly", {
  # Test with only 2 groups (1 canonical dimension)
  data(Wine, package = "candisc")
  wine_subset <- Wine[Wine$Cultivar %in% c("barolo", "grignolino"), ]
  wine_subset$Cultivar <- droplevels(wine_subset$Cultivar)
  
  wine.mod <- lm(cbind(Alcohol, MalicAcid) ~ Cultivar, data = wine_subset)
  wine.can <- candisc(wine.mod)
  
  expect_equal(wine.can$ndim, 1)
  
  # NO: all eigenvalues are returned
  #expect_equal(length(wine.can$eigenvalues), 1)
})


test_that("candisc handles ndim parameter", {
  data(Pottery, package = "carData")
  pottery.mod <- lm(cbind(Al, Fe, Mg, Ca, Na) ~ Site, data = Pottery)
  
  # Request only 2 dimensions
  pottery.can <- candisc(pottery.mod, ndim = 2)
  expect_equal(ncol(pottery.can$scores) - ncol(pottery.mod$model[, -1, drop = FALSE]), 2)
})

test_that("candisc error handling", {
  data(Pottery, package = "carData")
  pottery.mod <- lm(Al ~ Site, data = Pottery)  # Univariate model
  
  # Should error on non-mlm object
  expect_error(candisc(pottery.mod))
})
