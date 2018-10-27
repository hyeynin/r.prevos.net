## Creepy Computer Games
## Reynold, Colin and McCaig, Rob, Creepy Computer Games (Usborne, London).
## https://archive.org/details/Creepy_Computer_Games_1983_Usborne_Publishing/
## Gravedigger by Alan Ramsey

## Clear screen function
## https://stackoverflow.com/questions/14260340/
cls <- function() cat(rep("\n", 50))

## Initiate board
board <- matrix(ncol = 20, nrow = 10)
board[,] <- " "
board

## Starting variables
w <- 0 # Move number
x <- 5 # Remaining holes

## Initiate pieces
pieces <- c("*", "+", "O", ":", "X", " ")
names(pieces) <- c("Y", "B", "C", "D", "E", "Z")
pieces

## Draw board
board[1, ] <- pieces["D"]
board[10, ] <- pieces["D"]
board[, 1] <- pieces["D"]
board[1:8, 20] <- pieces["D"]
for (j in 1:20){
    board[floor(runif(1) * 7 + 2), floor(runif(1) * 15 + 3)] <- pieces["B"]
}

## Starting positions
m <- 2
n <- 2
b <- c(4, 19, 3, 19, 2, 19)
for (j in seq(1, 5, by = 2)) {
    print(j)
    board[b[j], b[j + 1]] <- pieces["E"]
}

## Functions
print.board <- function() {
    v <- paste(as.vector(t(board)), collapse = "")        
    for (i in 1:10)
        print(substr(v, (i - 1) * 20 + 1, (i - 1) * 20 + 20))
    print(paste("Move :", w))
}

enter.move <- function() {
    a <- readline("Enter move:")
    w <- w + 1
    
    
}



## Game play
for (w in 1:60) {
    
}
