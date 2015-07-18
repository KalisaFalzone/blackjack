# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand [], @get('deck')
    @set 'dealerHand', new Hand [], @get('deck'), true
    @set 'isPlayerTurn', true
    @set 'outcome', ''
    @playAgain()
    (@get 'playerHand').on 'lost', =>
      @set 'isPlayerTurn', false
      @set 'outcome', 'You lost'

    (@get 'playerHand').on 'won', =>
      @set 'isPlayerTurn', false
      @set 'outcome', 'You won!'

    (@get 'dealerHand').on 'lost', =>
      @set 'outcome', 'You won!'

    (@get 'dealerHand').on 'won', =>
      @set 'outcome', 'You lost'


    (@get 'playerHand').on 'stand', =>
      @set 'isPlayerTurn', false
      (@get 'dealerHand').autoplay (@get 'playerHand').score()

  playAgain: ->
    console.log 'App.playAgain'
    @set 'outcome', ''
    @set 'isPlayerTurn', true
    @set 'playerHand', @get('deck').dealPlayer (@get 'playerHand')
    @set 'dealerHand', @get('deck').dealDealer (@get 'dealerHand')
    @trigger 'new-game', @



