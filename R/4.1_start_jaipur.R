#' @title Start the Game Jaipur
#'
#' @description Jaipur is a two player card game.
#'
#' @param Player_one Name of Player one
#' @param Player_two Name of Player two
#'
#' @note  For more FUN while playing call shinyalert::useShinyalert()
#' in your console
#'
#' @export start_jaipur
start_jaipur <-
  function(Player_one = "Player 1",
           Player_two = "Player 2") {
    if (typeof(Player_one) != "character") {
      stop("Your input has to be of type character")
    } else {
      shiny::shinyApp(ui = jaipur_ui(Player_one, Player_two), server = jaipur_server)

    }
  }

