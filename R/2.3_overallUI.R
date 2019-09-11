# Overall UI which integrates moduleUI's
#' @export ui
ui <- fluidPage(shinyalert::useShinyalert(),
                # Sidebar layout with input and output definitions
                sidebarLayout(
                  # Sidebar panel for Market, Tokens and Camels
                  sidebarPanel(
                    # Call the defined sidebarUI
                    sidebarUI('jaipur'),
                    # integrate Code for restarting the Game
                    shinyjs::useShinyjs(),
                    shinyjs::extendShinyjs(text = jsResetCode),
                    # Actionbutton for restarting the Game
                    shinyWidgets::actionBttn(inputId = "restart",
                               label = "Restart"),


                    tags$a(
                      href = "javascript:history.go(0)",
                      popify(
                        tags$i(class = "fa fa-refresh fa-5x"),
                        title = "Reload",
                        content = "Click here to restart the Shiny session",
                        placement = "right"
                      )
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
                        player1_UI('jaipur')
                      ),
                      # Intermediate Panel so Player's can't see others cards
                      tabPanel(
                        "Next Player",
                        br(),
                        h4("Click to continue"),
                        # Actionbutton to continue to next Panel
                        actionButton(inputId = "continue",
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
                        )
                      ),
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
