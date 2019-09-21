# Overall Server which calls defined modules

#' @keywords internal jaipur_server
jaipur_server <- function(input, output, session) {
  # Show the Rules of the Game with a 'setup' button which sets up the Game
  showModal(modalDialog(
    title = "Jaipur Rules",
    HTML(rules),
    footer =  list(
      div(style = "display: inline-block;vertical-align:top; width: 200px;",
          textInput("name1", "Player 1", value = "")),
      div(style = "display: inline-block;vertical-align:top; width: 200px;",
          textInput("name2", "Player 2", value = "")),
      div(
        style = "display: inline-block;vertical-align:top; width: 350px;",
        shinyWidgets::actionBttn(inputId = "start",
                                 label = "START THE GAME")
      )
    ),
    easyClose = FALSE,
    size = "l"
  ))

  # Define playing cards inside serverfunction for reactivity
  cards <- shiny::reactiveValues(
    # put Count to 1 - count is requiered for updating tabsetPanels
    count = 1,

    names = list(name1 = "Player one",
                 name2 = "Player two"),

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
      Leather = as.integer(c(4, 3, 2, 1, 1, 1, 1, 1, 1, 1)),
      Spice = as.integer(c(5, 3, 3, 2, 2, 1, 1, NA, NA, NA)),
      Cloth = as.integer(c(5, 3, 3, 2, 2, 1, 1, NA, NA, NA)),
      Diamond = as.integer(c(7, 7, 5, 5, 5, NA, NA, NA, NA, NA)),
      Gold = as.integer(c(6, 6, 5, 5, 5, NA, NA, NA, NA, NA)),
      Silver = as.integer(c(5, 5, 5, 5, 5, NA, NA, NA, NA, NA))
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
    hands = list(hand_player_1 = character(0),
                 hand_player_2 = character(0)),

    # Define Number of Camels of Player 1
    camels = list(camels_player_1 = 0,
                  camels_player_2 = 0),

    # Create money of Players - at beginning both have 0
    money = list(money_player_1 = 0,
                 money_player_2 = 0),

    # Define a variable for textoutput which prints the player's last action
    action_text = "",

    # Define a variable which plots the last taken cards on nextPlayertab
    last_action = c(),

    # Define a variable which plots sold or swapped cards on nextPlayertab
    last_swap = c()
  )

  observeEvent(input$name1, {
    req(input$name1)
    cards$names[[1]] <- input$name1
  })

  observeEvent(input$name2, {
    req(input$name2)
    cards$names[[2]] <- input$name2
  })

  # Set up the cards when clicking on 'Lets Play'
  observeEvent(input$start, {
    callModule(set_up_cards_server, 'jaipur', cards)

    removeModal()
  })

  # Call player1_tab_server to create tabsetPanel of Player 1
  callModule(players_input_server, 'jaipur', cards)

  # call action-servers for when player take, sell or swap Cards
  callModule(taking_selling_swapping_server,
             'jaipur',
             cards,
             parent_session = session)

  # Move on to next player after seperating Panel
  observeEvent(input$continue, {
    cards$count <- cards$count + 1

    # # the Panels get updated and hidden according to the count which is

    if ((cards$count) %% 2 == 0) {
      hideTab(inputId = "inTabset", target = "Player 1")
      showTab(inputId = "inTabset", target = "Player 2")
      updateTabsetPanel(session = session, "inTabset", selected = "Player 2")
    } else{
      hideTab(inputId = "inTabset", target = "Player 2")
      showTab(inputId = "inTabset", target = "Player 1")
      updateTabsetPanel(session = session, "inTabset", selected = "Player 1")
    }

    # End the Game
    game_over_cards(input, output, cards)

    game_over_tokens(input, output, cards)
  })

  # Print the Player's last action
  output$opponents_action <- renderText({
    paste(cards$action_text)
  })


  output$actionplot <- renderPlot({
    playing_cards_plot(
      title = "Last intake",
      cards = cards$last_action,
      x = list(c(0, 1.8),
               c(2, 3.8),
               c(4, 5.8),
               c(6, 7.8),
               c(8, 9.8)),
      x_limit = c(0, 14),
      cards_color = color_jaipur_cards(cards$last_action)
    )
  })

  output$swappingplot <- renderPlot({
    playing_cards_plot(
      title = "Last Drop",
      cards = cards$last_swap,
      x = list(
        c(0, 1.5),
        c(2, 3.5),
        c(4, 5.5),
        c(6, 7.5),
        c(8, 9.5),
        c(10, 11.5),
        c(12, 13.5)
      ),
      x_limit = c(0, 14),
      cards_color = color_jaipur_cards(cards$last_swap)
    )
  })

  output$marketplot <- renderPlot({
    playing_cards_plot(
      title = "Market",
      cards = cards$market,
      x = list(c(0, 1.8),
               c(2, 3.8),
               c(4, 5.8),
               c(6, 7.8),
               c(8, 9.8)),
      x_limit = c(0, 10),
      cards_color = color_jaipur_cards(cards$market)
    )
  })

  output$plot_player_1 <- renderPlot({
    playing_cards_plot(
      title = "Hand Player 1",
      cards = cards$hands[[1]],
      x = list(
        c(0, 1.5),
        c(2, 3.5),
        c(4, 5.5),
        c(6, 7.5),
        c(8, 9.5),
        c(10, 11.5),
        c(12, 13.5)
      ),
      x_limit = c(0, 14),
      cards_color = color_jaipur_cards(cards$hands[[1]])
    )
  })

  output$plot_player_2 <- renderPlot({
    playing_cards_plot(
      title = "Hand Player 2",
      cards = cards$hands[[2]],
      x = list(
        c(0, 1.5),
        c(2, 3.5),
        c(4, 5.5),
        c(6, 7.5),
        c(8, 9.5),
        c(10, 11.5),
        c(12, 13.5)
      ),
      x_limit = c(0, 14),
      cards_color = color_jaipur_cards(cards$hands[[2]])
    )
  })

  # Output for camels Player 1
  output$camels_player_1 <- renderPrint({
    cards$camels[[1]]
  })

  # output for camels Player 2
  output$camels_player_2 <- renderPrint({
    cards$camels[[2]]
  })

  # Number of Cards left in deck
  output$Deck <- renderPrint({
    (length(cards$deck))
  })

  # table of Tokens
  output$Tokens <- renderTable({
    (cards$tokens)
  })


  # Restart the game when clicking on restart
  observeEvent(input$restart, {
    session$reload()
  })

}
