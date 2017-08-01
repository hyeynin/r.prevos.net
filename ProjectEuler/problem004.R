# Problem 4: Largest Palindromic Product
# https://projecteuler.net/problem=4
# Find the largest palindrome made from the product of two 3-digit numbers

# http://r.prevos.net/euler-problem-4/


# Function to check for palindromic number
palindrome <- function(x) {
    # Convert to character
    word <- as.character(x)
    # Create reverse
    reverse <- paste(rev(unlist(strsplit(word, ""))), collapse = "")
    # Check whether palindrome
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

# Count palindromes
pals <- data.frame(x = NA, y = NA)
p <- 0
for (n in 1:1000000) {
    if (palindrome(n)) {
      p <- p + 1
      pals <- rbind(pals, data.frame(x = n, y = p))
    } 
    
}

library(ggplot2)
ggplot(pals[-1,], aes(x=x, y=y)) + geom_line() +
    xlab("n") + ylab("Palindromic numbers") + ggtitle("Euler Problem 4")
ggsave("ProjectEuler/Images/problem004.png")


