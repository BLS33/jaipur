library(jaipur)

test_that("playing_cards_plot works for different cards", {
  expect_error(playing_cards_plot(
    cards = c("Ace", "King", "Seven"),
    x = list(c(0, 1.5),
             c(2, 3.5),
             c(4, 5.5)),
    cards_color = c("green", "blue", "red")
  ),
  NA)
})

test_that("Plot does not work with faulty input", {
  expect_error(playing_cards_plot(
    cards = c("Ace", "King", "Seven"),
    x = list(c(0, 1.5),
             c(2, 3.5)),
    cards_color = c("green", "blue", "red")
  ))
})
