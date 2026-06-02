# Test rev.axes argument in heplot.cancor
#
# rev.axes=TRUE on an axis negates both the canonical scores (so the HE
# ellipses flip) and the corresponding column of the X and Y structure
# matrices (so variable vectors flip consistently).
#
# Run this script interactively after devtools::load_all().

library(candisc)
data(Rohwer, package = "heplots")

X <- as.matrix(Rohwer[, 6:10])
Y <- as.matrix(Rohwer[, 3:5])
cc <- cancor(X, Y, set.names = c("PA", "Ability"))

op <- par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))

# baseline
heplot(cc, main = "default (no reversal)",
       var.col = c("blue", "darkgreen"), var.lwd = 2)

# reverse axis 1 only
heplot(cc, rev.axes = c(TRUE, FALSE),
       main = "rev.axes = c(TRUE, FALSE)",
       var.col = c("blue", "darkgreen"), var.lwd = 2)

# reverse axis 2 only
heplot(cc, rev.axes = c(FALSE, TRUE),
       main = "rev.axes = c(FALSE, TRUE)",
       var.col = c("blue", "darkgreen"), var.lwd = 2)

# reverse both axes
heplot(cc, rev.axes = c(TRUE, TRUE),
       main = "rev.axes = c(TRUE, TRUE)",
       var.col = c("blue", "darkgreen"), var.lwd = 2)

par(op)

# Visual checks:
# - Reversing axis 1 should mirror all H ellipses and variable vectors
#   left-to-right relative to the baseline.
# - Reversing axis 2 should mirror them top-to-bottom.
# - Reversing both should give a point-reflection (180-degree rotation).
# - The shape and relative proportions of ellipses must be unchanged.
# - Variable vector angles and relative lengths must be preserved.
