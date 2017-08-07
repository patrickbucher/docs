# simple bar plot of a table (cylinders)
cylinders <- table(mtcars$cyl)
barplot(cylinders, xlab = "number of cylinders", ylab = "occurences")

# comparing cylinders by automatic and manual transmissions
cylinders <- table(mtcars$am, mtcars$cyl)
barplot(cylinders, beside = TRUE, horiz = TRUE, las = 1,
        main = "Car counts by transmission and cylinders",
        names.arg = c("V4", "V6", "V8"),
        legend.text = c("auto", "manual"),
        args.legend = list(x = "bottomright"))

pie(table(mtcars$cyl), labels = c("V4", "V6", "V8"),
    col = c("white", "gray", "black"),
    main = "Cars by cylinders")


###################################
# Extended Chicken Weight Example #
###################################

svg(filename = "plot.svg", width = 10, height = 10)

# calculate the bars
weightsByFeed <- split(chickwts$weight, chickwts$feed)
mins <- lapply(weightsByFeed, FUN = min)
maxs <- lapply(weightsByFeed, FUN = max)
means <- lapply(weightsByFeed, FUN = mean)
medians <- lapply(weightsByFeed, FUN = median)

# build the matrix
v <- as.numeric(rbind(mins, maxs, means, medians))
m <- matrix(v, ncol = 4, byrow = TRUE)
dimnames(m) <- list(levels(chickwts$feed))

# build the plot
legend <- c("min", "max", "mean", "median")
main <- "Chicken Weight by Feed"
barplot(t(m), beside = TRUE, main = main, ylim = c(0,500), las = 2, 
        legend = legend, args.legend = list(x = "top"))

dev.off()

# dice rolls
pie(table(sample(1:6, replace = TRUE, size = 100)))

# Titanic: survived vs killed
survival <- apply(Titanic, c(4), sum)
class(survival)
labels <- c(paste(survival[1], "killed"),
            paste(survival[2], "survived"))
pie(survival, main = "Survival on Titanic", labels = labels)

hist(mtcars$hp, breaks = seq(0, 400, 25), main = "Horsepower", xlab = "Horsepower")
abline(v = c(mean(mtcars$hp), median(mtcars$hp)), lty = c(2, 3), lwd = 2)
legend("topright", legend = c("mean", "median"), lty = c(2, 3), lwd = 2)

hist(chickwts$weight, breaks = "Sturges") # break by algorithm

fac <- cut(chickwts$weight, breaks = c(0,100,200,300,400))
boxplot(chickwts$weight ~ fac) # tilde notation

fac <- cut(mtcars$hp, breaks = seq(0, 400, 100))
boxplot(mtcars$hp~fac)

# gas guzzler example
plot(x = c(), type = "n", xlab = "Weight (tons)", ylab = "Miles per Gallon",
     xlim = c(1, 6), ylim = c(10, 40))

low = mtcars$hp < 100
med = mtcars$hp >= 100 & mtcars$hp < 200
high = mtcars$hp >= 200 & mtcars$hp < 300
huge = mtcars$hp >= 300 & mtcars$hp < 400


points(mtcars$wt[low], mtcars$mpg[low], col = 1, pch = 1)
points(mtcars$wt[med], mtcars$mpg[med], col = 2, pch = 2)
points(mtcars$wt[high], mtcars$mpg[high], col = 3, pch = 3)
points(mtcars$wt[huge], mtcars$mpg[huge], col = 4, pch = 4)

labels <- c("low", "medium", "high", "ultra")
legend("bottomleft", legend = labels, col = 1:4, pch = 1:4, title = "Horsepower")

cor(mtcars$wt, mtcars$mpg) # negative correlation :-)

# Exercise 14.1

# a
hist(InsectSprays$count, xlab = "Number of Insects", main = "Insect Sprays")

# b
t <- tapply(InsectSprays$count, InsectSprays$spray, sum)
barplot(t, xlab = "Spray", ylab = "Insects", main = "Insect Sprays")
pie(t, main = "Insect Sprays")

# etc...
