#' @import shiny

### --- color function for playing cards --- ###

#' @keywords internalcolor_jaipur_cards
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


### --- plot function for playing cards --- ###

#' @title Plot your playing cards
#'
#' @description Plot playing cards as textboxplots
#'
#' @param title The Title of your plot. Default = "Plot Title".
#' @param cards Playing Cards that will be plotted as character.
#' @param x list of vectors with min.and max. x-position of cards.
#' @param y y position: location of the top of the card.
#' @param x_limit set x scale limit. Default is c(0, 10).
#' @param cards_color colors of playing cards, default is white.
#'
#' @examples
#'  playing_cards_plot(title = "My Playing Cards",
#'  cards = c("Ace", "King", "Seven"),
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


### --- jaipur rules --- ###

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
        You can take a card, by ticking a card from the market (blue buttons)
        and then click on the button labeled 'TAKE'.
        <br>
        <br>
        If you swap cards, you have to swap between 2 and 5 cards between
        the market and your hand. Simply tick the cards you want to swap on the
        market (blue buttons) and on your hand (green buttons) respectively and
        confirm by clicking on 'SWAP'.
        <br>
        <br>

        If you sell cards, proceed in the same way as when you take or swap
        cards, the Game will remind you if you try actions that are not allowed.
        The Tokens table on the left, displays the prices to which you can
        sell your goods. If you sell for example 2 'Leather' you will receive
        4 + 3 = 7 ruppees and the corresponding entries in the table will be
        deleted.
        <br>
        <br>
        As you can see, the chips' values decrease as the game progresses,
        so you'd better hurry!
        On the other hand, you receive increasingly high rewards for
        selling three, four, or five cards of the same good at a time. These
        rewards are automatically added to your wealth but you cannot see how
        much has been added. The rewards vary between 1 and 10 ruppees, being
        between 1 and 3 if you sell 3 goods, between 4 and 7 if you sell 4 goods
        and between 8 and 10 if you sell 5 or more goods.
        <br>
        <br>
        You can't sell camels, but they're paramount for trading and they're
        worth 5 ruppees at the end of the game if you have a bigger camel
        herd than your opponent.
        <br>
        <br>
        Start the game, by clicking on the button below!"



