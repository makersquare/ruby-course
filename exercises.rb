require 'time'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
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
    array.inject {|result, element| result + element}
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
    array.each { |element| puts element}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array, str)
    # TODO
    if array[-1] == str
      array[-1] = "GODZILLA"
    else
      array[-1] = str
    end

  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    if array.include?(str)
      array << str
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each { |person| puts person[:name], person[:occupation]}
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    if time.year % 4 == 0
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
  attr_reader :player1, :player2, :players
  attr_accessor :winner
  def initialize(player1, player2)
    @player1 = {name: player1, wins: 0}
    @player2 = {name: player2, wins: 0}
    @players = [@player1, @player2]
  end

  def play(play1, play2)
    
    if play1 == play2
      winner = "tie"
    elsif play1 == "rock" && play2 == "scissors"
      winner = @player1
      @player1[:wins] += 1
    elsif play1 == "paper" && play2 == "rock"
      winner = @player1
      @player1[:wins] += 1
    elsif play1 == "scissors" && play2 == "paper"
      winner = @player1
      @player1[:wins] += 1
    else
      winner = @player2
      @player2[:wins] += 1
    end
    return winner
  end

end


require 'io/console'
class RPSPlayer
  attr_accessor :winner
  
  def start
    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
    
    print "Enter player 1 name: "
      name1 = gets
    print "Enter player 2 name: "
      name2 = gets
    game = RPS.new(name1, name2)


    game_count = 0
    play_game = "yes"
    while play_game == "yes"
      while game_count < 3
        puts "#{name1.chomp}: rock, paper, or scissors?"
          # play1 = STDIN.noecho(&:gets)
          play1 = gets.chomp
        puts "#{name2.chomp}: rock, paper, or scissors?"
          # play2 = STDIN.noecho(&:gets)
          play2 = gets.chomp
        @winner = game.play(play1, play2)
        game_count += 1
        puts "#{name1.chomp} played #{play1}. #{name2.chomp} played #{play2}."
        if winner != "tie"
          puts "The winner is #{winner[:name].chomp}."
          puts "End of round #{game_count}."
        else
          puts "This round is tied. End of round #{game_count}."
        end
      end

      if game.player1[:wins] == game.player2[:wins]
        print "Tie game. Nobody wins!"
      elsif game.player1[:wins] > game.player2[:wins]
        print "The winner of the series is #{game.player1[:name].chomp}. "
      else
        print "The winner of the series is #{game.player2[:name].chomp}. "
      end
      puts "Do you want to play again?"
      play_game = gets.chomp
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