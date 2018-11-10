## Remake of 3d Monster Maze

## Logic: http://softtangouk.wixsite.com/soft-tango-uk/3d-monster-maze
## Online gameplay: http://www.zx-gaming.co.uk/games/monstermaze/default.htm

## Initiate Maze
maze <- matrix(nrow = 18, ncol = 16)
maze[, ] <- "#"

## Print Maze
print.maze <- function() {
    v <- paste(as.vector(t(maze)), collapse = "")
    for (i in 1:18)
        print(substr(v, (i - 1) * 16 + 1, (i - 1) * 16 + 16))
}

## Generate Maze
xm1 <- 16 # Starting x
ym1 <- 17 # Starting y
path <- 0 # Length of passages

while(path < 800) {
    direction <- sample(c("N", "E", "S", "W"), 1) # Random direction
    l <- sample(1:6, 1) # Length of passage
    if (direction == "N") {
        ym2 <- ym1 - (l - 1) # End of passage
        if (ym2 < 2) ym2 <- 2 # South boundary?
        maze[ym1:ym2, xm1] <- " " # Cut passage
        ym1 <- ym2 # Next passage
        path <- path + l # Increment length
    }
    ## Rinse and repreat
    if (direction == "E") {
        xm2 <- xm1 + (l - 1)
        if (xm2 > 16) xm2 <- 16
        maze[ym1, xm1:xm2] <- " "
        xm1 <- xm2
        path <- path + l
    }
    if (direction == "S") {
        ym2 <- ym1 + (l - 1)
        if (ym2 > 17) ym2 <- 17
        maze[ym1:ym2, xm1] <- " "
        ym1 <- ym2
        path <- path + l
    }
    if (direction == "W") {
        xm2 <- xm1 - (l - 1)
        if (xm2 < 2) xm2 <- 2
        maze[ym1, xm1:xm2] <- " "
        xm1 <- xm2
        path <- path + l
    }
}

## Remove empty blocks
for (i in seq(2, 14, by = 2)) {
    for (j in seq(2, 16, by = 2)) {
        if (all(c(maze[j, i], maze[j + 1, i], maze[j, i + 1], maze[j + 1, i + 1]) == " "))
        {
            maze[sample(j:(j + 1), 1), sample(i:(i + 1), 1)] <- "#"
        }
    }
}

## Open east wall
maze[2:17, 16] <- " "

print.maze()
