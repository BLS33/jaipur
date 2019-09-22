### --- Server function for pickerinputs for players --- ###

#' @keywords internal
players_input_server <- function(input, output, session, cards) {
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


### --- Function for setting up and handing out Cards --- ###

#' @keywords internal
set_up_cards_server <- function(input, output, session, cards) {
  # market gets filled up with first two cards of the deck
  cards$market <- c(cards$market, cards$deck[1:2])

  # Player 1's hand gets filled up with the next 5 Cards
  cards$hands[[1]] <- cards$deck[3:7]

  # Player 2's hand gets filled up with the next 5 Cards
  cards$hands[[2]] <- cards$deck[8:12]

  # The cards appended to market and given to Player's deleted from deck
  cards$deck <- cards$deck[13:length(cards$deck)]

  # If the Player's have camels on their hand those Camels get removed
  if (any(cards$hands[[1]] == "Camel")) {
    cards$hands[[1]] <-
      cards$hands[[1]][-which(cards$hands[[1]] == "Camel")]

    cards$camels[[1]] <- 5 - length(cards$hands[[1]])
  }

  if (any(cards$hands[[2]] == "Camel")) {
    cards$hands[[2]] <-
      cards$hands[[2]][-which(cards$hands[[2]] == "Camel")]

    cards$camels[[2]] <- 5 - length(cards$hands[[2]])
  }

}

