UI <- fluidPage(sidebarLayout(sidebarPanel(
  tabsetPanel(
    type = "tabs",
    tabPanel("RULES", htmlOutput("Market")),
    tabPanel("TAKE", imageOutput("Tokens"))
  )
),

mainPanel(
  tabsetPanel(
    type = "tabs",
    tabPanel("RULES", textOutput("overall_Rules")),
    tabPanel("TAKE", textOutput("taking"))))))



Server <- function(input, output, session) {
  market = "https://raw.githubusercontent.com/BLS33/jaipur/master/images/Market_and_Tokens.png"
  output$Market <- renderText({
    c('<img src="', market, '">')
  })

  output$overall_Rules <- renderText({
    "Goal of the game is to become the Maharaja’s personal trader by being
    richer than your opponent at the end of each round. To do so, you have to
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
    When it is your turn, you can either TAKE, SELL or SWAP Cards.
    To find out how to TAKE, SELL or SWAP, click on the corresponding tabPanel.
    "
  })

}


shinyApp(UI, Server)
