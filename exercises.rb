
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    str == "wishes" ? "nope" : str * 3
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
    array.inject {|sum,x| sum + x}
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
  def self.ex6(array, str)
    if array[-1] == "panda"
      array[-1] = "GODZILLA"
    else
      array[-1] = str
    end
    return array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.index(str) == nil
      return array
    else
      array[array.length] = str
    end
    return array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |hashes|
      puts "#{hashes[:name]} is a #{hashes[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    time % 4 == 0 ? (return true) : (return false)
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

attr_reader :player1, :player2, :player1_move, :player2_move
attr_accessor :p1_score,:p2_score

  def initialize(player1="playa1", player2="playa2")
    @player1 = player1
    @player2 = player2
    @p1_score = 0
    @p2_score = 0
  end

  def p1_score
    @p1_score
  end

  def p2_score
    @p2_score
  end

  def play(p1_move, p2_move)

    if @p1_score >= 2
      return "#{player1} has already won the game with #{p1_score} wins"
    elsif @p2_score >= 2
      return "#{player2} has already won the game with #{p2_score} wins"
    else

      if p1_move == "rock"
        if p2_move == "paper"
          if @p2_score == 1
            @p2_score += 1
            return "#{player2} wins the game with #{p2_score} wins"
          else
            @p2_score += 1
            return "#{@player2} wins the round"
          end
        elsif p2_move == "scissors"
          if p1_score == 1
            @p1_score += 1
            return "#{player1} wins the game with #{p1_score} wins"
          else
            @p1_score += 1
            return "#{@player1} wins the round"
          end
        else
          return "It's a tie"
        end

      elsif p1_move == "paper"
        if p2_move == "rock"
          if @p1_score == 1
            @p1_score += 1
            return "#{player1} wins the game with #{p1_score} wins"
          else
            @p1_score += 1
            return "#{@player1} wins the round"
          end
        elsif p2_move == "scissors"
          if @p2_score == 1
            @p2_score += 1
            return "#{player2} wins the game with #{p2_score} wins"
          else
            @p2_score += 1
            return "#{@player2} wins the round"
          end
        else
          return "It's a tie"
        end

      elsif p1_move == "scissors"
        if p2_move == "rock"
          if p2_score == 1
            @p2_score += 1
            return "#{player2} wins with #{p2_score} wins"
          else
            @p2_score += 1
            return "#{@player2} wins the round"
          end
        elsif p2_move == "paper"
          if p1_score == 1
            @p1_score += 1
            return "#{player1} wins with #{p1_score} wins"
          else
            @p1_score += 1
            return "#{@player1} wins the round"
          end
        else
          return "It's a tie"
        end
      end

    # else
    #   if @p1_score > @p2_score
    #     return "#{player1} has already won #{p1_score} times"
    #   else
    #     return "#{player2} has already won #{p2_score} times"
    #   end

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
  def self.start
    puts "Enter name of Player 1"
    name1 = gets.chomp
    puts "Enter name of Player 2"
    name2 = gets.chomp

    newgame = RPS.new(name1, name2)

while newgame.p1_score < 2 || newgame.p2_score < 2

    puts "What's your move #{name1}?"
    move1_player1 = gets.chomp

    puts "What's your move #{name2}?"
    move1_player2 = gets.chomp

    newgame.play(move1_player1, move1_player2)

end

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
