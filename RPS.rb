class RPS
  attr_accessor :playerOne, :playerTwo

  def initialize(playerOne, playerTwo)
    @playerOne = playerOne
    @playerTwo = playerTwo
    @playerOneScore = 0
    @playerTwoScore = 0
    @gameOver = false
    @gameWinner = nil
  end

  def play(moveOne, moveTwo)
    if @gameOver then return "Game is over dummy" end

    if moveOne == "rock"
      if moveTwo == "rock"
        return "Tie try again"
      elsif moveTwo == "paper"
        winner = playerTwo
      elsif moveTwo == "scissors"
        winner = playerOne
      end
    end

    if winner = playerOne
      @playerOneScore += 1
      if @playerOneScore == 2
        @gameOver = true
        @gameWinner = "Player One"
        return "#{playerOne} Wins the Game"
      else
        return "#{playerOne} Wins the Round"
      end
    else
      @playerTwoScore += 1
      if @playerTwoScore == 2
        @gameOver = true
        @gameWinner = "Player Two"
        return "#{playerTwo} Wins the Game"
      else
        return "#{playerTwo} Wins the Round"
      end
    end
  end
end
