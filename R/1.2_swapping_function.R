# 'number' is given for the players number


#' @keywords internal swapping
swapping <- function(input, output, cards, number, parent_session) {
  # Create list that capture the player's input
  # with 'number' we can access the desired player (...)[[number]]
  vals <- list(c(input$hand_player_1),
               c(input$hand_player_2))

  mar <- list(c(input$market_player_1),
              c(input$market_player_2))

  # Make sure the Players cannot swap Camels
  if (any(mar[[number]] == "Camel")) {
    shinyalert::shinyalert(
      title = "Error",
      text = "You cannot swap for Camels",
      html = TRUE,
      type = "error",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )
  } else{
    # Make sure Players can only swap card by card
    if (length(vals[[number]]) != length(mar[[number]])) {
      shinyalert::shinyalert(
        title = "Error",
        text = "You have to swap card by card",
        html = TRUE,
        type = "error",
        showConfirmButton = TRUE,
        timer = 0,
        imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
        imageWidth = 400,
        imageHeight = 400,
        animation = TRUE
      )
    } else{
      # Make sure Players have to swap at least 2 Cards
      if (length(vals[[number]]) < 2) {
        shinyalert::shinyalert(
          title = "Error",
          text = "You have to swap at least 2 Cards",
          html = TRUE,
          type = "error",
          showConfirmButton = TRUE,
          timer = 0,
          imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
          imageWidth = 400,
          imageHeight = 400,
          animation = TRUE
        )
      } else{
        # normal swapping, the chosen cards are put into the market and the
        # Players Hands accordingly
        cards$market[which(cards$market %in% mar[[number]])
                     [1:length(vals[[number]])]] <- vals[[number]]

        cards$hands[[number]][which(cards$hands[[number]] %in% vals[[number]])
                              [1:length(mar[[number]])]] <-
          mar[[number]]

        # Success message
        shinyalert::shinyalert(
          title = "Success",
          text = HTML(
            paste(
              "Your swap was successful, <br> now it is Player",
              number  %% 2 + 1,
              "'s turn"
            )
          ),
          html = TRUE,
          type = "success",
          showConfirmButton = TRUE,
          timer = 0,
          imageUrl = "https://giftsforcardplayers.com/wp-content/uploads/2017/09/card-game-941430_960_720.jpg",
          imageWidth = 400,
          imageHeight = 400,
          animation = TRUE
        )

        # Update the TabsetPanel, to the intermediate Panel
        updateTabsetPanel(session = parent_session,
                          "inTabset", selected = "Next Player")

        cards$action_text <-
          paste("Your opponent swapped",
                mar[[number]],
                "with",
                vals[[number]],".")

        # Update variables for plotting players input
        cards$last_swap <-
          c(input$hand_player_1, input$hand_player_2)
        cards$last_action <-
          c(input$market_player_1, input$market_player_2)

      }
    }
  }
}


