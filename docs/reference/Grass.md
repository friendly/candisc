# Yields from Nitrogen nutrition of grass species

The data frame `Grass` gives the yield (10 \* log10 dry-weight (g)) of
eight grass Species in five replicates (Block) grown in sand culture at
five levels of nitrogen.

## Format

A data frame with 40 observations on the following 7 variables.

- `Species`:

  a factor with levels `B.media` `D.glomerata` `F.ovina` `F.rubra`
  `H.pubesens` `K.cristata` `L.perenne` `P.bertolonii`

- `Block`:

  a factor with levels `1` `2` `3` `4` `5`

- `N1`:

  species yield at 1 ppm Nitrogen

- `N9`:

  species yield at 9 ppm Nitrogen

- `N27`:

  species yield at 27 ppm Nitrogen

- `N81`:

  species yield at 81 ppm Nitrogen

- `N243`:

  species yield at 243 ppm Nitrogen

## Source

Gittins, R. (1985), Canonical Analysis: A Review with Applications in
Ecology, Berlin: Springer-Verlag, Table A-5.

## Details

Nitrogen (NaNO3) levels were chosen to vary from what was expected to be
from critically low to almost toxic. The amount of Nitrogen can be
considered on a log3 scale, with levels 0, 2, 3, 4, 5. Gittins (1985,
Ch. 11) treats these as equally spaced for the purpose of testing
polynomial trends in Nitrogen level.

The data are also not truly multivariate, but rather a split-plot
experimental design. For the purpose of exposition, he regards Species
as the experimental unit, so that correlations among the responses refer
to a composite representative of a species rather than to an individual
exemplar.

## Examples

``` r
str(Grass)
#> 'data.frame':    40 obs. of  7 variables:
#>  $ Species: Factor w/ 8 levels "B.media","D.glomerata",..: 7 7 7 7 7 2 2 2 2 2 ...
#>  $ Block  : Factor w/ 5 levels "1","2","3","4",..: 1 2 3 4 5 1 2 3 4 5 ...
#>  $ N1     : num  1.013 0.945 1.045 0.987 0.826 ...
#>  $ N9     : num  1.71 1.58 1.48 1.46 1.34 ...
#>  $ N27    : num  1.64 1.53 1.62 1.55 1.49 ...
#>  $ N81    : num  2.08 2.07 1.73 2.07 1.89 ...
#>  $ N243   : num  1.96 2.12 2.09 2.21 1.95 ...
grass.mod <- lm(cbind(N1,N9,N27,N81,N243) ~ Block + Species, data=Grass)
car::Anova(grass.mod)
#> 
#> Type II MANOVA Tests: Pillai test statistic
#>         Df test stat approx F num Df den Df   Pr(>F)    
#> Block    4   0.90834   1.5865     20    108  0.06902 .  
#> Species  7   2.03696   2.7498     35    140 1.49e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

grass.canL <-candiscList(grass.mod)
names(grass.canL)
#> [1] "Block"   "Species"
names(grass.canL$Species)
#>  [1] "dfh"         "dfe"         "eigenvalues" "canrsq"      "pct"        
#>  [6] "rank"        "ndim"        "means"       "factors"     "term"       
#> [11] "terms"       "coeffs.raw"  "coeffs.std"  "structure"   "scores"     

```
