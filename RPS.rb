class RPS
  attr_accessor :playerOne, :playerTwo
  attr_reader :playerOneScore, :playerTwoScore, :gameOver, :gameWinner, :gameLoser

  def initialize(playerOne, playerTwo)
    @playerOne = playerOne
    @playerTwo = playerTwo
    @playerOneScore = 0
    @playerTwoScore = 0
    @gameOver = false
    @gameWinner = nil
    @gameLoser = nil
  end

  def play(moveOne, moveTwo)

    if @gameOver then return "Game is over dummy" end

    if moveOne == moveTwo
      return "Tie Try Again"
    end

    if (moveOne == "rock")
      if (moveTwo == "scissors")
        winner = 1
      else #moveTwo == "paper"
        winner = 2
      end

    elsif (moveOne == "paper")
      if (moveTwo == "scissors")
        winner = 2
      else  # moveTwo == Rock
        winner = 1
      end

    else #moveOne == "scissors"
      if (moveTwo == "paper")
        winner = 1
      else  #moveTwo == "rock"
        winner = 2
      end
    end





    puts "Winner = #{winner}"
    if winner == 1
      @playerOneScore += 1
      if @playerOneScore == 2
        @gameOver = true
        @gameWinner = "Player One"
        @gameLoser = "Player Two"
        return "#{playerOne} Wins the Game"
      else
        return "#{playerOne} Wins the Round"
      end
    else
      @playerTwoScore += 1
      if @playerTwoScore == 2
        @gameOver = true
        @gameWinner = "Player Two"
        @gameLoser = "Player One"
        return "#{playerTwo} Wins the Game"
      else
        return "#{playerTwo} Wins the Round"
      end
    end
  end
end
