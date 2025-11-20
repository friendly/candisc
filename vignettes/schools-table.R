

library(knitr)
library(kableExtra)
library(gt)
schools.tab <- data.frame(
  School = c("Renaissance", "Venetian", "Lombard", "16th C", 
             "Mannerist", "Sciento", "17th C", "French"),
  Period = c("1400-1520", "1450-1600", "1490-1600", "1500-1600",
             "1520-1600", "1600-1700", "1600-1700", "1600-1750"),
  Characteristics = c(
    "Emphasis on naturalism, perspective, classical ideals; focus on balance, harmony, and proportion. Key figures: Leonardo, Michelangelo, Raphael.",
    "Rich color and light effects (overlaps Renaissance/Mannerist periods); emphasis on sensuous surfaces, atmospheric effects. e.g.: Titian, Veronese, Tintoretto.",
    "Northern Italian style; naturalism with dramatic chiaroscuro; influenced by both Renaissance ideals and Venetian colorism. e.g.: Albani, Caravaggio",
    "Late Renaissance through Mannerism; transition period showing diverse regional styles across Europe.",
    "Reaction to Renaissance harmony; elongated figures, complex compositions, artificial elegance, and emotional intensity. e.g.,: Parmigiano",
    "Likely refers to 17th century Italian schools emphasizing dramatic realism and scientific observation of nature (possibly related to Caravaggio's influence).",
    "Baroque period; dramatic use of light and shadow, movement, emotional intensity, grandeur. Includes Caravaggism and various national Baroque styles.",
    "French Baroque and emerging Rococo; emphasis on classical restraint, academic standards, royal patronage. Poussin, Claude Lorrain, later Watteau."
  )
)

# kable(schools, caption = "Chronological overview of painting schools in the MASS::painters dataset") %>%
#   column_spec(3, width = "4in")


schools.tab |>
  gt() |>
  cols_width(
    School ~ px(80),
    Period ~ px(100),
    Characteristics ~ px(400)
  ) |>
  tab_header(title = "Chronological overview of painting schools") |>
  tab_options(column_labels.font.weight = "bold")

# Defining other variables to reflect differences among schools
# 
# The variables capture:
# 
# Period - Broad historical grouping (Early/Transition/Baroque)
# Emphasis - Primary artistic focus (Form vs. Color vs. Drama)
# Style - Aesthetic approach (Classical ideals vs. Expressive intensity vs. Regional characteristics)
# Light_Treatment - How light/shadow is used (Balanced vs. Luminous colorism vs. Dramatic chiaroscuro)
# 
# These should create interesting contrasts in your discriminant analysis. You might find that certain de Piles ratings (like Colour) correlate strongly with the Color emphasis group, or that Expression ratings distinguish the Expressive style schools.

# Add categorical variables to painters dataset
library(MASS)
data(painters)

painters$Period <- factor(
  c("Early" = c("Renaissance", "Venetian", "Lombard"),
    "Transition" = c("16th C", "Mannerist"),
    "Baroque" = c("Sciento", "17th C", "French")
  )[painters$School],
  levels = c("Early", "Transition", "Baroque")
)

painters$Emphasis <- factor(
  c("Form" = c("Renaissance", "Mannerist", "16th C"),
    "Color" = c("Venetian", "Lombard", "French"),
    "Drama" = c("Sciento", "17th C")
  )[painters$School],
  levels = c("Form", "Color", "Drama")
)

painters$Style <- factor(
  c("Classical" = c("Renaissance", "French"),
    "Expressive" = c("Mannerist", "Sciento", "17th C"),
    "Regional" = c("Venetian", "Lombard", "16th C")
  )[painters$School],
  levels = c("Classical", "Expressive", "Regional")
)

painters$Light_Treatment <- factor(
  c("Balanced" = c("Renaissance", "16th C", "French"),
    "Luminous" = c("Venetian"),
    "Dramatic" = c("Mannerist", "Lombard", "Sciento", "17th C")
  )[painters$School],
  levels = c("Balanced", "Luminous", "Dramatic")
)

