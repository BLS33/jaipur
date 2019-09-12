#' Start the Game Jaipur
#'
#' Jaipur is a two player card game.
#'
#' @param x TRUE or FALSE. If TRUE the app will start in your default Browser.
#' If FALSE the app will start in the R Browser
#'
#'
#' @note  For more FUN while playing call shinyalert::useShinyalert()
#' in your console
#'
#' @export start_jaipur
start_jaipur <- function(x){
  shiny::shinyApp(ui = jaipur_ui, server = jaipur_server)
}
