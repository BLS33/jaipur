#' @title Start the Game Jaipur
#'
#' @description Jaipur is a two player card game.
#'
#' @note  For more FUN while playing call shinyalert::useShinyalert()
#' in your console
#'
#' @export start_jaipur
start_jaipur <- function(){
  shiny::shinyApp(ui = jaipur_ui, server = jaipur_server)
}
