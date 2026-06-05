# Painters Data with Historical Art Variables

The original [`painters`](https://rdrr.io/pkg/MASS/man/painters.html)
dataset from the MASS package contains the subjective assessment, on a 0
to 20 integer scale, of 54 classical painters. The painters were rated
on four characteristics: Composition, Drawing, Colour and Expression,
and grouped according to "School" based on nationality, era, and style.
The data is due to the Eighteenth century art critic, Roger de Piles
(1743).

This extended version adds categorical variables that capture art
historical distinctions among schools of painting based on their
chronological period, artistic emphasis, style, and treatment of light.

## Usage

``` r
data(painters2)
```

## Format

A data frame with 54 observations on 10 variables:

- Composition:

  Composition score (0-20) assigned by de Piles

- Drawing:

  Drawing score (0-20) assigned by de Piles

- Colour:

  Colour score (0-20) assigned by de Piles

- Expression:

  Expression score (0-20) assigned by de Piles

- School:

  School of painter: "Renaissance", "Mannerist", "Sciento", "Venetian",
  "Lombard", "16th C", "17th C", "French"

- Sch:

  Letter code for School of painter: "A" through "H"

- Period:

  An ordered factor. Historical period: "Early" (1400-1520: Renaissance,
  Venetian, Lombard), "Transition" (1500-1600: 16th C, Mannerist),
  "Baroque" (1600-1750: Sciento, 17th C, French)

- Emphasis:

  A factor. Primary artistic focus: "Form" (emphasis on drawing,
  composition, classical ideals), "Color" (emphasis on color and light
  effects), "Drama" (emphasis on dramatic realism and emotional
  intensity)

- Style:

  A factor. Aesthetic approach: "Classical" (balanced, harmonious,
  adherence to classical ideals), "Expressive" (emotional intensity,
  dramatic effects), "Regional" (distinctive regional characteristics)

- Light:

  A factor. Treatment of light and shadow: "Balanced" (even, harmonious
  lighting), "Luminous" (rich color and atmospheric light effects),
  "Dramatic" (strong chiaroscuro, dramatic contrasts)

## Source

Venables, W. N. and Ripley, B. D. (2002) *Modern Applied Statistics with
S*. Fourth edition. Springer.

## Details

Names of the painters are given as `rownames(painters2)`.

The original version
[`painters`](https://rdrr.io/pkg/MASS/man/painters.html) used letters,
"A" through "H" to identify the schools of painters. This is kept here
as the variable `Sch`, and the variable `School` now gives the actual
label of the school.

The four new categorical variables (Period, Emphasis, Style, Light) were
constructed to reflect art historical distinctions among the schools:

- **Period** groups schools by broad historical era

- **Emphasis** captures the primary artistic focus of each school

- **Style** reflects the aesthetic approach and philosophical
  orientation

- **Light** distinguishes approaches to light and shadow treatment

These variables can be useful for exploring how art historical
categories relate to de Piles' quantitative ratings, and for
demonstrating MANOVA and multivariate discriminant analysis techniques.

## References

De Piles, R. (1743). The Principles of Painting. London, n.p.

## See also

[`painters`](https://rdrr.io/pkg/MASS/man/painters.html)

## Examples

``` r
data(painters2)

# Compare original School with new Period grouping
with(painters2, table(School, Period))
#>              Period
#> School        Early Transition Baroque
#>   Renaissance    10          0       0
#>   Mannerist       0          6       0
#>   Sciento         0          0       6
#>   Venetian       10          0       0
#>   Lombard         7          0       0
#>   16th C          0          4       0
#>   17th C          0          0       7
#>   French          0          0       4

# Compare original School with new Period grouping
with(painters2, table(School, Emphasis))
#>              Emphasis
#> School        Form Color Drama
#>   Renaissance   10     0     0
#>   Mannerist      6     0     0
#>   Sciento        0     0     6
#>   Venetian       0    10     0
#>   Lombard        0     7     0
#>   16th C         4     0     0
#>   17th C         0     0     7
#>   French         0     4     0

# Summary of de Piles ratings by Period
aggregate(cbind(Composition, Drawing, Colour, Expression) ~ Period,
          data = painters2, FUN = mean)
#>       Period Composition  Drawing   Colour Expression
#> 1      Early    10.74074 12.44444 12.37037   6.333333
#> 2 Transition    10.20000 12.70000  8.20000   8.000000
#> 3    Baroque    13.64706 12.35294 10.29412   9.588235
```
