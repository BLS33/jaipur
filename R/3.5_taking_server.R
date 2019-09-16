# Module for taking  cards

#' @keywords internal taking_selling_swapping_server
taking_selling_swapping_server <-
  function(input,
           output,
           session,
           cards,
           parent_session) {
    # If Player 1 takes a cards
    observeEvent(input$take_player_1, {
      req(input$market_player_1)

      taking(input, output, cards, number = 1, parent_session)

    })

    # If Player 2 takes a cards
    observeEvent(input$take_player_2, {
      req(input$market_player_2)

      taking(input, output, cards, number = 2, parent_session)

    })

    # If player 1 swaps cards
    observeEvent(input$swap_player_1, {
      req(input$market_player_1, input$hand_player_1)

      swapping(input, output, cards, number = 1, parent_session)

    })

    # If Player 2 swaps cards
    observeEvent(input$swap_player_2, {
      req(input$market_player_2, input$hand_player_2)

      swapping(input, output, cards, number = 2, parent_session)

    })

    # If Player 1 sells cards
    observeEvent(input$sell_player_1, {
      req(input$hand_player_1)

      selling(input, output, cards, number = 1, parent_session)

    })

    #if Player 2 sells cards
    observeEvent(input$sell_player_2, {
      req(input$hand_player_2)

      selling(input, output, cards, number = 2, parent_session)

    })
  }
