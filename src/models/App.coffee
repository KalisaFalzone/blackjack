# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand [], @get('deck')
    @set 'dealerHand', new Hand [], @get('deck'), true
    @playAgain()

    # TODO listen for won/lost
      # to disabled hit/stand
      # to flip dealer hold card
      # to enable play again

    # TODO listen for stand to let dealer play

  playAgain: ->
    # TODO check if deck has enough cards

    console.log 'App.playAgain'
    @set 'playerHand', @get('deck').dealPlayer (@get 'playerHand')
    @set 'dealerHand', @get('deck').dealDealer (@get 'dealerHand')
    @trigger 'new-game', @
      # this isn't getting caught the first time
      # because the view doesn't exist yet when this
      # is called

