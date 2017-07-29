# TIC TAC TOE

# Random game
library(animation)
saveGIF ({
    for (i in 1:10) {
        game <- rep(0, 9) # Empty board
        winner <- 0 # Define winner
        player <- -1 # First player
        draw.board(game)
        while (0 %in% game & winner == 0) { # Keep playing until win or full board
            empty <- which(game == 0) # Define empty squares
            move <- empty[sample(length(empty), 1)] # Random move
            game[move] <- player # Change board
            draw.board(game)
            winner <- max(eval.game(game, 1), abs(eval.game(game, -1))) == 6
            player <- player * -1 # Change player
            }
    draw.board(game)
    }
    },
    interval = 0.25, movie.name = "ttt.gif", ani.width = 600, ani.height = 600)











