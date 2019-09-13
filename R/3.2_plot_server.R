# Module for plots of Market and Player's hands

#' @keywords internal plot_server
plot_server <- function(input, output, session, cards) {
  # Create a List for position of textboxes for plot of Player's hands
  plot_position_hands <- list(c(0, 1.5),
                              c(2, 3.5),
                              c(4, 5.5),
                              c(6, 7.5),
                              c(8, 9.5),
                              c(10, 11.5),
                              c(12, 13.5))

  # plot player 1's hand
  output$plot_player_1 <- renderPlot({
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = c(0, 14),
      ylim = c(0, 1),
      main = "Hand Player 1"
    )

    # Create textboxes for the plot
    if (length(cards$hands[[1]] > 0)) {
      for (i in 1:length(cards$hands[[1]])) {
        plotrix::textbox(
          # Loop over plot_position vector which gives position of textboxes
          plot_position_hands[[i]],
          0.85,
          cards$hands[[1]][i],
          justify = "c",
          fill = color_func_jaipur(cards$hands[[1]])[i],
          cex = 1.2,
          leading = 8,
          adj = c(0, 3.8)
        )
      }
    }
  })

  # plot player 2's hand
  output$plot_player_2 <- renderPlot({
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = c(0, 14),
      ylim = c(0, 1),
      main = "Hand Player 2"
    )

    # Create textboxes for the plot
    if (length(cards$hands[[2]] > 0)) {
      for (i in 1:length(cards$hands[[2]])) {
        plotrix::textbox(
          # Loop over plot_position vector which gives position of textboxes
          plot_position_hands[[i]],
          0.85,
          cards$hands[[2]][i],
          justify = "c",
          fill = color_func_jaipur(cards$hands[[2]])[i],
          cex = 1.2,
          leading = 8,
          adj = c(0, 3.8)
        )
      }
    }
  })

  # Define position of market plot
  plot_position_market <- list(c(0, 1.8),
                               c(2, 3.8),
                               c(4, 5.8),
                               c(6, 7.8),
                               c(8, 9.8))
  # Create plot
  output$marketplot <- renderPlot({
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = c(0, 10),
      ylim = c(0, 1),
      main = "MARKET"
    )

    for (i in 1:length(cards$market)) {
      plotrix::textbox(
        # Loop over plot_position vector which gives position of textboxes
        plot_position_market[[i]],
        0.85,
        cards$market[i],
        justify = "c",
        fill = color_func_jaipur(cards$market)[i],
        cex = 1.2,
        leading = 8,
        adj = c(0, 3.8)
      )
    }
  })

  output$actionplot <- renderPlot({
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = c(0, 10),
      ylim = c(0, 1),
      main = "ACTION"
    )

    if (length(cards$last_action > 0)) {
      for (i in 1:length(cards$last_action)) {
        plotrix::textbox(
          # Loop over plot_position vector which gives position of textboxes
          plot_position_hands[[i]],
          0.85,
          cards$last_action[i],
          justify = "c",
          fill = color_func_jaipur(cards$last_action)[i],
          cex = 1.2,
          leading = 8,
          adj = c(0, 3.8)
        )
      }
    }
  })

  output$swappingplot <- renderPlot({
    graphics::plot(
      1,
      type = "n",
      xlab = "",
      ylab = "",
      axes = FALSE,
      xlim = c(0, 10),
      ylim = c(0, 1),
      main = "ACTION"
    )

    if (length(cards$last_swap > 0)) {
      for (i in 1:length(cards$last_swap)) {
        plotrix::textbox(
          # Loop over plot_position vector which gives position of textboxes
          plot_position_hands[[i]],
          0.85,
          cards$last_swap[i],
          justify = "c",
          fill = color_func_jaipur(cards$last_swap)[i],
          cex = 1.2,
          leading = 8,
          adj = c(0, 3.8)
        )
      }
    }
  })


}
