game.outcomes <- c(-4, 0, 1, 8) # loose 4, gain 0, 1 or 8
game.probs <- c(0.32, 0.48, 0.15, 0.05)

game.cumprobs <- cumsum(game.probs)

# probability distribution
barplot(game.probs, ylim = c(0, 0.5), names.arg = game.outcomes, space = 0,
        xlab = "x", ylab = "Pr(X = x)", main = "Probabilities")

# cumulative probability distribution
barplot(game.cumprobs, names.arg = game.outcomes, space = 0,
        xlab = "x", ylab = "P(x <= x)", main = "Cumulative Probabilities")

game.expected <- sum(game.outcomes * game.probs)
game.variance <- sum((game.outcomes - game.expected)^2 * game.probs)
game.sd <- sqrt(game.variance)

cat("expected win of", game.expected, "with a standard deviation of", game.sd)

# playing the lottery (it's not worth it...)
wins <- c(6, 50, 10000, 10e6)
probs <- c(
    6/45 * 5/44 * 4/43,
    6/45 * 5/44 * 4/43 * 3/42,
    6/45 * 5/44 * 4/43 * 3/42 * 2/41,
    6/45 * 5/44 * 4/43 * 3/42 * 2/41 * 1/40
)
expectation <- sum(wins * probs) # 1.29, but a lottery ticket costs 2.00
print(expectation - 2)

w <- seq(35, 95, by = 5)
lower.w <- w >= 40 & w <= 65
upper.w <- w > 65 & w <= 90
fw <- rep(0, length(w))
fw[lower.w] <- (w[lower.w] - 40) / 625
fw[upper.w] <- (90 - w[upper.w]) / 625
#plot(w, fw, type = "l", ylab = "f(w)")
abline(h = 0, col = "gray", lty = 2)
fw.specific <- (55.2 - 40) / 625
fw.specific.area <- 0.5 * 15.2 * fw.specific
fw.specific.vertices <- rbind(c(40, 0), c(55.2, 0), c(55.2, fw.specific))
plot(w, fw, type = "l", ylab = "f(w)")
abline(h = 0, col = "gray", lty = 2)
polygon(fw.specific.vertices, col = "gray", border = NA)
abline(v = 55.2, lty = 3)
text(50, 0.005, labels = fw.specific.area)
