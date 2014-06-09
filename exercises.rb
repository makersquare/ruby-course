
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if str == 'wishes'
      return 'nope'
    else
      return str+str+str
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
    array.inject(0){|element, result| element + result}
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each do |x|
      puts x 
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array.last == 'panda'
      array.pop
      array << 'GODZILLA'
    else
      array.pop
      array << 'panda'
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include?(str) 
      array << str
      return array
    else
      array
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and puts out their name and occupation.
  def self.ex8(people)
    people.each{ |hash| puts "#{hash[:name]}: #{hash[:occupation]}"}
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    if time%4 == 0 and time%100 != 0
      return true
    elsif time%100 == 0 and time%400 == 0
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
  attr_reader :player1, :player2, :player1win, :player2win, :total
  def initialize (player1, player2)
    @player1 = player1
    @player2 = player2
    @player1win = 0
    @player2win = 0
    @total = 0
  end

  def play (move1, move2)
    move1 = move1.downcase
    move2 = move2.downcase
    # raise :error if move1 != "rock" || move1 != "paper" || move1 != "scissors"
    # raise :error if move2 != "rock" || move2 != "paper" || move2 != "scissors"
    if move1 == 'rock' && move2 == 'paper'
      return :player2
    elsif move1 == 'rock' && move2 == 'scissors'
      return :player1
    elsif move1 == 'paper' && move2 == 'rock'
      return :player1
    elsif move1 == 'paper' && move2 == 'scissors'
      return :player2
    elsif move1 == 'scissors' && move2 == 'rock'
      return :player2
    elsif move1 == 'scissors' && move2 == 'paper'
      return :player1
    else
      return :tie
    end

    # @total += 1

    # if @total >= 3 and player1win >=2
    #   puts player1 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total >=3 and player2win >=2
    #   puts player2 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total == 2 and player1win == 2
    #   puts player1 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total == 2 and player2win == 2
    #   puts player2 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # end
  end
end

# Nick's solution:

# Class RPS
#   @beats = {
#     rock: :paper,
#     paper: :scissors,
#     scissors: :rock
#   }

#   def play p1, p2
#     if p1 == @beats[p2]
#       puts "p1 wins"
#     elsif p2 == @beats[p1]
#       puts "p2 wins"
#     else
#       puts "tie"
#     end
#   end

# end


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
    p1_wins = 0
    p2_wins = 0
  end



  def self.start
    puts "Player 1 Name: "
    player1 = gets.chomp
    puts "Player 2 Name: "
    player2 = gets.chomp
    rps_game = RPS.new(player1, player2)    
    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)


    while (true)
      puts "Player 1 Move: "
      move1 = STDIN.noecho(&:gets).chomp
      puts "Player 2 Move: "
      move2 = STDIN.noecho(&:gets).chomp
      rps_game.play(move1, move2)

      winner = rps_game.play(move1, move2)

      if winner == :player1
        puts "#{player1} wins!"
        p1_wins += 1
      elsif winner == :player2
        p2_wins += 1
      else
        puts "tie"
      end

      break if p1_wins == 2 || p2_wins == 2
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
