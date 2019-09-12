# Creating sidebarmodule
#' @keywords internal sidebarUI
sidebarUI <- function(id) {
  # defining namespace
  ns <- NS(id)
  tagList(
    # Plot the Market on sidepanel
    plotOutput(ns("marketplot"), height = 280),
    # Plot Tokens under the Market
    helpText("Tokens"),
    tableOutput(ns("Tokens")),
    #Number of Cards left in the Deck on the bottom of sidepanel
    helpText("Deck"),
    verbatimTextOutput(ns("Deck"))
  )
}
