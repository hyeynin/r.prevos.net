## Euler Problem 4: Largest palindrome product
## https://projecteuler.net/problem=4
## https://lucidmanager.org/euler-problem-4/

library(tidyverse)

palindrome <- function(x) {
    ## Convert to character
    word <- as.character(x)
    ## Create reverse
    reverse <- paste(rev(unlist(strsplit(word, ""))), collapse = "")
    ## Check whether palindrome
    return(word == reverse)
}

for (i in 999:900) {
    for (j in 990:900) {
        p <- i * j
        if (palindrome(p)) 
            break
    }
    if (palindrome(p)) {
        break
    }
}
answer <- i * j
print(answer)

## A002113 Palindromes in base 10
p_max <- 1.5E5
A002113 <- which(lapply(1:p, palindrome) == TRUE)

data_frame(n = 1:p_max,
           p = sapply(1:p_max, function(p) length(A002113[A002113 < p]))) %>%
    ggplot(aes(n, p)) +
    geom_line(col = "#f26230", size = 1) +
    ylab("Palindromic numbers <n") +
    theme_light(base_size = 16)

ggsave("Images/problem004.png", dpi = 300, width = 8, height = 6)


