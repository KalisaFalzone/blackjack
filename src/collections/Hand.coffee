class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    scores = @scores()
    if scores[0] > 21
      console.log 'Hand.hit lost'
      @trigger 'lost', @
    else if 21 in scores or @length == 5
      console.log 'Hand.hit won'
      @trigger 'won', @

  stand: -> @trigger 'stand', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  score: ->
    if @scores()[1] <= 21
      @scores()[1]
    else
      @scores()[0]

  autoplay: (score) ->
    # flip card
    @at(0).flip()
    while score <= 21 and @score() < 17
      @hit()
    # check if won
    if @score() > score and @score() < 21
      @trigger 'won',@
    else if @score() < 21
      @trigger 'lost', @
