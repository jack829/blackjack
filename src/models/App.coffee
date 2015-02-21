# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    dealerHand.on('all', @dealerEvents, @)
    playerHand.on('all', @playerEvents, @)


  playerEvents: (event, hand)->
    switch event
      when 'stand' then @get('dealerHand').dealerTurn()
      when 'gameOver' then @checkWinner()

  dealerEvents: (event, hand)->
    switch event
      when 'gameOver' then @checkWinner()

  checkWinner: ->

    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    playerScore = playerHand.scores()
    dealerScore = dealerHand.scores()

    if playerScore[1] > 21
      playerScore = playerScore[0]
    else
      playerScore = playerScore[1]

    if dealerScore[1] > 21
      dealerScore = dealerScore[0]
    else
      dealerScore = dealerScore[1]

    if playerScore > 21
      @trigger 'dealerWins'
      return

    if dealerScore > 21
      @trigger 'playerWins'
      return

    if playerScore > dealerScore 
      #player wins
      console.log('playerWin')
      @trigger('playerWins')
    else if dealerScore > playerScore
      #dealer wins
      console.log('dealerWin')
      @trigger('dealerWins')
    else 
      @trigger 'push'