
### --- Function for taking cards --- ###
# with 'number' we can access the desired player (...)[[number]]

#' @keywords internal taking
taking <- function(input, output, cards, number, parent_session) {
  # Create list with input for easier access
  mar <- list(c(input$market_player_1),
              c(input$market_player_2))

  #If the Players take Camels, they take all Camels on market
  if (all(mar[[number]] == "Camel") == TRUE) {
    # Create variable which captures Camels for easier access
    cam1 <- length(which(cards$market[1:5] == "Camel"))

    cards$last_action <- rep(c("Camel"), times = cam1)
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
        cards$names[[number]],
        "! You took the camels, <br>  now it is",
        ifelse(number == 1, cards$names[[2]], cards$names[[1]]),
        "'s turn"
      ),
      html = TRUE,
      type = "success",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://raw.githubusercontent.com/BLS33/jaipur/master/inst/images/Camel.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )

    # Update the TabsetPanel, to the intermediate Panel
    updateTabsetPanel(session = parent_session,
                      "inTabset", selected = "Next Player")

    cards$action_text <-
      paste(
        cards$names[[number]],
        "took",
        cam1,
        "Camel, now it is your turn",
        ifelse(number == 1, cards$names[[2]], cards$names[[1]])
      )
  }

  # If the Player's do not take a Camel
  else if (length(mar[[number]]) != 1) {
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
  }
  # Make sure Player's only carry seven cards
  else if ((length(cards$hands[[number]]) >= 7)) {
    # Errormessage if they already carry 7 Cards
    shinyalert::shinyalert(
      title = "Error",
      text = HTML("Don't be greedy!
                      <br> You cannot take more than 7 Goods"),
      html = TRUE,
      type = "error",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )
    # If the Players normally take Cards
  } else {
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
          cards$names[[number]],
          "! You successfully took",
          mar[[number]],
          "<br>  now it is",
          ifelse(number == 1, cards$names[[2]], cards$names[[1]]),
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

    # update textOutput so the opponent sees which action was taken
    cards$action_text <-
      paste(
        cards$names[[number]],
        "took",
        mar[[number]],
        "now it is your turn",
        ifelse(number == 1, cards$names[[2]], cards$names[[1]])
      )

    # Update variables for plotting players input
    cards$last_swap <- c()
  }
}


### ---   Selling function   --- ###

#' @keywords internal selling
selling <- function(input, output, cards, number, parent_session) {
  # Create list with input for easier access
  vals <- list(c(input$hand_player_1),
               c(input$hand_player_2))

  # Make sure the player's can only sell one type of Good
  if (all(vals[[number]][1] == vals[[number]]) == FALSE) {
    shinyalert::shinyalert(
      title = "Error",
      text = HTML("You can only sell one type of Good"),
      html = TRUE,
      type = "error",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )

    # Make sure players must at least sell two of silver, gold, diamond
  } else if ((vals[[number]][1] == "Silver" |
              vals[[number]][1] == "Gold" |
              vals[[number]][1] == "Diamond") &
             length(vals[[number]]) == 1) {

    # Errormessage if they try to sell 1
    shinyalert::shinyalert(
      title = "Error",
      text = HTML(
        "You have to sell more than 1 <br>
        from the precious goods <br> Silver, Diamond and Gold"
      ),
      html = TRUE,
      type = "error",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )

    # If the Good is already sold out the Player's can't sell it anymore
  } else if (any(is.na(cards$tokens[1:length(vals[[number]]),
                                    vals[[number]]])) == TRUE) {
    shinyalert::shinyalert(
      title = "Error",
      text = "Sold out",
      html = TRUE,
      type = "error",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://babygizmo.com/wp-content/uploads/2018/06/allowed-featured.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )
  } else {
    # Player's normally sell Good -Remove sold Goods from Player's hands
    cards$hands[[number]] <-
      cards$hands[[number]][-which(cards$hands[[number]] %in% vals[[number]])
                            [1:length(vals[[number]])]]

    # Add the revenues to Player's money
    cards$money[[number]] <-
      cards$money[[number]] + sum(cards$tokens[1:length(vals[[number]]),
                                               vals[[number]][1]])

    # Remove the sold Goods from the Tokens
    cards$tokens[, vals[[number]][1]] <-
      cards$tokens[c((length(vals[[number]]) + 1):10,
                     rep(NA, times = length(vals[[number]]))),
                   vals[[number]][1]]

    # Update the TabsetPanel, to the intermediate Panel
    updateTabsetPanel(session = parent_session,
                      "inTabset", selected = "Next Player")

    # If Player's sell more than 3 of 1 Good they get extra money
    if (length(vals[[number]]) >= 3 &&
        length(vals[[number]]) <= 5) {
      cards$money[[number]] <-
        sum(cards$money[[number]], cards$extras[1, length(vals[[number]]) - 2])

      # The extras get deleted proportionally
      cards$extras[which(is.na(cards$extras[, length(vals[[number]]) - 2]) == T)
                   - 1, length(vals[[number]]) - 2] <- NA
    }

    # If the Player's sell >5 Goods, they get the same extra
    else if (length(vals[[number]]) >= 6) {
      cards$money[[number]] <-
        sum(cards$money[[number]], cards$extras[[1, 3]])

      cards$extras[which(is.na(cards$extras[, 3]) == T)
                   - 1, length(vals[[number]]) - 2] <- NA
    }

    # Success message that the sale was successfull
    shinyalert::shinyalert(
      title = "Success",
      text = HTML(
        cards$names[[number]],
        "! Your sale was successful, <br>  now it is",
        ifelse(number == 1, cards$names[[2]], cards$names[[1]]),
        "'s turn"
      ),
      html = TRUE,
      type = "success",
      showConfirmButton = TRUE,
      timer = 0,
      imageUrl = "https://raw.githubusercontent.com/BLS33/jaipur/master/inst/images/Gold.jpg",
      imageWidth = 400,
      imageHeight = 400,
      animation = TRUE
    )

    # update textOutput so the opponent sees which action was taken
    cards$action_text <-
      paste(
        cards$names[[number]],
        "sold",
        length(vals[[number]]),
        vals[[number]][1],
        "now it is your turn",
        ifelse(number == 1, cards$names[[2]], cards$names[[1]])
      )

    cards$last_swap <-
      c(input$hand_player_1, input$hand_player_2)

    cards$last_action <- c()
  }
}




### ---   swapping function   --- ###

#' @keywords internal swapping
swapping <- function(input, output, cards, number, parent_session) {
  # Create list that capture the player's input
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
  }

  # Make sure Players can only swap card by card
  else if (length(vals[[number]]) != length(mar[[number]])) {
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
  }

  # Make sure Players have to swap at least 2 Cards
  else if (length(vals[[number]]) < 2) {
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
  } else {
    # normal swapping, chosen cards are put into market and hands
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
          cards$names[[number]],
          "! Your swap was successful, <br> now it is",
          ifelse(number == 1, cards$names[[2]], cards$names[[1]]),
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
      paste(cards$names[[number]], "swapped",
            mar[[number]],
            "with",
            vals[[number]], ".")

    # Update variables for plotting players input
    cards$last_swap <-
      c(input$hand_player_1, input$hand_player_2)
    cards$last_action <-
      c(input$market_player_1, input$market_player_2)

  }
}


