test_that("cancor returns correct structure", {
  data(Rohwer, package = "heplots")
  X <- as.matrix(Rohwer[, 6:10])  # PA tests
  Y <- as.matrix(Rohwer[, 3:5])   # Ability variables
  
  cc <- cancor(X, Y, set.names = c("PA", "Ability"))
  
  # Test object class
  expect_s3_class(cc, "cancor")
  
  # Test essential components
  expect_true(all(c("cancor", "names", "ndim", "dim", 
                    "coef", "scores", "X", "Y") %in% names(cc)))
  
  # Test canonical correlations are between 0 and 1
  expect_true(all(cc$cancor >= 0 & cc$cancor <= 1))
  
  # Test they're in decreasing order
  expect_true(all(diff(cc$cancor) <= 0))
})

# test_that("cancor formula method works", {
#   data(Rohwer, package = "heplots")
#   
#   # Formula interface
#   cc_formula <- cancor(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss,
#                       data = Rohwer)
#   # Gives warning:
#       # Warning message:
#       # In model.matrix.default(mt, mf, contrasts) :
#       #   non-list contrasts argument ignored
#   
#   expect_s3_class(cc_formula, "cancor")
#   expect_true("terms" %in% names(cc_formula))
# })


