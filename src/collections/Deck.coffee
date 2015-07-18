class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    console.info 'Deck.initialize'
    @reset _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: (hand) ->
    # check if deck has enough cards ~13 cards
    if @length < 14
      @initialize()
    hand.set [@pop(), @pop()]

  dealDealer: (hand) ->
    hand.set [@pop().flip(), @pop()]

