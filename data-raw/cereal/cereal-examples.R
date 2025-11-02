library(dplyr)
data(cereal, package="candisc")

# names for manufacturers
mfr_names <- c(
  "A" = "American Home Foods",
  "G" = "General Mills",
  "K" = "Kellog",
  "N" = "Nabisco",
  "P" = "Post",
  "Q" = "Quaker Oats",
  "R" = "Ralston Purina"
)

# recode `mfr` as `mfr_name`
cereal <- cereal |>
  mutate(mfr_name = recode(mfr, !!!mfr_names))

library(ggplot2)

ggplot(data = cereal,
       aes(x = rating, fill = mfr, color = mfr)) +
  geom_density(alpha = 0.1) +
  theme_classic()

ggplot(data = cereal,
       aes(x = rating, fill = mfr_name, color = mfr_name)) +
  geom_density(alpha = 0.1) +
  theme_classic(base_size = 14) + 
  theme(legend.position = "bottom")



