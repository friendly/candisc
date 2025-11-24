context("classif.matrix")

data(centaurea)
centaurea = suppressWarnings(naMeanSubst(centaurea))
centaurea = removePopulation(centaurea, populationName = c("LIP", "PREL"))

trainingSet = removePopulation(centaurea, populationName = "SOK")
SOK = keepPopulation(centaurea, populationName = "SOK")


test_that("correct input", {
  
  c = suppressWarnings(classif.lda(centaurea))
  
  expect_error(classif.matrix(c, level = "ds"), "Invalid level of grouping. Consider using \"taxon\", \"pop\" or \"indiv\"")
})


test_that("classif.lda",  {
  c = suppressWarnings(classif.lda(centaurea))
  
  m = classif.matrix(c, level = "taxon")
  expect_equal(paste(colnames(m), collapse = ","), "Taxon,N,as.hybr,as.ph,as.ps,as.st,correct,correct[%]")
  expect_equal(paste(rownames(m), collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1], collapse = ","), "hybr,ph,ps,st,Total")

  m = classif.matrix(c, level = "pop")
  expect_equal(paste(colnames(m), collapse = ","), "Population,Taxon,N,as.hybr,as.ph,as.ps,as.st,correct,correct[%]")
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "BABL,BABU,BOL,BRT,BUK")
  expect_equal(paste(m[,1][30:32], collapse = ","), "VIT,VOL,Total")

  m = classif.matrix(c, level = "indiv")
  expect_equal(paste(colnames(m), collapse = ","), "ID,Population,Taxon,classification,as.hybr,as.ph,as.ps,as.st,correct")
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "RTE1,RTE2,RTE3,RTE4,RTE5" )
  expect_equal(m[,1][612], "KOT2295")

})

test_that("classif.knn",  {
  c = suppressWarnings(classif.knn(centaurea, k = 6))
  
  m = classif.matrix(c, level = "taxon")
  expect_equal(paste(colnames(m), collapse = ","), "Taxon,N,as.hybr,as.ph,as.ps,as.st,correct,correct[%]")
  expect_equal(paste(rownames(m), collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1], collapse = ","), "hybr,ph,ps,st,Total")

  m = classif.matrix(c, level = "pop")
  expect_equal(paste(colnames(m), collapse = ","), "Population,Taxon,N,as.hybr,as.ph,as.ps,as.st,correct,correct[%]")
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "BABL,BABU,BOL,BRT,BUK" )
  expect_equal(paste(m[,1][30:32], collapse = ","), "VIT,VOL,Total")

  m = classif.matrix(c, level = "indiv")
  expect_equal(paste(colnames(m), collapse = ","), "ID,Population,Taxon,classification,Proportion.of.the.votes.for.the.winning.class,correct")
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "RTE1,RTE2,RTE3,RTE4,RTE5" )
  expect_equal(paste(m[,1][612], collapse = ","), "KOT2295")

})

test_that("classifSamp.lda",  {
  c = suppressWarnings(classifSample.lda(SOK, trainingSet))
  
  m = classif.matrix(c, level = "taxon")
  expect_equal(paste(colnames(m), collapse = ","), "Taxon,N,as.hybr,as.ph,as.ps,as.st")
  expect_equal(paste(rownames(m), collapse = ","), "1,2")
  expect_equal(paste(m[,1], collapse = ","), "ps,Total")

  m = classif.matrix(c, level = "pop")
  expect_equal(paste(colnames(m), collapse = ","), "Population,Taxon,N,as.hybr,as.ph,as.ps,as.st")
  expect_equal(paste(rownames(m), collapse = ","), "1,2")
  expect_equal(paste(m[,1], collapse = ","), "SOK,Total" )

  m = classif.matrix(c, level = "indiv")
  expect_equal(paste(colnames(m), collapse = ","), "ID,Population,Taxon,classification,as.hybr,as.ph,as.ps,as.st"  )
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "SOK388,SOK389,SOK390,SOK391,SOK392")

})

test_that("classifSamp.knn",  {
  c = suppressWarnings(classifSample.knn(SOK, trainingSet, k = 1))
  
  m = classif.matrix(c, level = "taxon")
  expect_equal(paste(colnames(m), collapse = ","), "Taxon,N,as.hybr,as.ph,as.ps,as.st")
  expect_equal(paste(rownames(m), collapse = ","), "1,2")
  expect_equal(paste(m[,1], collapse = ","), "ps,Total")

  m = classif.matrix(c, level = "pop")
  expect_equal(paste(colnames(m), collapse = ","), "Population,Taxon,N,as.hybr,as.ph,as.ps,as.st" )
  expect_equal(paste(rownames(m), collapse = ","), "1,2")
  expect_equal(paste(m[,1], collapse = ","), "SOK,Total" )

  m = classif.matrix(c, level = "indiv")
  expect_equal(paste(colnames(m), collapse = ","), "ID,Population,Taxon,classification,Proportion.of.the.votes.for.the.winning.class"  )
  expect_equal(paste(rownames(m)[1:5], collapse = ","), "1,2,3,4,5")
  expect_equal(paste(m[,1][1:5], collapse = ","), "SOK388,SOK389,SOK390,SOK391,SOK392")

})
