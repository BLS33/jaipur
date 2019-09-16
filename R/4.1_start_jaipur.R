#' @title Start the Game Jaipur
#'
#' @description Jaipur is a two player card game.
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
      shiny::shinyApp(ui = test(Player_one, Player_two), server = jaipur_server)

    }
  }

start_jaipur("Thomas", "Torsten")
