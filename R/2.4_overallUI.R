# Overall UI which integrates moduleUI's

#' @title  jaipur UI function
#'
#' @keywords internal jaipur_ui
jaipur_ui <- fluidPage(shinyalert::useShinyalert(),
                       # Sidebar layout with input and output definitions
                       sidebarLayout(
                         # Sidebar panel for Market, Tokens and Camels
                         sidebarPanel(
                           # Call the defined sidebarUI
                           sidebarUI('jaipur'),

                           # Actionbutton for restarting the Game
                           shinyWidgets::actionBttn(inputId = "restart",
                                                    label = "Restart")
                         ),

                         # MainPanel with Player's Panels
                         mainPanel(
                           tabsetPanel(
                             id = "inTabset",
                             type = "tabs",

                             # Panel of Player 1
                             tabPanel(
                               "Player 1",
                               br(),
                               h4("Select goods from the market to swap or take"),

                               # Add predefined Player1_UI
                               player1_UI('jaipur')
                             ),

                             # Intermediate Panel so Player's can't see others cards
                             tabPanel("Next Player",
                                      h4("Click to continue"),

                                      # Add predefined nextPlayerUI
                                      nextPlayerUI("Jaipur")),

                             # Panel of Player 1
                             tabPanel(
                               "Player 2",
                               br(),
                               h4("Select goods from the market to swap or take"),

                               # Add predefined Player2_UI
                               player2_UI('jaipur')
                             )
                           )
                         )
                       ))
