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
tests <- cbind(CanR=object$cancor, WilksL = w, F = Fstat, df1 = df1, df2 = df2, p.value = pv)

tests <- structure(as.data.frame(tests), 
heading = paste("\nTest of H0: The canonical correlations in the",
                "\ncurrent row and all that follow are zero\n") , 
    class = c("anova", "data.frame"))
tests
}

#print.candisc <- function( x, digits=max(getOption("digits") - 2, 3), ...) {
#	table <- canrsqTable(x)
#    cat(paste("\nCanonical Discriminant Analysis for ", x$term, ":\n\n", sep=""))
#    print(table, digits=digits,na.print = "")
#
#	rank <- x$rank
#    eigs <- x$eigenvalues[1:rank]
#    tests <- seqWilks(eigs, rank, x$dfh, x$dfe)
#    tests <- structure(as.data.frame(tests), 
#    heading = paste("\nTest of H0: The canonical correlations in the",
#                        "\ncurrent row and all that follow are zero\n") , 
#        class = c("anova", "data.frame"))
#    print(tests)
#    invisible(x)      
#}


