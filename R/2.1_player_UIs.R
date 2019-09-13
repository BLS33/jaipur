# Creat UI for Player 1

#' @keywords internal player1_UI
player1_UI <- function(id) {
  # define Namespace
  ns <- NS(id)
  tagList(
    # Create market and hand output
    uiOutput(ns("player_1")),

    # Add spaces
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),

    # Actionbutton to take cards
    actionButton(ns("take_player_1"),
                 label = "TAKE"),

    # Actionbutton to sell cards
    actionButton(ns("sell_player_1"),
                 label = "SELL"),

    # Actionbutton to swap
    actionButton(ns("swap_player_1"),
                 label = "SWAP"),

    # Output of player 1's hand
    plotOutput(ns("plot_player_1"),
               height = 280,
               width = 700),

    # Number of Players Camels under the Tokens
    helpText("Number of Camels - Player 1"),
    verbatimTextOutput(ns("camels_player_1"))
  )

}

# Creat UI for Player 2 seperately as Id's have to be unique
#' @keywords internal player2_UI
player2_UI <- function(id) {
  # define Namespace
  ns <- NS(id)
  tagList(
    # Create market and hand output
    uiOutput(ns("player_2")),

    # Add spaces
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),

    # Actionbutton to take cards
    actionButton(ns("take_player_2"),
                 label = "TAKE"),

    # Actionbutton to sell cards
    actionButton(ns("sell_player_2"),
                 label = "SELL"),

    # Actionbutton to swap
    actionButton(ns("swap_player_2"),
                 label = "SWAP"),

    # Output of player 2's hand
    plotOutput(ns("plot_player_2"),
               height = 280,
               width = 700),

    # Number of Players Camels under the Tokens
    helpText("Number of Camels - Player 2"),
    verbatimTextOutput(ns("camels_player_2"))
  )

}
