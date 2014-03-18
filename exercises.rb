
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    if str == "wishes"
      "nope"
    else
      str * 3
    end


  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO
    number = array.length
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    # TODO
    second = array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    array.inject{ |sum, n| sum + n }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    # TODO
    sorted_array = array.sort_by {|num| num}
    sorted_array[-1]
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each do  |word|
      puts word

    end
    # return array
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    if array[-1] == "panda"
      array[-1] = "GODZILLA"
      p array
    else
      array[-1] = str
      p array
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    if array.include?(str)
      array << str
    else
      nil
    end

  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each do |hash|
      puts "#{hash[:name]}" + " is a " + "#{hash[:occupation]}"
    end

  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO

    if time % 400 == 0
      true
    elsif time % 100 == 0
      false
    elsif time%4 == 0
      true
    else
      false
    end

# if year is divisible by 400 then leap year
# else if year is divisible by 100 then common year
# else if year is divisible by 4 then leap year
# else common year
  #   if time%400 == 0 && time%4== 0
  #     true
  #   else
  #     false
  #   end
  # end

  end

end


class RPS
  attr_accessor :player1, :player2, :player1wincount, :player2wincount
  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @player1wincount = 0
    @player2wincount = 0
  end
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

  def play(choice1,choice2)
    if player1wincount >= 2 || player2wincount >= 2
      return "this game is over, start a new one sucka"
    end
    if choice1 == "rock" && choice2 == "scissors"
      @player1wincount += 1
      if @player1wincount == 2
        return @player1 + " is the complete and utter victor"
      end
      return @player1 + " wins"
    elsif choice1 == "rock" && choice2 == "paper"
      @player2wincount += 1
      if @player2wincount == 2
        return @player2 + " is the complete and utter victor"
      end
      return @player2 + " wins"
    elsif choice1 == "rock" && choice2 == "rock"
      return "Tie game!"
    elsif choice1 == "scissors" && choice2 == "paper"
      @player1wincount += 1
      if @player1wincount == 2
        return @player1 + " is the complete and utter victor"
      end
      return @player1 + " wins"
    elsif choice1 == "scissors" && choice2 == "rock"
      @player2wincount += 1
      if @player2wincount == 2
        return @player2 + " is the complete and utter victor"
      end
      return @player2 + " wins"
    elsif choice1 == "scissors" && choice2 == "scissors"
      return "Tie game!"
    elsif choice1 == "paper" && choice2 == "scissors"
      @player2wincount += 1
      if @player2wincount == 2
        return @player2 + " is the complete and utter victor"
      end
      return @player2 + " wins"
    elsif choice1 == "paper" && choice2 == "rock"
      @player1wincount += 1
      if @player1wincount == 2
        return @player1 + " is the complete and utter victor"
      end
      return @player1  + " wins"
    elsif choice1 == "paper" && choice2 == "paper"
     return "Tie game!"
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
  attr_reader :player1, :player2
  def initialize
    puts "What is the first player's name"
    @player1 = gets.chomp
    puts "What is the second player's name"
    @player2 = gets.chomp
    newgame = RPS.new(@player1,@player2)

    until (newgame.player1wincount == 2 || newgame.player2wincount == 2) do
      puts "What is your move, player 1?"
      @choice1 = gets.chomp
      puts "What is your move, player 2?"
      @choice2 = gets.chomp
      puts newgame.play(@choice1,@choice2)
      puts newgame.player1wincount

      if (newgame.player1wincount == 2 || newgame.player2wincount == 2)
        puts "Want to player another game? yes or no"
        var = gets.chomp
        if var == "yes"
          newgame.player1wincount = 0
          newgame.player2wincount = 0
        end
      end
    end


  end



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
    # TODO
  end
end
