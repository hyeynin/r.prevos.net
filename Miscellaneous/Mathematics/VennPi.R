library(tidyverse)

# Rmpfr
# Multiple-precision floating-point computations with correct rounding.library(Rmpfr)
pi_mpfr <- Const("pi", prec = 20000)

# Monte Carlo - Buffon
t <- 2
l <- 1
n <- 10000000

needles <- data_frame(phi = runif(n, 0, 2 * pi),
           x1 = runif(n, 0, (l + 3)), 
           y1 = runif(n, 0, (l + 3)),
           x2 = x1 + l * sin(phi),
           y2 = y1 + l * cos(phi), 
           overlap = (x1 < 1 & x2 > 1) | (x1 < 3 & x2 > 3))

ggplot(needles[1:1000,], aes(x1, y1)) + 
  geom_segment(aes(xend = x2, yend = y2, colour = overlap)) + 
  geom_vline(xintercept = c(1, 3), colour = "red") +
  scale_color_manual(values = c("gray", "black")) + 
  theme_void() 
ggsave("Misc/buffon.png", dpi = 300)

pi_buffon <- (n * l) / (sum(needles$overlap) * t)

# Download Pi Digits
pi_digits <- read.csv("http://oeis.org/A000796/b000796.txt", header = FALSE, sep = " ", skip = 1) %>%
  select(digit = V2)

# Venn walk
venn_walk <- function(digits) {
  digits <- digits[digits != 8 & digits != 9]
  l <- length(digits) - 1
  x <- rep(0, l)
  y <- x
  for (i in 1:l) {
    a <- digits[i + 1] * pi / 4
    dx <- round(sin(a))
    dy <- round(cos(a))
    x[i + 1] <- x[i] + dx 
    y[i + 1] <- y[i] + dy
  }
  coords <- data_frame(x = x, y = y)
  ggplot(coords, aes(x, y)) + 
    geom_path() + 
    geom_point(data = coords[c(1, l + 1), ], aes(x, y), colour = "red", size = 2) + 
    theme_void()
}
venn_walk(pi_digits)
ggsave("Misc/venn_pi_walk.png", dpi = 300)

data_frame(x = rep(1:20, 20),
           y = unlist(lapply(1:20, function(x) rep(x, 20))),
           d = pi_digits$digit[1:400]) %>%
  mutate(d = factor(d)) %>%
  ggplot(aes(x, y, colour = d)) + geom_point(size = 3) +
  theme_void() + 
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"),
        legend.position="none")
ggsave("Misc/pi_dots.png")

