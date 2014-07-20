
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    raise ArgumentError unless str.is_a?(String)
    str != 'wishes' ? str*3 : "nope"
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    array.is_a?(Array) ? array.count : (raise ArgumentError)
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array.is_a?(Array) ? array[1] : (raise ArgumentError)
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    array.is_a?(Array) ? array.inject(:+) : (raise ArgumentError)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    raise ArgumentError unless array.is_a?(Array)
    array.reject {|num| !num.is_a?(Fixnum)}.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.is_a?(Array) ? array.each {|element| puts element} : (raise ArgumentError)
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    raise ArgumentError unless array.is_a?(Array)
    array.last == 'panda' ? (array[-1] = 'GODZILLA') : (array[-1] = 'panda')
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    raise ArgumentError unless array.is_a?(Array) && str.is_a?(String)
    array.include?(str) ? array.push(str) : array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.is_a?(Array) ? people.map {|k,v| "#{k}, #{v}"}.join : (raise ArgumentError)
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    Date.leap?(DateTime.now.year)
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
  attr_reader :player1, :player2
  attr_accessor :winner_array, :game_over
  def initialize(args={})
    @player1 = args[:player1]
    @player2 = args[:player2]
    @winner_array = []
    @game_over = false
  end

  def play(player1_move, player2_move)
    @game_over = false
    return 'invalid move' unless player1_move.match(/rock|paper|scissors/) || player2_move.match(/rock|paper|scissors/)
    winner_array << winning_move(player1_move, player2_move)
    if winner_array.count(player1) == 2 || winner_array.count(player2) == 2
      winner = final_winner(winner_array)
      puts "#{winner} is the ultimate champion!"
      @winner_array = []
      play_again
      winner
    else
      puts "#{winning_move(player1_move, player2_move)} wins this round!"
      winning_move(player1_move, player2_move)
    end
  end

  def play_again
    puts "Do you want to play again? (y/n)"
    answer = gets.chomp
    answer == 'y' ?  (@game_over = false) : (@game_over = true)
  end

  def winning_move(move1, move2)
    return 'tie' if move1 == move2
    (move1 == 'rock' && move2 == 'paper') || (move1 == 'scissors' && move2 == 'rock') ||
    (move1 == 'paper' && move2 == 'scissors') ? player2 : player1
  end

  def final_winner(array)
    array.delete('tie')
    array.inject(Hash.new(0)) {|res, elem| res[elem] += 1; res }.max_by {|k,v| v}.first
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
  def self.start

    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
    new_game = RPS.new(player1: 'player1', player2: 'player2')
    until new_game.game_over
      puts "#{new_game.player1}, select a move!"
      move1 = STDIN.noecho(&:gets).chomp
      puts "#{new_game.player2}, select a move!"
      move2 = STDIN.noecho(&:gets).chomp
      new_game.play(move1, move2)
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
