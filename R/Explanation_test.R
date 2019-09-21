# rules UI which displays the Games rules

#' @keywords internal rules_UI

rules_UI <- fluidPage(sidebarLayout(sidebarPanel(
  tabsetPanel(
    type = "tabs",
    tabPanel("RULES",
             br(),
             br(),
             br(),
             br(),
             br(),
             br(),
             uiOutput("Market")),
    tabPanel("TAKE",
             br(),
             br(),
             br(),
             br(),
             br(),
             br(),
             uiOutput("Taking")),
    tabPanel("SELL",
             br(),
             br(),
             br(),
             br(),
             br(),
             br(),
             uiOutput("Selling")),
    tabPanel("SWAP",
             br(),
             br(),
             br(),
             br(),
             br(),
             br(),
             uiOutput("Swapping")),
    tabPanel("NEXT PLAYER",
             br(),
             br(),
             br(),
             br(),
             br(),
             br(),
             uiOutput("Next"))

  )
),

mainPanel(
  tabsetPanel(
    type = "tabs",
    tabPanel("RULES", textOutput("overall_Rules"),
             br(),
             actionButton("end1", "END TUTORIAL AND START THE GAME, BY RUNNING
                          start_jaipur()")),
    tabPanel("TAKE", textOutput("taking"),
             br(),
             actionButton("end2", "END TUTORIAL AND START THE GAME, BY RUNNING
                          start_jaipur()")),
    tabPanel("SELL", textOutput("selling"),
             br(),
             actionButton("end3", "END TUTORIAL AND START THE GAME, BY RUNNING
                          start_jaipur()")),
    tabPanel("SWAP", textOutput("swapping"),
             br(),
             actionButton("end4", "END TUTORIAL AND START THE GAME, BY RUNNING
                          start_jaipur()")),
    tabPanel("NEXT PLAYER", textOutput("nextp"),
             br(),
             actionButton("end5", "END TUTORIAL AND START THE GAME, BY RUNNING
                          start_jaipur()"))
    ))))

# rules_Server - Server function for the rules
#' @keywords internal reuler_Server

rules_Server <- function(input, output, session) {

  output$Market <- renderUI({
    tags$img(src = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/Market_and_Tokens.png")
  })

  output$Taking <- renderUI({
    tags$img(src = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/Taking_Selling_Swapping.png")
  })

  output$Selling <- renderUI({
    tags$img(src = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/Taking_Selling_Swapping.png")
  })

  output$Swapping <- renderUI({
    tags$img(src = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/Taking_Selling_Swapping.png")
  })

  output$Next <- renderUI({
    tags$img(src = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/NextPlayer.png")
  })

  output$overall_Rules <- renderText({
    "Goal of the game is to become the Maharaja’s personal trader by having more
    ruppees or simply being
    richer, than your opponent. To do so, you have to
    do better than your direct competitor by buying and exchanging goods at the
    market as well as selling goods at better prices. The game consists out of
    55 cards and 38 Tokens. The cards are split into goods cards, such as
    Leather, Spice, Cloth, Silver, Gold and Diamond, the Camel cardsand the
    Tokens. The Tokens can be interpreted as the Prices at which goods can be
    sold.
    The Game consists out of multiple elements. The MARKET, which is always
    displayed in the upper left corner. The TOKENS which are displayed in the
    table under the MARKET and the Players HAND CARDS which are in the same way
    displayed as the MARKET.
    When it is your turn, you can either TAKE, SELL or SWAP Cards, but never two
    or more actions at the same time.
    To find out how to TAKE, SELL or SWAP, click on the corresponding tabPanel.
    "
  })

  output$taking <- renderText({
    "If you want to take a card from the market, you can either take one single
    good, or  all Camels from the market. The taken good
    gets appended to your hand, which is displayed just in the way the
    market is displayed. If you take Camels from the market, you increase the
    size of your camel herd. At the end of the Game, the Player with the most
    Camels gets additional 5 ruppees. The goods cards can be sold and thereby
    transformed into ruppees, but the exact details of how yoou can sell goods
    are presented in the SELL tab.
    IF you want to take one good, or all Camels from the market, simply tick
    the card on the market (blue buttons on the left) and then confirm, by
    clicking on 'TAKE'.
    Afterwards the game will proceed and it is your opponents turn.
    If you want to take the Camels from the market, you only have to tick one
    camel and all camels will be appended to your herd automatically."
  })

  output$selling <- renderText({
    "The mechanics of selling goods work the same, as taking good.
    Simply tick the good you want to sell on your hand (green buttons) and then
    confirm, by clicking on 'SELL'.
    The rules for selling are simple:
    You can only sell one type of good at once, so you cannot sell Leather and
    Spice at the same time. And you must sell at least two of the precious goods
    Silver, Gold and Diamond. IF you try otherwise, the game will remind you
    about it.
    If you sell for example 3 Leathers, you have to tick three Leathers in your
    hand and confirm the sale. If successful, the first three numbers out of the
    'Leather' column in the Tokens table will be added to your money. In the
    example, you woul have earned 4 + 3 + 2 = 9 ruppees. The corresponding goods
    will be removed from the Tokens table, so the next Player who sell for
    example 1 Leather, will sell it for only  ruppee.
    Additionally to the ruppees you get for selling goods, you get extra money,
    for selling 3 or more cards at once. This extra money is hidden from you, so
    you do not know how much money you have at any time of the game, but you
    know, that selling 5 cards gets you more additional money, than selling 3."
  })

  output$swapping <- renderText({
    "When you want to swap cards between your hand and the market, you have to
    swap at least 2 cards. The procedure is as simple as when you take or sell
    cards. You simply have to tick the cards you want to receive on the market
    (blue buttons) and the cards you want to give away on your hand
    (green buttons). You cannot swap for camels and you have to swap card by
    card, but the game will remind you, if you try otherwise. Again you have to
    confirm your action, by clicking on 'SWAP'"
  })

  output$nextp <- renderText({
    "The 'NEXT PLAYER' tab is simply an output, which tells you the last action
    your opponent took. In the example picture, your opponent swapped Spice and
    Gold, with Cloth and Leather. By clicking on the 'CONTINUE' button you will
    continue the game and will be able to make your own move."
  })

  observeEvent(input$end1, {
    stopApp()
  })
  observeEvent(input$end2, {
    stopApp()
  })
  observeEvent(input$end3, {
    stopApp()
  })
  observeEvent(input$end4, {
    stopApp()
  })
  observeEvent(input$end5, {
    stopApp()
  })

}

#' @title Display the rules of the game
#'
#' @description Jaipur is a two player card game.
#'
#' @export show_rules
show_rules <- function(){
  shinyApp(ui = rules_UI, server = rules_Server)
}

show_rules()
