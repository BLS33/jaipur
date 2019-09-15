# Overall UI which integrates moduleUI's

#' @keywords internal jaipur_ui
jaipur_ui <- fluidPage(shinyalert::useShinyalert(),
                       # Sidebar layout with input and output definitions
                       sidebarLayout(# Sidebar panel for Market, Tokens and Camels
                         sidebarPanel(
                           # Call the defined sidebarUI
                           tagList(
                             # Plot the Market on sidepanel
                             plotOutput("marketplot", height = 280),

                             # Plot Tokens under the Market
                             helpText("Tokens"),
                             tableOutput("Tokens"),

                             #Number of Cards left in the Deck on the bottom of sidepanel
                             helpText("Deck"),
                             verbatimTextOutput("Deck"),

                             # Actionbutton for restarting the Game
                             shinyWidgets::actionBttn(inputId = "restart",
                                                      label = "Restart")
                           )
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
                               player1_UI('jaipur'),
                               # Output of player 1's hand
                               plotOutput("plot_player_1",
                                          height = 280,
                                          width = 700),


                               # Number of Players Camels under the Tokens
                               helpText("Number of Camels - Player 1"),
                               verbatimTextOutput("camels_player_1")
                             ),

                             # Intermediate Panel so Player's can't see others cards
                             tabPanel(
                               "Next Player",
                               h4("Click to continue"),

                               # Add predefined nextPlayerUI
                               # Actionbutton to continue to next Panel
                               actionButton("continue",
                                            label = "Continue"),

                               # Textoutput - gives last Player's action
                               textOutput("opponents_action"),
                               tags$head(
                                 # Define text style with html
                                 tags$style(
                                   "#opponents_action{color: black;
                                 font-size: 30px;
                                 font-style: arvo;
                                 }"
                                 )
                               ),

                               # Plot the action -selling and taking- on nextPlayerPanel
                               plotOutput("actionplot", height = 280),

                               # Plot the action -swapping- on nextPlayerPanel
                               plotOutput("swappingplot", height = 280)
                             ),

                             # Panel of Player 1
                             tabPanel(
                               "Player 2",
                               br(),
                               h4("Select goods from the market to swap or take"),

                               # Add predefined Player2_UI
                               player2_UI('jaipur'),


                               # Output of player 2's hand
                               plotOutput("plot_player_2",
                                          height = 280,
                                          width = 700),



                               # Number of Players Camels under the Tokens
                               helpText("Number of Camels - Player 2"),
                               verbatimTextOutput("camels_player_2")
                             )
                           )
                         )))
