
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if str == 'wishes'
      'nope'
    else
      str+str+str
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
    array.inject(:+)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each {|x| puts x}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array[-1] == 'panda'
      array[-1] = 'GODZILLA'
    else
      array[-1] = 'panda'
    end
    array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    array.push(str) if array.include?(str)
    array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |x|
      puts x[:name]
      puts x[:occupation]
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    if (time % 400) != 0 && (time % 100) == 0
      false
    elsif (time % 4) == 0
      true
    else
      false
    end
  end
end

  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string represents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.

class RPS
  attr_reader :player1, :player2

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @player1_wins = 0
    @player2_wins = 0
    @valid = ["rock", "paper", "sissors"]
    @winner = nil
  end

  def play(choice1,choice2)

    #check if choices are valid
    raise "Invalid choice. Try 'rock', 'pape', or 'sissors'." unless @valid.include?(choice1) && @valid.include?(choice2)

    case
      # check if game is over
      when @player1_wins >= 2 || @player2_wins >= 2
        raise "Sorry, this game is over. #{@winner} was the winner of the game."

      # when choices match
      when choice1 == choice2 
        raise "The result is a tie! Play again!"

      # when player 1 wins
      when choice1 == "rock" && choice2 == "sissors"
        @player1_wins += 1
        puts "Rock beats sissors. #{@player1} wins the round!"
      when choice1 == "sissors" && choice2 == "paper"
        @player1_wins += 1
        puts "Sissors beats paper. #{@player1} wins the round!"
      when choice1 == "paper" && choice2 == "rock"
        @player1_wins += 1
        puts "Paper beats rock. #{@player1} wins the round!"

      #when player 2 wins
      when choice1 == "sissors" && choice2 == "rock"
        @player2_wins += 1
        puts "Rock beats sissors. #{@player2} wins the round!"
      when choice1 == "paper" && choice2 == "sissors"
        @player2_wins += 1
        puts "Sissors beats paper. #{@player2} wins the round!"
      when choice1 == "rock" && choice2 == "paper"
        @player2_wins += 1
        puts "Paper beats rock. #{@player2} wins the round!"
    end

    if @player1_wins >= 2
      puts "The winner of the game is #{@player1}!"
      @winner = @player1
    elsif @player2_wins >= 2
      puts "The winner of the game is #{@player2}!"
      @winner = @player2
    end

    @winner

  end

end

require 'io/console'
class RPSPlayer
  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again.
  def initialize
  def start

    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
  end
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
    # TODO
  end
end
