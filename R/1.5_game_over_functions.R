# Function for ending the Game if all cards are taken

#' @title  game over function
#'
#' @keywords internal game_over_cards
game_over_cards <- function(input, output, cards) {
  # End game if all cards are taken
  if (length(cards$deck) == 0) {
    # Player with more camels gets 5 extra coins
    if (cards$camels[[1]] > cards$camels[[2]]) {
      cards$money[[1]] <- cards$money[[1]] + 5
    } else{
      # If both Player's have same amount of camels nothing happens
      if (cards$camels[[1]] == cards$camels[[2]]) {
        cards$money[[1]] <- cards$money[[1]]
        cards$money[[2]] <- cards$money[[2]]
      } else{
        cards$money[[2]] <- cards$money[[1]] + 5
      }
    }

    # Successmessage
    shinyalert::shinyalert(
      title = "GAME OVER",
      text = HTML(
        paste(
          "The Game is over.
          <br> All cards have been taken!
          <br>
          Money Player 1:",
          cards$money[[1]],
          "<br>
          <br> Money Player 2:",
          cards$money[[2]],
          "<br> <br>",
          ifelse(
            cards$money[[1]] > cards$money[[2]],
            "Congratulations <br> Player 1 wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)",
            "Congratulations <br> Player 2 wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)"
          )
        )
      ),
      html = TRUE,
      type = "success",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://amp.businessinsider.com/images/5c1d1321404f4d3f1d190694-750-563.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )
  }
}

# Function for ending the game if 3 tokens are empty
#' @keywords internal game_over_tokens
game_over_tokens <- function(input, output, cards) {
  # End game if 3 tokens are empty
  if (((sum(is.na(cards$tokens[1, ]))) >= 3) == TRUE) {
    # Player with more camels gets 5 extra coins
    if (cards$camels[[1]] > cards$camels[[2]]) {
      cards$money[[1]] <- cards$money[[1]] + 5
    } else{
      # If both Player's have same amount of camels nothing happens
      if (cards$camels[[1]] == cards$camels[[2]]) {
        cards$money[[1]] <- cards$money[[1]]
        cards$money[[2]] <- cards$money[[2]]
      } else{
        cards$money[[2]] <- cards$money[[1]] + 5
      }
    }

    # Successmessage
    shinyalert::shinyalert(
      title = "GAME OVER",
      text = HTML(
        paste(
          "The Game is over.
          <br> 3 goods have been sold out!
          <br>
          Money Player 1:",
          cards$money[[1]],
          "<br>
          <br> Money Player 2:",
          cards$money[[2]],
          "<br> <br>",
          ifelse(
            cards$money[[1]] > cards$money[[2]],
            "Congratulations <br> Player 1 wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)",
            "Congratulations <br> Player 2 wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)"
          )
        )
      ),
      html = TRUE,
      type = "success",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://amp.businessinsider.com/images/5c1d1321404f4d3f1d190694-750-563.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )
  }
}
