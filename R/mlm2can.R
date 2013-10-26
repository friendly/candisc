# transform an mlm to an equivalent canonical representation???
# Q: this seems wrong -- should have only term as RHS of the canonical model

mlm2can <- function(mod, term, ...) {
	require(candisc)
	can <- candisc(mod, term, ...)
#	term <- mod$term                        # term for which candisc was done
	lm.terms <- can$terms                   # terms in original lm
	scores <- can$scores
	resp <- if (can$rank==1) "Can1" else
	        paste("cbind(", paste("Can",1:can$rank,sep="", collapse = ","), ")")
	terms <- paste( lm.terms, collapse = "+")
  txt <- paste( "lm(", resp, " ~ ", terms, ", data=scores)" )
  can.mod <- eval(parse(text=txt))
#  can.mod <- lm(as.formula(paste(resp, " ~ ", terms)), data=scores)
	can.mod
}


library(effects)
data(NLSY, package="heplots")
mod <- lm(cbind(read,math) ~ income+educ, data=NLSY)

Anova(mod)
mc1 <- mlm2can(mod, "income")
Anova(mc1)
eff.mc1 <- allEffects(mc1)
plot(eff.mc1, ci.style='bands')

mc2 <- mlm2can(mod, "educ")
Anova(mc2)
eff.mc2 <- allEffects(mc2)
plot(eff.mc2, ci.style='bands')
