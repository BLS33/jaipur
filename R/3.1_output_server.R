# Output module for textoutputs as Camels and deck and Tokens

#' @title Output server function
#'
#' @keywords internal output_server
output_server <- function(input, output, server, cards) {
  # output for number of Camels of Player 1
  output$camels_player_1 <- renderPrint({
    cards$camels[[1]]
  })

  # output for number of Camels of Player 2
  output$camels_player_2 <- renderPrint({
    cards$camels[[2]]
  })

  # Number of Cards left in the deck
  output$Deck <- renderPrint({
    (length(cards$deck))
  })

  # table of Tokens
  output$Tokens <- renderTable({
    (cards$tokens)
  })
}
