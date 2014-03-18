
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)

      if  str == 'wishes'
        'nope'
      else
        str * 3
      end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
     array.length
  end


  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    array.inject{|sum,x| sum + x }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each do |item|
      puts item
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array, str)
    array.last == "panda" ? array[array.size] = "GODZILLA" :array[array.size] = "panda"
  end




  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    array.include? array.push(str)
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each { |person| puts "{person[:name]}: #{person[:occupation]}"}
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    time.year % 4 == 0 ? true :false
  end
end


class RPS
  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.
  attr_reader :player_one_name, :player_two_name, :game_count
  def initialize(player_one_name, player_two_name)
     @player_one_name = player_one_name
     @player_two_name = player_two_name
     @player_one_name_wins = 0
     @player_two_name_wins = 0
     @game_count +=1
  end

  def play(move1, move2)
    move1.downcase!
    move2.downcase!
    @game_count

    if @move1 >= 2 || @move2 >=2
      return "Game over!"
    elsif move1 == move2
      return "It's a tie!"
    elsif move1 == "rock"
      winner = move2 == "paper" ? @player_two_name : @player_one_name
    elsif move1 == "paper"
      winner = move2 == "scissors" ? player_two_name : @player_one_name
    elsif move1 == "scissors"
      winner = move2 == "rock" ? @player_two_name : @player_one_name
    else
      return "Please choose a valid selection."
    end

    if winner == @player_one_name
      @move1 += 1
    else
      @move2 += 1

      winner
    end
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
