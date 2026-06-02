# Test / scratch for rev.axes in heplot3d.candisc
#
# NOTE: The general problem of reversing (reflecting) axes in biplots and
# related displays is solved as an S3 generic in ggbiplot::reflect().
# That may be the better long-term approach rather than duplicating the
# rev.axes argument across heplot methods.
#
# Run interactively after devtools::load_all(); requires rgl.

library(candisc)

# Pottery data has 5 groups → 4 canonical dimensions, so heplot3d works
data(Pottery, package = "carData")
pottery.mod <- lm(cbind(Al, Fe, Mg, Ca, Na) ~ Site, data = Pottery)
pottery.can <- candisc(pottery.mod)
pottery.can   # check ndim

if (requireNamespace("rgl", quietly = TRUE)) {

  # baseline
  rgl::open3d()
  heplot3d(pottery.can, var.lwd = 3, scale = 10, zlim = c(-3, 3), wire = FALSE,
           main = "default (no reversal)")

  # reverse axis 1 only
  rgl::open3d()
  heplot3d(pottery.can, rev.axes = c(TRUE, FALSE, FALSE),
           var.lwd = 3, scale = 10, zlim = c(-3, 3), wire = FALSE,
           main = "rev.axes = c(TRUE, FALSE, FALSE)")

  # reverse axis 2 only
  rgl::open3d()
  heplot3d(pottery.can, rev.axes = c(FALSE, TRUE, FALSE),
           var.lwd = 3, scale = 10, zlim = c(-3, 3), wire = FALSE,
           main = "rev.axes = c(FALSE, TRUE, FALSE)")

  # reverse axis 3 only
  rgl::open3d()
  heplot3d(pottery.can, rev.axes = c(FALSE, FALSE, TRUE),
           var.lwd = 3, scale = 10, zlim = c(-3, 3), wire = FALSE,
           main = "rev.axes = c(FALSE, FALSE, TRUE)")

  # reverse all three axes
  rgl::open3d()
  heplot3d(pottery.can, rev.axes = c(TRUE, TRUE, TRUE),
           var.lwd = 3, scale = 10, zlim = c(-3, 3), wire = FALSE,
           main = "rev.axes = c(TRUE, TRUE, TRUE)")

}

# Visual checks (same logic as the 2D case):
# - Reversing axis i should mirror all H ellipsoids and variable vectors
#   along that axis relative to the baseline.
# - Reversing all three axes gives a point-reflection through the origin.
# - Ellipsoid shapes and relative vector lengths/angles must be unchanged.
