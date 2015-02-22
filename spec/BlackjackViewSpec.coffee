assert = chai.assert

describe 'AppModel', ->

  app = null;

  beforeEach ->
    app = new App()

  it 'creates a dealerHand and playerHand on initialize', ->
    dealerHand = app.get('dealerHand')
    isDealerHand = dealerHand instanceof Hand

    playerHand = app.get('playerHand')
    isPlayerHand = playerHand instanceof Hand

    assert dealerHand , isDealerHand
    assert playerHand, isPlayerHand


  it 'checks for the winner', ->
    card1 = new Card 
      rank: 0
    card2 = new Card
      rank: 1
    console.log(card1, card2)
    card3 = new Card
      rank: 9
    playerHand = new Hand [card1, card3]
    dealerHand = new Hand [card1, card2], null, true
    app.set('playerHand', playerHand)
    app.set('dealerHand', dealerHand) 
    app.checkWinner()
    winnerCheck = null
    check = true
    app.on('dealerWins', -> 
      winnerCheck = true
      assert.equal winnerCheck, check)
    null
