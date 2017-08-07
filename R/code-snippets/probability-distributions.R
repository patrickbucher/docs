# throw a die 6 times
# calculate probabilities of getting 0..6 times a specific value
dist <- dbinom(x = 0:6, size = 6, prob = 1/6)
round(dist, digits = 3)
sum(dist) # 1, of course
barplot(dist)
