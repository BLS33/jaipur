# Module for taking  cards
#' @keywords internal taking_server
taking_server <- function(input, output, session, cards, parent_session) {
  # As inputId's have to be unique we have to call the events
  # separately for the Player's

  # If Player 1 takes a cards
  observeEvent(input$take_player_1, {
    # For taking a Cards a marketinput is required
    req(input$market_player_1)

    # Call the taking function with number being equal to 1
    taking(input, output, cards, number = 1, parent_session)

  })

  # If Player 2 takes a cards
  observeEvent(input$take_player_2, {
    # For taking a Cards a marketinput is required
    req(input$market_player_2)

    # Call the taking function with number being equal to 2
    taking(input, output, cards, number = 2, parent_session)

  })

}

# Module for swapping cards
#' @keywords internal swapping_server
swapping_server <- function(input, output, session, cards, parent_session) {
  # If Player 1 swaps cards
  observeEvent(input$swap_player_1, {
    # swapping requires a market input and a hand input
    req(input$market_player_1, input$hand_player_1)

    # Call the swapping function with number being equal to 1
    swapping(input, output, cards, number = 1, parent_session)

  })

  # If Player 2 swaps cards
  observeEvent(input$swap_player_2, {
    # swapping requires a market input and a hand input
    req(input$market_player_2, input$hand_player_2)

    # Call the swapping function with number being equal to 2
    swapping(input, output, cards, number = 2, parent_session)

  })
}

# Module for selling cards
#' @keywords internal selling_server
selling_server <- function(input, output, session, cards, parent_session) {
  # If Player 1 sells cards
  observeEvent(input$sell_player_1, {
    # selling cards requires a hand input
    req(input$hand_player_1)

    # Call the selling function with number being equal to 1
    selling(input, output, cards, number = 1, parent_session)

  })

  #if Player 2 sells cards
  observeEvent(input$sell_player_2, {
    # selling cards requires a hand input
    req(input$hand_player_2)

    # Call the selling function with number being equal to 2
    selling(input, output, cards, number = 2, parent_session)

  })
}
