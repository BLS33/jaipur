# Overall Server which calls defined modules
server <- function(input, output, session) {
  # Show the Rules of the Game with a 'setup' button which sets up the Game
  showModal(
    modalDialog(
      title = "Jaipur Rules",
      HTML(rules),
      footer = modalButton("Let's Play"),
      actionBttn(inputId = "start",
                 label = "Set up the Game"),
      easyClose = TRUE,
      size = "l"
    )
  )

  # Define playing cards inside serverfunction for reactivity
  cards <- reactiveValues(
    # put Count to 1 - count is requiered for updating tabsetPanels
    count = 1,
    # Define the deck with only 8 Camels, as 3 Camels are on market
    # 'sample' the deck so the cards get shuffled
    deck = sample(c(
      rep("Camel", times = 8),
      rep("Leather", times = 10),
      rep("Spice", times = 8),
      rep("Cloth", times = 8),
      rep("Diamond", times = 6),
      rep("Gold", times = 6),
      rep("Silver", times = 6)
    )),
    # Define Tokens as data.frame so the tokens can be displayed as tableOutput
    tokens = data.frame(
      Leather = c(4, 3, 2, 1, 1, 1, 1, 1, 1, 1),
      Spice = c(5, 3, 3, 2, 2, 1, 1, NA, NA, NA),
      Cloth = c(5, 3, 3, 2, 2, 1, 1, NA, NA, NA),
      Diamond = c(7, 7, 5, 5, 5, NA, NA, NA, NA, NA),
      Gold = c(6, 6, 5, 5, 5, NA, NA, NA, NA, NA),
      Silver = c(5, 5, 5, 5, 5, NA, NA, NA, NA, NA)
    ),
    #Define the extras for selling more than 3 cards
    extras = data.frame(
      three = c(sample(c(1, 2, 3, 1, 2, 3, 2)), NA),
      four = c(sample(c(4, 5, 6, 4, 5, 6)), NA, NA),
      five = c(sample(c(8, 8, 9, 10, 10)), NA, NA, NA)
    ),
    # Define the market - first with 3 Camels
    market = c("Camel", "Camel", "Camel"),
    # Define Hand of Player 1
    hands = list(hand_player_1 = c(),
                 hand_player_2 = c()),
    # Define Number of Camels of Player 1
    camels = list(camels_player_1 = 0,
                  camels_player_2 = 0),
    # Create money of Players - at beginning both have 0
    money = list(money_player_1 = 0,
                 money_player_2 = 0),
    # Define a variable for textoutput which prints the player's last action
    action = "hi"
  )

  # Set up the cards when clicking on 'Lets Play'
  observeEvent(input$start, {
    # Set_up Module gets called, fills up the market and gives
    # the Player's their cards
    callModule(set_up_cards_server, 'jaipur', cards)
  })
  # Call the plot server to plot the market and Player's hands
  callModule(plot_server, 'jaipur', cards)
  # Call the output_server to integrate the textoutputs
  callModule(output_server, 'jaipur', cards)
  # Call player1_tab_server to create tabsetPanel of Player 1
  callModule(player1_tab_server, 'jaipur', cards)
  # Call player_2_tab_server to create tabsetPanel of Player 2
  callModule(player2_tab_server, 'jaipur', cards)
  # call action-servers for when player take, sell or swap Cards
  callModule(taking_server, 'jaipur', cards, parent_session = session)
  callModule(swapping_server, 'jaipur', cards, parent_session = session)
  callModule(selling_server, 'jaipur', cards, parent_session = session)

  # Move on to next player after seperating Panel
  observeEvent(input$continue, {
    # Count gets increased
    cards$count <- cards$count + 1
    # # the Panels get updated and hidden according to the count which is
    # increased when clicking on 'continue'
    if ((cards$count) %% 2 == 0) {
      hideTab(inputId = "inTabset", target = "Player 1")
      showTab(inputId = "inTabset", target = "Player 2")
      updateTabsetPanel(session = session, "inTabset", selected = "Player 2")

    } else{
      hideTab(inputId = "inTabset", target = "Player 2")
      showTab(inputId = "inTabset", target = "Player 1")
      updateTabsetPanel(session = session, "inTabset", selected = "Player 1")

    }
    # End the Game when Players click on 'Continue' if there are no cards left,
    # or when 3 of the tokens are sold out
    game_over_cards(input, output, cards)

    game_over_tokens(input, output, cards)
  })

  # Print the Player's last action
  output$opponents_action <- renderText({
    paste(cards$action)
  })

  # Restart the game when clicking on restart
  observeEvent(input$restart, {
    js$reset()
  })
}

# Run the App

shinyApp(ui = ui, server = server)
