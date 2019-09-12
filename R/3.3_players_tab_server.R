# Server function for creating the pickerinputs for player 1
#' @keywords internal player1_tab_server
player1_tab_server <- function(input, output, session, cards) {
  # Pickerinput to take or swap Cards from the Market
  output$player_1 <- renderUI(tagList(
    div(
      style = "display: inline-block;vertical-align:top; width: 430px;",
      shinyWidgets::checkboxGroupButtons(
        inputId = session$ns("market_player_1"),
        label = "Market",
        choices = cards$market,
        status = "primary",
        checkIcon = list(yes = icon("ok",
                                    lib = "glyphicon"))
      )
    ),

    # Pickerinput to sell or swap Cards from Player 1's hand
    div(
      style = "display: inline-block;vertical-align:top; width: 530px;",
      shinyWidgets::checkboxGroupButtons(
        inputId = session$ns("hand_player_1"),
        label = "Hand Player 1",
        choices = cards$hands[[1]],
        status = "success",
        checkIcon = list(yes = icon("ok",
                                    lib = "glyphicon"))
      )
    )
  ))
}

# Server function for creating the pickerinputs for player 2 as inputId's
# have to be unique
#' @keywords internal player2_tab_server
player2_tab_server <- function(input, output, session, cards) {
  # Pickerinput to take or swap Cards from the Market
  output$player_2 <- renderUI(tagList(
    div(
      style = "display: inline-block;vertical-align:top; width: 430px;",
      shinyWidgets::checkboxGroupButtons(
        inputId = session$ns("market_player_2"),
        label = "Market",
        choices = cards$market,
        status = "primary",
        checkIcon = list(yes = icon("ok",
                                    lib = "glyphicon"))
      )
    ),

    # Pickerinput to sell or swap Cards from Player 2's hand
    div(
      style = "display: inline-block;vertical-align:top; width: 530px;",
      shinyWidgets::checkboxGroupButtons(
        inputId = session$ns("hand_player_2"),
        label = "Hand Player 2",
        choices = cards$hands[[2]],
        status = "success",
        checkIcon = list(yes = icon("ok",
                                    lib = "glyphicon"))
      )
    )
  ))
}
