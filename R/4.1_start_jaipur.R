#' Start the Game Jaipur
#'
#' More detailed description
#'
#' @param X numeric
#'
#' @example
#' bmi(32)
#'
#' @export start_jaipur
start_jaipur <- function(){
  shiny::shinyApp(ui = jaipur_ui, server = jaipur_server)
}
