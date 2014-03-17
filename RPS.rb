class RPS
  attr_accessor :playerOne, :playerTwo
  attr_reader :playerOneScore, :playerTwoScore

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
        return "Tie Try Again"
      elsif moveTwo == "paper"
        winner = playerTwo
      elsif moveTwo == "scissors"
        winner = playerOne
      end

    elsif moveOne == "paper"
      if moveTwo == "rock"
        winner = playerOne
      elsif moveTwo == "paper"
        return "Tie Try Again"
      elsif moveTwo == "scissors"
        winner = playerTwo
      end

    else #moveOne == "scissors"
      if moveTwo == "rock"
        winner = playerTwo
      elsif moveTwo == "paper"
        winner = playerOne
      else #moveTwo == "scissors"
        return "Tie Try Again"
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
