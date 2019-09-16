# Overall UI which integrates moduleUI's

#' @keywords internal jaipur_ui

test <- function(name1, name2) {
  jaipur_ui <- fluidPage(
    shinyalert::useShinyalert(),

    sidebarLayout(
      ### ---   Sidebar  for Market, Tokens, Camels, Restart   --- ###
    sidebarPanel(
      tagList(
        plotOutput("marketplot", height = 280),

        helpText("Tokens"),
        tableOutput("Tokens"),

        helpText("Deck"),
        verbatimTextOutput("Deck"),

        shinyWidgets::actionBttn(inputId = "restart",
                                 label = "Restart")
      )
    ),


    ### ---   MainPanel with Player's Panels   --- ###
    mainPanel(
      tabsetPanel(
        id = "inTabset",
        type = "tabs",

        ### ---    Panel of Player 1 --- ###
        tabPanel(
          title = paste(name1),
          value = "Player 1",
          br(),
          h4("Select goods from the market to swap or take"),

          # Add predefined Player1_UI
          player1_UI('jaipur'),

          plotOutput("plot_player_1",
                     height = 280,
                     width = 700),

          helpText("Number of Camels - Player 1"),
          verbatimTextOutput("camels_player_1")
        ),

        #### ---   Intermediate Panel   --- ###
        tabPanel(
          "Next Player",
          h4("Click to continue"),

          actionButton("continue",
                       label = "Continue"),

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

          plotOutput("actionplot", height = 280),

          plotOutput("swappingplot", height = 280)
        ),

        ### ---   Panel of Player 1   --- ###
        tabPanel(
          title = paste(name2),
          value = "Player 2",
          br(),
          h4("Select goods from the market to swap or take"),

          # Add predefined Player2_UI
          player2_UI('jaipur'),

          plotOutput("plot_player_2",
                     height = 280,
                     width = 700),


          helpText("Number of Camels - Player 2"),
          verbatimTextOutput("camels_player_2")
        )
      )
    )))
}
