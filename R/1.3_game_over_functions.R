### --- Game over if all cards are taken --- ###

#' @keywords internal
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
          "The Game is over. All cards have been taken!
          <br>
          Money",
          cards$names[[1]],
          ":",
          cards$money[[1]],
          "<br>
          <br> Money",
          cards$names[[2]],
          ":",
          cards$money[[2]],
          "<br> <br>",
          ifelse(
            cards$money[[1]] > cards$money[[2]],
            paste(
              "Congratulations:",
              cards$names[[1]],
              "wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)"
            ),
            paste(
              "Congratulations:",
              cards$names[[2]],
              "wins
            <br> You are now the personal trader of the Maharaja,
            <br> Kumar Padmanabh Singh (Picture above)"
            )
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


### --- Game over function if 3 tokens are empty --- ###

#' @keywords internal
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
          "The Game is over. 3 goods have been sold out!
          <br>
          Money",
          cards$names[[1]],
          ":",
          cards$money[[1]],
          "<br>
          <br>
          Money",
          cards$names[[2]],
          ":",
          cards$money[[2]],
          "<br>
          <br>",
          ifelse(
            cards$money[[1]] > cards$money[[2]],
            paste(
              "Congratulations:",
              cards$names[[1]],
              "wins
            <br> You are now the personal trader of the Maharaja,
              Kumar Padmanabh Singh"
            ),
            paste(
              "Congratulations:",
              cards$names[[2]],
              "wins
            <br> You are now the personal trader of the Maharaja,
              Kumar Padmanabh Singh"
            )
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
