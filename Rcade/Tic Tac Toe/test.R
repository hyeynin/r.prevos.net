tic.tac.toe.test <- function(player1 = "computer", player2 = "computer") {
    game <- rep(0, 9) # Empty board
    winner <- FALSE # Define winner
    player <- 1 # First player
    players <- c(player1, player2)
    while (0 %in% game & !winner) { # Keep playing until win or full board
        if (players[(player + 3) %% 3] == "human") # Human player
            move <- move.human(game)
        else # Computer player
            move <- move.computer(game, player)
        game[move] <- player # Change board
        winner <- max(eval.game(game, 1), abs(eval.game(game, -1))) == 6 # Winner, winner, chicken dinner?
        player <- -player # Change player
    }
    return(winner)
}

draw <- 0
itterations <- 10000
for (i in 1:itterations) {
    winner <- tic.tac.toe.test()
    if (!winner) draw <- draw + 1
    
}
print(draw / itterations)
