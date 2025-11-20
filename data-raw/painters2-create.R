# Script to create painters2 dataset
library(MASS)
data(painters)

# Create the extended dataset
painters2 <- painters

# Add Period variable - broad historical grouping
school_to_period <- c(
  "Renaissance" = "Early",
  "Venetian" = "Early", 
  "Lombard" = "Early",
  "16th C" = "Transition",
  "Mannerist" = "Transition",
  "Sciento" = "Baroque",
  "17th C" = "Baroque",
  "French" = "Baroque"
)

painters2$Period <- factor(
  school_to_period[as.character(painters2$School)],
  levels = c("Early", "Transition", "Baroque")
)

# Add Emphasis variable - primary artistic focus
school_to_emphasis <- c(
  "Renaissance" = "Form",
  "Mannerist" = "Form",
  "16th C" = "Form",
  "Venetian" = "Color",
  "Lombard" = "Color",
  "French" = "Color",
  "Sciento" = "Drama",
  "17th C" = "Drama"
)

painters2$Emphasis <- factor(
  school_to_emphasis[as.character(painters2$School)],
  levels = c("Form", "Color", "Drama")
)

# Add Style variable - aesthetic approach
school_to_style <- c(
  "Renaissance" = "Classical",
  "French" = "Classical",
  "Mannerist" = "Expressive",
  "Sciento" = "Expressive",
  "17th C" = "Expressive",
  "Venetian" = "Regional",
  "Lombard" = "Regional",
  "16th C" = "Regional"
)

painters2$Style <- factor(
  school_to_style[as.character(painters2$School)],
  levels = c("Classical", "Expressive", "Regional")
)

# Add Light variable - treatment of light and shadow
school_to_light <- c(
  "Renaissance" = "Balanced",
  "16th C" = "Balanced",
  "French" = "Balanced",
  "Venetian" = "Luminous",
  "Mannerist" = "Dramatic",
  "Lombard" = "Dramatic",
  "Sciento" = "Dramatic",
  "17th C" = "Dramatic"
)

painters2$Light <- factor(
  school_to_light[as.character(painters2$School)],
  levels = c("Balanced", "Luminous", "Dramatic")
)

# Verify the structure
str(painters2)

# Show cross-tabulations
cat("\n=== School by Period ===\n")
print(table(painters2$School, painters2$Period))

cat("\n=== School by Emphasis ===\n")
print(table(painters2$School, painters2$Emphasis))

cat("\n=== School by Style ===\n")
print(table(painters2$School, painters2$Style))

cat("\n=== School by Light ===\n")
print(table(painters2$School, painters2$Light))

# Save the dataset for inclusion in the candisc package
# usethis::use_data(painters2, overwrite = TRUE)