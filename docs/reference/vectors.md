# Draw Labeled Vectors in 2D or 3D

Graphics utility functions to draw vectors from an origin to a
collection of points (using
[`graphics::arrows()`](https://rdrr.io/r/graphics/arrows.html) in 2D or
[`rgl::lines3d()`](https://dmurdoch.github.io/rgl/dev/reference/primitives.html)
in 3D) with labels for each (using
[`graphics::text()`](https://rdrr.io/r/graphics/text.html) or
[`rgl::texts3d()`](https://dmurdoch.github.io/rgl/dev/reference/texts.html)

## Usage

``` r
vectors(
  x,
  origin = c(0, 0),
  labels = rownames(x),
  scale = 1,
  col = "blue",
  lwd = 1,
  cex = 1,
  length = 0.1,
  angle = 13,
  pos = NULL,
  ...
)
```

## Arguments

- x:

  A two-column matrix or a three-column matrix containing the end points
  of the vectors

- origin:

  Starting point(s) for the vectors

- labels:

  Labels for the vectors

- scale:

  A multiplier for the length of each vector

- col:

  color(s) for the vectors.

- lwd:

  line width(s) for the vectors.

- cex:

  color(s) for the vectors.

- length:

  For `vectors`, length of the edges of the arrow head (in inches).

- angle:

  For `vectors`, angle from the shaft of the arrow to the edge of the
  arrow head.

- pos:

  For `vectors`, position of the text label relative to the vector head.
  If `pos==NULL` (the default), labels are positioned labels outside,
  relative to arrow ends

- ...:

  other graphical parameters, such as `lty`, `xpd`, ...

## Value

None

## Details

The graphical parameters `col`, `lty` and `lwd` can be vectors of length
\> 1 and will be recycled if necessary across the rows of `x` which
define the vectors.

For use in high-level plots,
[`vecscale()`](https://friendly.github.io/candisc/reference/vecscale.md)
can be used to find a value for the `scale` argument to automatically
re-scale the vectors to approximately fill the plot region.

The option `xpd = TRUE` can be passed to `vectors()` via the `...`
argument to avoid labels being clipped.

## See also

[`graphics::arrows()`](https://rdrr.io/r/graphics/arrows.html),
[`graphics::text()`](https://rdrr.io/r/graphics/text.html),
[`graphics::segments()`](https://rdrr.io/r/graphics/segments.html)

        [rgl::lines3d()], [rgl::texts3d()]

## Author

Michael Friendly

## Examples

``` r
set.seed(1234)
plot(c(-3, 3), c(-3,3), type="n",
     xlab = "X", ylab = "Y")
X <- matrix(rnorm(10), ncol=2)
rownames(X) <- LETTERS[1:5]
vectors(X, scale=2, col=palette(), xpd = TRUE)


```
