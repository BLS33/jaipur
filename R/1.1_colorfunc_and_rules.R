#' @import shiny

#### color player 1's hand ###

#' @keywords internal color_jaipur_cards
color_jaipur_cards <- function(x) {
  card_color <- rep(NA, length(x))

  for (i in 1:length(x)) {
    if (x[i] == "Camel") {
      card_color[i] <- "khaki3"
    }
    if (x[i] == "Silver") {
      card_color[i] <- "grey"
    }
    if (x[i] == "Gold") {
      card_color[i] <- "gold2"
    }
    if (x[i] == "Cloth") {
      card_color[i] <- "purple"
    }
    if (x[i] == "Spice") {
      card_color[i] <- "darkorange3"
    }
    if (x[i] == "Diamond") {
      card_color[i] <- "dodgerblue2"
    }
    if (x[i] == "Leather") {
      card_color[i] <- "brown"
    }
    if (is.na(x[i]) == TRUE) {
      card_color <- "white"
    }
  }
  return(card_color)
}


#' @title Plot your playing cards
#'
#' @description Plot playing cards as textboxplots
#'
#' @param title = The Title of your plot. Default = "Plot Title".
#' @param cards = Playing Cards that will be plotted as character.
#' @param x list of vectors with min.and max. x-position of cards.
#' @param y y position: location of the top of the card.
#' @param x_limit set x scale limit. Default is c(0, 10).
#' @param cards_color colors of playing cards, default is white.
#'
#' @examples
#' # Generate some playing cards
#'  my_playing_cards <- c("Ace", "King", "Seven")
#'
#'  playing_cards_plot(title = "My Playing Cards",
#'  cards = my_playing_cards,
#'  x = list(c(0, 1.5),
#'  c(2, 3.5),
#'  c(4, 5.5)),
#'  cards_color = c("green", "blue", "red"))
#' @export playing_cards_plot
playing_cards_plot <- function(title = "Plot Title",
                               cards,
                               x,
                               y = 0.85,
                               x_limit = c(0, 10),
                               cards_color = "white") {
  if (length(cards) > length(x)) {
    stop("you have to specify at least as many x-positions as cards")
  } else {
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = x_limit,
      ylim = c(0, 1),
      main = title
    )

    if (length(cards) > 0) {
      for (i in 1:length(cards)) {
        plotrix::textbox(
          # Loop over plot_position vector which gives position of textboxes
          x = x[[i]],
          y = y,
          cards[i],
          justify = "c",
          fill = cards_color[i],
          cex = 1.2,
          leading = 8,
          adj = c(0, 3.8)
        )
      }
    }
  }
}


rules <- "You are one of the two most powerful traders in the city of Jaipur,
        the capital of Rajasthan!
        <br>
        <br>
        But that's not enough for you because only the
        merchant with the seal of excellence will have the privilege of being
        invited to the Maharaja's court.
        <br>
        <br>
        You are therefore going to have to do
        better than your direct competitor by buying, exchanging, and selling at
        better prices, all while keeping an eye on your camel herds.
        <br>
        <br>
        Jaipur is a fast-paced card game, a blend of tactics, risk and luck.
        On your turn, you can either take, sell or swap cards.
        <br>
        If you want to take cards, you have to choose between taking all the
        camels, or taking one card from the market.
        You can take a card, by choosing a card from the market with the input
        Options and then click on the button labeled 'TAKE'
        <br>
        The market is displayed in the left upper corner of the monitor.
        <br>
        If you swap cards, you have to swap between 2 and 5 cards between
        the market and your hand.
        <br<
        Your hand is displayed as a Plot in the middle of your Panel. For
        swapping Cards, you have choose cards from your hand and from the
        market by clicking on the Input options and then click on the button
        labelled 'SWAP'.
        <br>
        If you sell cards, you get to sell only one type of good, and you
        receive as many chips for that good as the number of cards you sold.
        <br>

        The chips' values decrease as the game progresses, so you'd better
        hurry! On the other hand, you receive increasingly high rewards for
        selling three, four, or five cards of the same good at a time,
        so you'd better wait!
        <br>
        <br>
        You can't sell camels, but they're paramount for trading and they're
        also worth a little something at the end of the round, enough sometimes
        to secure the win, so you have to use them smartly.
        <br>
        <br>
        <br>"


