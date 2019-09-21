#' @title Start the Game Jaipur
#'
#' @description Jaipur is a two player card game.
#'
#' @param Player_one Title of Player one's tabPanel
#' @param Player_two Title of Player two's tabPanel
#'
#' @note  For more FUN while playing play the game in full screen mode!
#'
#' @examples
#' #start_jaipur("Donald", "Barack")
#'
#'
#' @export start_jaipur
start_jaipur <-
  function(Player_one = "Player 1",
           Player_two = "Player 2") {
    if (typeof(Player_one) != "character") {
      stop("Your input has to be of type character")
    } else {
      shiny::shinyApp(ui = jaipur_ui(Player_one, Player_two),
                      server = jaipur_server)

    }
  }

