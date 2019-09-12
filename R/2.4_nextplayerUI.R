# Creating sidebarmodule
#' @keywords internal nextPlayerUI
nextPlayerUI <- function(id) {
  # defining namespace
  ns <- NS(id)
  tagList(
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
    ),

    # Plot the action -selling and taking- on nextPlayerPanel
    plotOutput(ns("actionplot"), height = 280),

    # Plot the action -swapping- on nextPlayerPanel
    plotOutput(ns("swappingplot"), height = 280)
  )
}
