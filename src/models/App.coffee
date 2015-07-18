# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand [], @get('deck')
    @set 'dealerHand', new Hand [], @get('deck'), true
    @set 'isPlayerTurn', true
    @playAgain()
    (@get 'playerHand').on 'lost won', =>
      @set 'isPlayerTurn', false
      console.log 'You lost or won'

    (@get 'dealerHand').on 'lost', =>
      console.log 'Dealer lost'

    (@get 'dealerHand').on 'won', =>
      console.log 'Dealer won'

    (@get 'playerHand').on 'stand', =>
      @set 'isPlayerTurn', false
      console.log 'DealerTurn'
      (@get 'dealerHand').autoplay (@get 'playerHand').score()

  playAgain: ->
    console.log 'App.playAgain'
    @set 'isPlayerTurn', true
    @set 'playerHand', @get('deck').dealPlayer (@get 'playerHand')
    @set 'dealerHand', @get('deck').dealDealer (@get 'dealerHand')
    @trigger 'new-game', @



