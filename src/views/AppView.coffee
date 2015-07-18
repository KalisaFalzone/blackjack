class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="play-again-button">Play Again</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-again-button': -> @model.playAgain()

  initialize: ->
    @render()
    @model.on 'change:playerHand', ->
        console.log 'AppView.model.on change:playerHand'
        @render()
      , @
    @model.on 'new-game', ->
        console.log 'ApView.model.on new-game'
        @render
    @model.on 'change:isPlayerTurn', =>
        console.log 'change in player turn'
        #disable hit-button and stand-button
        if not @model.get('isPlayerTurn')
          console.log '  is not player turn'
          $('.hit-button').hide()
          $('.stand-button').hide()
          $('.play-again-button').show()
        else
          console.log '  is player turn'
          $('.hit-button').show()
          $('.stand-button').show()
          $('.play-again-button').hide()
    @$el.find('.play-again-button').hide()




  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


