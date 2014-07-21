
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    if (str != 'wishes')
      str*3
    else
      'nope'
    end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO
    array.count
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
    array.inject(0) {|s,n| s+n}
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
    array.each {|x| puts x}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    if array[-1] != 'panda'
      array[-1] = 'panda'
    else
      array[-1] = 'GODZILLA'
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    array.push('str') if array.include? str
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each do |person|
      puts person[:name]
      puts person[:occupation]
    end

  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    if (time % 100 == 0)
      if (time%400 == 0)
        return true
      else
        return false
      end
    elsif time % 4 == 0
      return true
    else
      return false
    end
        
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
  @@moves = ['rock','paper','scissors']

  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @games = {total: 0, player1: 0, player2: 0}
  end

  def play(move1,move2)
    if (@games[:total] != 3)
      @games[:total] += 1
      if ((@@moves.include? move1.downcase) && (@@moves.include? move2.downcase))
        move1 = move1.downcase
        move2 = move2.downcase
        if (move1 == move2)
          puts "TIE"
        elsif ((move1 == 'rock' && move2 == 'paper')||(move1 == 'paper' && move2 == 'scissors')||(move1 == 'scissors' && move2 == 'rock'))
          puts "#{@player2} wins!"
        else
          puts "#{@player1} wins!"
        end
      else
        puts "One or both players are using invalid moves."
      end
    elsif (@games[:total] == 3)
      (@games[:player1] > @games[:player2]) ? (puts "%s wins!" % @player1) : (puts "%s wins!" % @player2)
    else
      puts "Game is already over."
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
  @@moves = ['rock','paper','scissors']

  def initialize
    @player1 = nil
    @player2 = nil
    @games = {total: 0, player1: 0, player2: 0}
  end
  
  def start
    puts "Type your name, player 1:"
    @player1 = gets.chomp
    puts "Type your name, player 2:"
    @player2 = gets.chomp
    puts "Select your move, #{@player1}:"
    move1 = STDIN.noecho(&:gets)
    puts "Select your move, #{@player2}:"
    move2 = STDIN.noecho(&:gets)
    if (@games[:total] != 3)
      @games[:total] += 1
      if ((@@moves.include? move1.downcase) && (@@moves.include? move2.downcase))
        move1 = move1.downcase
        move2 = move2.downcase
        if (move1 == move2)
          puts "TIE"
        elsif ((move1 == 'rock' && move2 == 'paper')||(move1 == 'paper' && move2 == 'scissors')||(move1 == 'scissors' && move2 == 'rock'))
          puts "#{@player2} wins!"
        else
          puts "#{@player1} wins!"
        end
      else
        puts "One or both players are using invalid moves."
      end
    elsif (@games[:total] == 3)
      (@games[:player1] > @games[:player2]) ? (puts "%s wins!" % @player1) : (puts "%s wins!" % @player2)
    else
      puts "Game is already over."
    end
    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)

  end
end
game = RPSPlayer.new
game.start

module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occurs the most # of times as its value.
  #    :least => the string(s) that occurs the least # of times as its value.
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
