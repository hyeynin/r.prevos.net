par(mar = rep(1,4), bg = "#0064b2")
plot.new()
plot.window(xlim = c(0,6), ylim = c(0,5))
whiyelred <- c("#FFFFFF", "#ffe001", "#dc2328")
#points(rep(0:6, 6), rep(0:5, 7), pch=19, col=sample(whiyelred, 6 * 9, replace = T), cex=8)

board <- matrix(ncol = 7, nrow = 6, data = 0)

play <- function(board, player, move) {
    row <- max(which(board[, move] == 0))
    board[row, move] <<- player
}

player <- 1
for (n in 1:20) {
    move <- sample(1:7, 1)
    play(board, player, move)
    player <- -player
}

