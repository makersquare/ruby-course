
module Exercises

  def self.ex0(str)
    if str == 'wishes'
      return "nope"
    else
      return (str * 3)
    end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    array.count
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    array.inject(0) { |sum, x| sum + x }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    max = array[0]
    array.each { |x| if (x > max) then (max = x) end }
    return max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each { |x| puts x }
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array, str)
    if array[-1] == str
      array[-1] = 'GODZILLA'
    else
      array[-1] = str
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include?(str)
      array << str
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |x|
      puts "Name: #{x[:name]}"
      puts "Occupation: #{x[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)

    # get year from time value
    year = time.year

    # Special case for 3/4 of century markers
    if (year % 4 == 0) && (year % 100 == 0) && (year % 400 == 0)
      return true
    elsif (year % 4 == 0) && (year % 100 == 0)
      return false
    elsif (year % 4 == 0)
      return true
    else
      return false
    end
  end
end



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


require 'io/console'
class RPSPlayer

  def start

    # Get names and stuff
    print "Player One What is Your Name: "
    playerOneName = gets.chomp
    print "Player Two What is Your Name: "
    playerTwoName = gets.chomp
    game = RPS.new(playerOneName, playerTwoName)

    # Intro
    puts "\n\nThis is a rock-paper-scissors game to the death."
    puts "\nThe loser will be stabbed with scissors,"
    puts "bludgeoned with a rock,"
    puts "or suffocated in paperwork.\n\nGood luck!\n\n"

    # Loop until gameover
    while(game.gameOver == false) do
      puts "Player One what is your move? Choose carefully."
      playerOneMove = STDIN.noecho(&:gets).chomp
      puts "\nPlayer Two what is your move? Choose carefully."
      playerTwoMove = STDIN.noecho(&:gets).chomp

      puts "playerOneMove: #{playerOneMove}"
      puts "playerTwoMove: #{playerTwoMove}"

      # get result
      result = game.play(playerOneMove, playerTwoMove)
      puts result
    end

    puts "#{game.gameWinner} you get to live..."
    puts "#{game.gameLoser}, however... you are sentenced to:"
    puts "  CORRECTING CSS TYPOS UNTIL YOU ARE DEAD"
    puts "but have a nice day.  Thanks for playing."
  end


  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again

    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)

end


module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)

    counts = Hash.new(0)
    array.each { |x| counts[x.to_sym] += 1 }
    max_keys = counts.select { |k,v| v == counts.values.max }.keys
    min_keys = counts.select { |k,v| v == counts.values.min }.keys

    # convert em to arrays of strings
    max_keys.map! { |x| x.to_s }
    min_keys.map! { |x| x.to_s }

    # convert to solely strings if only one
    if (max_keys.length <= 1)
      max_keys = max_keys[0]
    end
    if (min_keys.length <= 1)
      min_keys = min_keys[0]
    end

    return { most: max_keys, least: min_keys }

  end
end

#PlayerInterface = RPSPlayer.new
#PlayerInterface.start

