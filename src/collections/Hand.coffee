class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @deck.on('playerStand', @dealerTurn, @)
    @deck.on('dealerStand', @endRound, @)
    # @set 'isDealer', @isDealer

  hit: ->
    @add(@deck.pop())
    score = @scores()
    alert "bust!" if score[0] > 21

  stand: ->
    console.log(@isDealer)
    @deck.stand(@isDealer)

  dealerTurn: ->
    console.log("dealer's turn")
    if @isDealer 
      @at(0).flip()

  endRound: ->
    console.log("this game over")

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