require 'time'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    str == 'wishes' ? "nope": str*3
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO
    array.length
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    # TODO
    array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    array.inject{|memo, i| memo + i}
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    # TODO
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    # TODO
    array.each do |i|
      puts i
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    if array.last == 'panda'
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
    # TODO
    if array.include?(str)
      array.push(str)
    end
    array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each do |person|
      puts person[:name] + ": " + person[:occupation]
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
  time.year % 4 == 0 ? true : false
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

  attr_reader :player1, :player2, :num_rounds, :p1_wins, :p2_wins

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @p1_wins = 0
    @p2_wins = 0
  end

  def play(p1_move, p2_move)
  # don't forget draws
  return "Draw! Play again!" if p1_move == p2_move

  if @p1_wins >= 2 || @p2_wins >=2
    return "The game is over."
  end

    if (p1_move == "rock")
      winner = p2_move == "scissors" ? player1 : player2
      winner == player1 ? @p1_wins+=1 : @p2_wins +=1
      if @p1_wins >= 2
        winner + " wins the game!"
      elsif @p2_wins >= 2
        winner + " wins the game!"
      else
        winner + " wins the round!"
      end
    elsif (p1_move == "paper")
        winner = p2_move == "rock" ? player1 : player2
        winner == player1 ? @p1_wins+=1 : @p2_wins +=1
        if @p1_wins >= 2
        winner + " wins the game!"
        elsif @p2_wins >= 2
        winner + " wins the game!"
        else
        winner + " wins the round!"
        end
    else
      winner = p2_move == "paper" ? player1 : player2
      winner == player1 ? @p1_wins+=1 : @p2_wins +=1
      if @p1_wins >= 2
        winner + " wins the game!"
      elsif @p2_wins >= 2
        winner + " wins the game!"
      else
        winner + " wins the round!"
      end
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

    puts "Enter your name, Player 1: "
    player_1 = gets.chomp
    puts "Enter your name, Player 2: "
    player_2 = gets.chomp

    @game = RPS.new(player_1, player_2)

    winner = ""

    loop do
      puts "Enter your move " + player_1 + ":"
      p1move = STDIN.noecho(&:gets)
      p1move = p1move.chomp
      puts "Enter your move " + player_2 + ":"
      p2move = STDIN.noecho(&:gets)
      p2move = p2move.chomp
      winner = @game.play(p1move, p2move)
      puts winner
      break if winner == "The game is over." || winner.split.last == "game!"
    end
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
