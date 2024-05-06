## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(warning=FALSE, message=FALSE, collapse=TRUE, R.options=list(digits=4))

## ----setup--------------------------------------------------------------------
library(heplots)
library(candisc)
library(car)

## -----------------------------------------------------------------------------
data(Diabetes, package="heplots")
str(Diabetes)

## ----covEllipse, fig.height=5, fig.width=5------------------------------------
covEllipses(Diabetes[,2:5], Diabetes$group, fill=TRUE, pooled=FALSE, 
	col=c("blue", "red", "darkgreen"), variables=1:3)

## ----scatter, fig.width=6, fig.height=5, echo=-1------------------------------
op <- par(mar=c(4,4,0,1)+.5)
scatterplot( instest ~ glutest | group, data=Diabetes, 
             pch=c(16,15,17), 
             col=c("blue", "red", "darkgreen"),
             smooth=FALSE, 
             grid=FALSE, 
             legend=list(coords="topright"), 
             lwd=2,
             ellipse=list(levels=0.5))

## ----scatter3d, eval=FALSE----------------------------------------------------
#  scatter3d(sspg ~ glutest + instest | group, data=Diabetes,
#            surface=FALSE,	sphere.size=1.5, ellipsoid=TRUE,
#            surface.col=c("blue", "red", "darkgreen"))

## ----boxm, fig.width=7, fig.height=3------------------------------------------
diab.boxm <- boxM(Diabetes[,2:5], Diabetes$group)
diab.boxm

op <- par(mar=c(4,6,1,1)+.5)
plot(diab.boxm, cex.lab=1.5)

## ----diab-mlm-----------------------------------------------------------------
diab.mlm <- lm(cbind(glufast, glutest, instest, sspg) ~ group, data=Diabetes)
Anova(diab.mlm)

## ----cqplot, fig.width=6, fig.height=5----------------------------------------
cqplot(diab.mlm)

## ----he1, fig.width=6, fig.height=5, echo=-1----------------------------------
op <- par(mar=c(4,4,1,1)+.5)
heplot(diab.mlm, fill=TRUE, fill.alpha=0.1)

## ----he2, fig.width=5, fig.height=5-------------------------------------------
pairs(diab.mlm, fill=TRUE, fill.alpha=0.1)

## ----diab-can-----------------------------------------------------------------
diab.can <- candisc(diab.mlm)
diab.can

## ----diab-can-plot, fig.width=6, fig.height=4, echo=-1------------------------
op <- par(mar=c(4,4,0,1)+.5)
plot(diab.can, ellipse=TRUE, var.lwd=2)

## ----diab-heplot, , fig.width=6, fig.height=4, echo=-1------------------------
op <- par(mar=c(4,4,0,1)+.5)
heplot(diab.can, fill=c(TRUE, FALSE), fill.alpha=0.1, var.lwd=2)

## ----diab-lda-----------------------------------------------------------------
library(MASS)
diab.lda <- lda(group ~ glufast + glutest + instest + sspg, data = Diabetes)
diab.lda

## ----rpart--------------------------------------------------------------------
library(rpart)
diab.part <- rpart(group ~ glufast + glutest + instest + sspg, data=Diabetes)
diab.part

## ----rpart-plot, eval=FALSE---------------------------------------------------
#  library(rpart.plot)
#  rpart.plot(diab.part, box.palette=list("Blues", "Reds",  "Greens"))

## -----------------------------------------------------------------------------
(class.pred <- table(predicted=predict(diab.part, type="class"), actual=Diabetes$group))

# error rate
1 - sum(diag(class.pred))/sum(class.pred)

