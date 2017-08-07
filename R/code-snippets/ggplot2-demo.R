x <- 1:20
y <- c(-1.49,3.37,2.59,-2.78,-3.94,-0.92,6.43,8.51,3.41,-8.23, -12.01,-6.58,
       2.87,14.12,9.63,-4.58,-14.78,-11.67,1.17,15.62)

ptype <- rep(NA, length(x = x))

ptype[y >= 5] <- "too_big"
ptype[y <= -5] <- "too_small"
ptype[(x >= 5 & x <= 15) & (y > -5 & y < 5)] <- "sweet"
ptype[(x < 5 | x > 15) & (y > -5 & y < 5)] <- "standard"

ptype <- factor(x = ptype)

qplot(x, y, color = ptype, shape = ptype) + geom_point(size = 5) +
  geom_line(mapping = aes(group = 1), color = "black", lty = 2) +
  geom_hline(mapping = aes(yintercept = c(-5, 5)), color = "red") + 
  geom_segment(mapping = aes(x = 5, y = -5, xend = 5, yend = 5), color = "red", lty = 3) +
  geom_segment(mapping = aes(x = 15, y = -5, xend = 15, yend = 5), color = "red", lty = 3)