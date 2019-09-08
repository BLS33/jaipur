# Function for taking cards - 'number' identifies Player
#' @export selling
selling <- function(input, output, cards, number, parent_session) {

  # Create list with input for easier access
  vals <- list(c(input$hand_player_1),
               c(input$hand_player_2))

  # Make sure the player's can only sell one type of Good
  if (all(vals[[number]][1] == vals[[number]]) == FALSE) {
    # Errormessage if they try otherwise
    shinyalert::shinyalert(
      title = "Error",
      text = HTML(
        "You can only sell one type of Good"
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

  } else{
    # Make sure players must at least sell two goods of silver, gold, or diamond
    if ((vals[[number]][1] == "Silver" |
         vals[[number]][1] == "Gold" |
         vals[[number]][1] == "Diamond") &
        length(vals[[number]]) == 1) {
      # Errormessage if they try to sell 1 of Gold/Diamonds/Silver
      shinyalert::shinyalert(
        title = "Error",
        text = HTML(
          "You have to sell more than 1 <br>
        from the precious goods like <br> Silver"
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
    } else{
      # If the Good is already sold out the Player's can't sell it anymore
      if (any(is.na(cards$tokens[1:length(vals[[number]]),
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
      } else{
        # Player's normally sell their Good - Remove sold Goods from Player's hands
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
          # Depending on whether player's sell 3, 4, 5, or >5 Goods, they
          # get extra money
          cards$money[[number]] <-
            sum(cards$money[[number]], cards$extras[1, length(vals[[number]]) - 2])
          # The extras get deleted proportionally
          cards$extras[which(is.na(cards$extras[, length(vals[[number]]) - 2]) == T)
                       -1, length(vals[[number]]) - 2] <- NA
        } else{
          # If the Player's sell >5 Goods, they get the same extra than for
          # selling exactly 5 Goods
          if (length(vals[[number]]) >= 6) {
            cards$money[[number]] <-
              sum(cards$money[[number]], cards$extras[[1, 3]])

            cards$extras[which(is.na(cards$extras[, 3]) == T)
                         -1, length(vals[[number]]) - 2] <- NA
          }
        }
        # Success message that the sale was successfull
        shinyalert::shinyalert(
          title = "Success",
          text = HTML(
            "Your sale was successful, <br>  now it is Player",
            number  %% 2 + 1,
            "'s turn"
          ),
          html = TRUE,
          type = "success",
          showConfirmButton = TRUE,
          timer = 0,
          imageUrl = "https://i.pinimg.com/originals/c7/8f/5f/c78f5ff94da025c552d2a1f0fc0ab82d.jpg",
          imageWidth = 400,
          imageHeight = 400,
          animation = TRUE
        )
        # update textOutput which is printed on intermediate Panel so
        # the opponent sees which action was taken
        cards$action <- paste("Your opponent sold", length(vals[[number]]),
                              vals[[number]][1],
                              "now it is your turn")
      }
    }
  }
}



