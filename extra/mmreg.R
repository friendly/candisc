# From: http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis

# Example 1. A researcher has collected data on three psychological variables, four academic variables 
# (standardized test scores) and gender for 600 college freshman. 
# She is interested in how the set of psychological variables relates to the academic variables and gender. 
# In particular, the researcher is interested in how many dimensions (canonical variables) are necessary to 
# understand the association between the two sets of variables

library(candisc)
PsyAcad <- read.csv("https://stats.idre.ucla.edu/stat/data/mmreg.csv")

colnames(PsyAcad) <- c("Control", "Concept", "Motivation", "Read", "Write", "Math", 
                  "Science", "Sex")
summary(PsyAcad)

# variable sets
psych <- PsyAcad[, 1:3]
acad <- PsyAcad[, 4:8]



PsyAcad.can <- cancor(cbind(Control, Concept, Motivation) ~ 
                      Read + Write + Math + Science + Sex,
                    data = PsyAcad)

PsyAcad.can

redundancy(PsyAcad.can)

# coef
PsyAcad.can$coef$X |> round(3)

PsyAcad.can$coef$Y |> round(3)

# plots

# plot canonical scores
plot(PsyAcad.can, pch=16, id.n = 3)
text(-2, 3, paste("Can R =", round(PsyAcad.can$cancor[1], 3)), pos = 3)

plot(PsyAcad.can, which = 2, pch=16, id.n = 3)
text(-2, 3.5, paste("Can R =", round(PsyAcad.can$cancor[2], 3)), pos = 3)


