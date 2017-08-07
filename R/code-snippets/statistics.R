# calculates the mode of the given vector
# returns the most common value(s) and the number of its occurences
mode <- function(v) {
    t <- table(v)
    m <- t[t == max(t)]
    return(as.numeric(names(m)))
}


data <- c(1,1,1,2,2,3,3,3,3,4,4,4,4,5,5,6,7,8,8,9)

mean(data) # 4.15 (sum of divided by number of values)
median(data) # 4 (the value in the middle, or their mean, if there are two)
mode(data) # 3 4 (the most common value(s))

for (food in levels(chickwts$feed)) {
    mw <- mean(chickwts[chickwts$feed == food,]$weight)
    cat(food, "\t", round(mw, digits = 1), "\n")
}

t <- table(InsectSprays$count)
t
m <- t[t == max(t)]
m
as.numeric(names(m))

for (spray in levels(InsectSprays$spray)) {
    all <- InsectSprays$count[InsectSprays$spray == spray]
    good <- all[all >= 5]
    p = length(good) / length(all)
    p <- round(p * 100, digits = 1)
    cat(spray, "\t", p, "\n")
}

tapply(X = InsectSprays$count, INDEX = InsectSprays$spray, FUN = function(x) {
    p <- length(x[x >= 5]) / length(x)
    p <- round(p * 100, digits = 1)
    return(p)
})

# 100 random numbers from 1 to 10
s <- sample(x = 1:10, replace = TRUE, size = 100) 
quantile(s) # default quantiles: 0%, 25%, 50%, 75% and 100%
quantile(s, prob = c(0, 0.5, 1)) # just 0%, 50% and 100%
quantile(s, prob = seq(from = 0, to = 1, by = 0.1)) # 0%, 10% etcetera

summary(sample(x = 1:10, replace = TRUE, size = 100))

xdata <- c(2, 4.4, 3, 3, 2, 2.2, 2, 4)
ydata <- c(1, 4.4, 1, 3, 2, 2.2, 2, 7)

plot(xdata, type = "n", xlab ="", ylab="data vector", yaxt ="n", bty="n")
abline(h=c(3, 3.5), lty = 2, col = "gray")
abline(v = 2.8, lwd = 2, lty = 3)
text(c(0.8, 0.8), c(3, 3.5), labels = c("x", "y"))
points(jitter(c(xdata, ydata)), c(rep(3, length(xdata)), rep(3.5, length(ydata))))

# Exercise 13.3

# a)
a <- sort(tapply(X = chickwts$weight, INDEX = chickwts$feed, FUN = var))
names(a[length(a)])

# b)

# i.
IQR(quakes$depth)

# ii.
summary(quakes$mag[quakes$depth >= 400])
summary(quakes$mag[quakes$depth < 400])

# iii.
breaks <- c(40, 200, 360, 520, 680)
depthcat <- cut(x = quakes$depth, breaks = breaks, right = FALSE)
levels(depthcat)

# iv.
lapply(X = split(quakes$depth, depthcat), FUN = mean)

# v.
lapply(X = split(quakes$depth, depthcat), FUN = function(x) quantile(x, 0.8))

height <- c(170, 168, 181, 188, 195, 182, 157, 175, 177, 183)
weight <- c(82, 67, 95, 112, 100, 82, 63, 90, 67, 75)
plot(height, weight)
cov(height, weight)
cor(height, weight)

# Exercise 13.4

# b

# ii.
plot(mtcars$hp, mtcars$qsec)
cor(mtcars$hp, mtcars$qsec)

# iii.
tranfac <- factor(x = mtcars$am, levels = c(0, 1), labels = c("Manual", "Automatic"))

# iv.
groups <- split(x = mtcars, f = tranfac)
plot(x = groups$`0`$hp, y = groups$`0`$qsec, col = "red", xlab = "Power (HP)", ylab = "1/4 Mile Time (sec)")
points(x = groups$`1`$hp, y = groups$`1`$qsec, col = "blue")
legend(x = "topright", title = "Shifting", legend = c("automatic", "manual"), fill = c("red", "blue"))
cor(groups$`0`$hp, groups$`0`$qsec)
cor(groups$`1`$hp, groups$`1`$qsec)

# c

# i.
otherWeight <- sort(chickwts$weight[chickwts$feed != "sunflower"])
sunflowerWeight <- sort(chickwts$weight[chickwts$feed == "sunflower"])
plot(c(), axes = FALSE, type = n, xlim = c(100, 400), ylim = c(0,0))
axis(1, at = otherWeight, col = "red", labels = FALSE, pos = 0)
axis(1, at = sunflowerWeight, col = "blue", labels = FALSE, pos = 1)
legend(legend = c("Sunflower", "Other"), fill = c("blue", "red"), title = "Food", x = "bottomleft")
summary(otherWeight)
summary(sunflowerWeight)
