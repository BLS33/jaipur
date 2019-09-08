# Server function for creating the pickerinputs for player 1
#' @export player1_tab_server
player1_tab_server <- function(input, output, session, cards) {
  # Pickerinput to take or swap Cards from the Market
  output$player_1 <- renderUI(tagList(
    div(
      style = "display: inline-block;vertical-align:top; width: 350px;",
      shinyWidgets::pickerInput(
        inputId = session$ns("market_player_1"),
        label = "Market",
        choices = cards$market,
        multiple = TRUE
      )
    ),
    # Pickerinput to sell or swap Cards from Player 1's hand
    div(
      style = "display: inline-block;vertical-align:top; width: 350px;",
      shinyWidgets::pickerInput(
        inputId = session$ns("hand_player_1"),
        label = "Hand Player 1",
        choices = cards$hands[[1]],
        multiple = TRUE
      )
    )
  ))
}

# Server function for creating the pickerinputs for player 2 as inputId's
# have to be unique
#' @export player2_tab_server
player2_tab_server <- function(input, output, session, cards) {
  # Pickerinput to take or swap Cards from the Market
  output$player_2 <- renderUI(tagList(
    div(
      style = "display: inline-block;vertical-align:top; width: 350px;",
      shinyWidgets::pickerInput(
        inputId = session$ns("market_player_2"),
        label = "Market",
        choices = cards$market,
        multiple = TRUE
      )
    ),

    # Pickerinput to sell or swap Cards from Player 1's hand
    div(
      style = "display: inline-block;vertical-align:top; width: 350px;",
      shinyWidgets::pickerInput(
        inputId = session$ns("hand_player_2"),
        label = "Hand Player 2",
        choices = cards$hands[[2]],
        multiple = TRUE
      )
    )
  ))
}
