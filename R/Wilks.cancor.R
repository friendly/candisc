Wilks <- function (object, ...) {
	UseMethod("Wilks")
}

Wilks.cancor <- function(object, ...) {
# tests of canonical dimensions

if (!inherits(object, "cancor")) stop("Not a cancor object")

ev <- (1 - object$cancor^2)

n <- object$dim$n
p <- object$dim$p
q <- object$dim$q
k <- min(p, q)
m <- n - 3/2 - (p + q)/2

w <- rev(cumprod(rev(ev)))

# initialize
df1 <- df2 <- Fstat <- vector("numeric", k)

for (i in 1:k) {
    s <- sqrt((p^2 * q^2 - 4)/(p^2 + q^2 - 5))
    si <- 1/s
    df1[i] <- p * q
    df2[i] <- m * s - p * q/2 + 1
    r <- (1 - w[i]^si)/w[i]^si
    Fstat[i] <- r * df2[i]/df1[i]
    p <- p - 1
    q <- q - 1
}

pv <- pf(Fstat, df1, df2, lower.tail = FALSE)
tests <- cbind(CanR=object$cancor, w, Fstat, df1, df2, pv)
colnames(tests) <- c("CanR", "LR test stat", "approx F", "numDF", "denDF", "Pr(> F)")

tests <- structure(as.data.frame(tests), 
heading = paste("\nTest of H0: The canonical correlations in the",
                "\ncurrent row and all that follow are zero\n") , 
    class = c("anova", "data.frame"))
tests
}

# Rao's F approximation for canonical discriminant analysis
# using code from Martina Vandebroek <martina.vandebroek@kuleuven.be>

Wilks.candisc <- function(object, ...) {
  
  ev <- object$eigenvalues
  
  n <- nrow(object$scores)
  g <- object$dfh + 1
  p <- nrow(object$coeffs.std)
  rank <- object$rank
  r <- 1:rank           # vectorize calculation, for r=1, ... rank  
  
  LR <- rep(0, rank)
  for (i in seq(r)) {
    LR[i] <- prod(1/(1 + ev[i:rank]))
  }
  
  # numerator df for each test
  df1 <- (p-r+1)*(g-r)	
  nu = sqrt(  ( (p-r+1)^2*(g-r)^2 - 4 )  /  ( (p-r+1)^2+(g-r)^2 - 5)  )
  # demominator df
  df2 = nu * (n-(p+g+2)/2) - (p-r+1)*(g-r)/2 + 1
  Lnu <- LR^(1/nu)
  F <- (1-Lnu)*df2/(Lnu*df1)
  
  pv <- pf(F, df1, df2, lower.tail = FALSE)
  tests <- cbind(LR, F, df1, round(df2, digits=2), pv)
  colnames(tests) <- c("LR test stat", "approx F", "numDF", "denDF", "Pr(> F)")
  tests <- structure(as.data.frame(tests), 
                     heading = paste("\nTest of H0: The canonical correlations in the",
                                     "\ncurrent row and all that follow are zero\n") , 
                     class = c("anova", "data.frame"))
  tests
}

# Wilks.candisc <- function(object, ...) {
# # tests of canonical dimensions
# 
# 	ev <- object$eigenvalues
# 	
# 	n <- nrow(object$scores)
# 	p <- object$dfh
# 	q <- nrow(object$coeffs.std)
# 	k <- min(p, q)
# 	m <- n - 3/2 - (p + q)/2
# 	
# 	w <- rev(cumprod(rev(ev)))
# #	WL <- 
# #	browser()
# 	# initialize
# 	df1 <- df2 <- Fstat <- vector("numeric", k)
# 	
# 	for (i in 1:k) {
# 	    s <- sqrt((p^2 * q^2 - 4)/(p^2 + q^2 - 5))
# 	    si <- 1/s
# 	    df1[i] <- p * q
# 	    df2[i] <- m * s - p * q/2 + 1
# 	    r <- (1 - w[i]^si)/w[i]^si
# 	    Fstat[i] <- r * df2[i]/df1[i]
# 	    p <- p - 1
# 	    q <- q - 1
# 	}
# 	
# 	pv <- pf(Fstat, df1, df2, lower.tail = FALSE)
# 	tests <- cbind(WilksL = w, F = Fstat, df1 = df1, df2 = df2, p.value = pv)
# 	tests <- structure(as.data.frame(tests), 
# 			heading = paste("\nTest of H0: The canonical correlations in the",
# 			                "\ncurrent row and all that follow are zero\n") , 
# 	    class = c("anova", "data.frame"))
# 	tests
# }
# 



