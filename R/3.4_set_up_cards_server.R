# Function for setting up the Cards
set_up_cards_server <- function(input, output, session, cards) {
  # market gets filled up with first two cards of the deck
  cards$market <- c(cards$market, cards$deck[1:2])
  # Player 1's hand gets filled up with the next 5 Cards
  cards$hands[[1]] <- cards$deck[3:7]
  # Player 2's hand gets filled up with the next 5 Cards
  cards$hands[[2]] <- cards$deck[8:12]
  # The cards appended to market and given to Player's are removed from the deck
  cards$deck <- cards$deck[13:length(cards$deck)]
  
  # If the Player's have camels on their hand those Camels get removed and
  # added to the Camelherd of respective Player's
  if (any(cards$hands[[1]] == "Camel")) {
    cards$hands[[1]] <-
      cards$hands[[1]][-which(cards$hands[[1]] == "Camel")]
    
    cards$camels[[1]] <- 5 - length(cards$hands[[1]])
  }
  
  if (any(cards$hands[[2]] == "Camel")) {
    cards$hands[[2]] <-
      cards$hands[[2]][-which(cards$hands[[2]] == "Camel")]
    
    cards$camels[[2]] <- 5 - length(cards$hands[[2]])
  }
  
}
