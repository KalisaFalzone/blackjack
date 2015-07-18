class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @render()
    @collection.on 'add remove change', =>
      # console.log 'HandView.collection.on add remove change'
      @render()

    @collection.on 'reset', =>
      console.log 'HandView.collection.on reset'
      @render()

    @collection.on 'set', =>
      console.log 'HandView.collection.on set'
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.score()

