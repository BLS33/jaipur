# Function for taking cards - 'number' identifies Player

#' @keywords internal taking
taking <- function(input, output, cards, number, parent_session) {
  # Create list with input for easier access
  mar <- list(c(input$market_player_1),
              c(input$market_player_2))

  # If the Player's take Camels, they are not just takin 1 Camel, but all
  # Camels on the market
  if (all(mar[[number]] == "Camel") == TRUE) {

    # Create variable which captures all Camels for easier access
    cam1 <- length(which(cards$market[1:5] == "Camel"))

    cards$last_action <-
      rep(c(input$market_player_1, input$market_player_2), times = cam1)
    cards$last_swap <- c()

    # Get Camels from market
    cards$camels[[number]] <- cards$camels[[number]] + cam1

    # Get new Cards from deck into the market
    cards$market[cards$market == "Camel"] <- cards$deck[1:cam1]

    # Remove the Cards that are now on the market from Deck
    cards$deck <- cards$deck[-c(1:cam1)]

    # Success message
    shinyalert::shinyalert(
      title = "Success",
      text = HTML(
        "You took the camels, <br>  now it is Player",
        number  %% 2 + 1,
        "'s turn"
      ),
      html = TRUE,
      type = "success",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://media-cdn.tripadvisor.com/media/photo-s/0d/d3/a7/aa/each-camel-with-their.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )

    # Update the TabsetPanel, to the intermediate Panel
    updateTabsetPanel(session = parent_session,
                      "inTabset", selected = "Next Player")

    cards$action_text <-
      paste("Your opponent took", cam1, mar[[number]],
            "now it is your turn")

    # If the Player's do not take a Camel
  } else{

    # Make sure the Players can only take 1 Cards
    if (length(mar[[number]]) != 1) {

      # Errormessage if they try to take several Cards
      shinyalert::shinyalert(
        title = "Error",
        text = "You must only take 1 Card",
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

      # Make sure Player's only carry seven cards
      if ((length(cards$hands[[number]]) >= 7)) {

        # Errormessage if they already carry 7 Cards
        shinyalert::shinyalert(
          title = "Error",
          text = HTML("Don't be greedy! <br> You cannot take more than 7 Goods"),
          html = TRUE,
          type = "error",
          showConfirmButton = TRUE,
          timer = 0,
          imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
          imageWidth = 400,
          imageHeight = 400,
          animation = TRUE
        )
        # If the Player's normally take a Cards
      } else{

        # append market input to last_action, to plot action in tabPanel
        cards$last_action <-
          c(input$market_player_1, input$market_player_2)

        # append the chosen Cards to Player's hand
        cards$hands[[number]] <-
          c(cards$hands[[number]], mar[[number]])

        # replace chosen card on the market with new card from the deck
        cards$market[which(cards$market == mar[[number]])[1]] <-
          cards$deck[1]

        # remove card out of the deck
        cards$deck <- cards$deck[-1]

        # Successmessage
        shinyalert::shinyalert(
          title = "Success",
          text = HTML(
            paste(
              "You successfully took",
              mar[[number]],
              "<br>  now it is Player",
              number  %% 2 + 1,
              "'s turn"
            )
          ),
          html = TRUE,
          type = "success",
          showConfirmButton = TRUE,
          timer = 0,
          imageUrl = "https://images-na.ssl-images-amazon.com/images/I/81i4E15iulL._SL1500_.jpg",
          imageWidth = 400,
          imageHeight = 400,
          animation = TRUE
        )

        # Update the TabsetPanel, to the intermediate Panel
        updateTabsetPanel(session = parent_session,
                          "inTabset", selected = "Next Player")

        # update textOutput which is printed on intermediate Panel so
        # the opponent sees which action was taken
        cards$action_text <-
          paste("Your opponent took", mar[[number]],
                "now it is your turn")

        # Update variables for plotting players input
        cards$last_swap <- c()

      }
    }
  }
}

