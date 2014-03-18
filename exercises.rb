
require 'pry-debugger'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    if str == 'wishes'
      'nope'
    else
      str+str+str
    end
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
    sum = 0
    array.each do |x|
      sum += x
    end
    return sum
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
    array.each do |x|
      puts "#{x}"
    end
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
    return array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    if array.include? str
      array.push(str)
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO

    people.each do |x|
      x.each do |hey, dude|
        puts "#{dude}"
      end
    end

  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    if time % 400 == 0 || time % 4 == 0
      if time % 100 == 0
        false
      else
        true
      end
    else
      false
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
@@output = 0
attr_accessor :player1, :player2, :player1choice, :player2choice, :winner
def initialize(player1,player2)
  @player1 ||= []
  @player2 ||= []
  @player1 << player1
  @player2 << player2
  @player1[1] = 0
  @player2[1] = 0
end

def play(player1choice=nil, player2choice=nil)
  if @player2[0] == "computer"
    @player1choice = player1choice
    random_play = rand(1..3)
    if random_play == 1
      @player2choice = "paper"
    elsif random_play == 2
      @player2choice = "rock"
    elsif random_play == 3
      @player2choice = "scissors"
    end
  else
  @player1choice = player1choice
  @player2choice = player2choice
  end

  @winner = nil

  if @player1choice == @player2choice
    puts = "The game is a tie!"
  elsif @player1choice == "paper" && @player2choice == "rock"
    puts "Paper beats rock! Player 1 wins!"
    @player1[1] += 1
      if @player1[1] == 2
      @winner = @player1[0]
      puts "Game over. #{@@winner} wins!"
      end
  elsif @player1choice == "paper" && @player2choice == "scissors"
    puts "Scissors beats paper! Player 2 wins!"
    @player2[1] += 1
      if @player2[1] == 2
      @winner = @player2[0]
      puts "Game over. #{@winner} wins!"
      end
  elsif @player1choice == "rock" && @player2choice == "scissors"
    puts "Rock beats scissors! Player 1 wins!"
    @player1[1] += 1
      if @player1[1] == 2
      @winner = @player1[0]
      puts "Game over. #{@winner} wins!"
      end
  elsif @player1choice == "rock" && @player2choice == "paper"
    puts "Paper beats rock! Player 2 wins!"
    @player2[1] += 1
      if @player2[1] == 2
      @winner = @player2[0]
      puts "Game over. #{@winner} wins!"
      end
  elsif @player1choice == "scissors" && @player2choice == "paper"
    puts "Scissors beats paper! Player 1 wins!"
    @player1[1] += 1
      if @player1[1] == 2
      @winner = @player1[0]
      puts "Game over. #{@winner} wins!"
      end
  elsif @player1choice == "scissors" && @player2choice == "rock"
    puts "Rock beats scissors! Player 2 wins"
    @player2[1] += 1
      if @player2[1] == 2
      @winner = @player2[0]
      puts "Game over. #{@winner} wins!"
    end
  end
end
end


require 'io/console'
class RPSPlayer
  attr_accessor :winner
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
    print "Please enter the amount of players(1 or 2):"
    player_amount = gets.chomp
    player_amount

    if player_amount.to_i == 2
    print "Please enter a name for player 1:"
    player1 = gets.chomp
    print "Please enter a name for player 2:"
    player2 = gets.chomp
    # TODO
    game = RPS.new(player1, player2)

  while game.winner == nil do
    puts "Please enter a choice for player 1:"
    player1choice = STDIN.noecho(&:gets).chomp
    puts "Please enter a choice for player 2:"
    player2choice = STDIN.noecho(&:gets).chomp

    game.play(player1choice, player2choice)
  end

    else
      print "Please enter a name for player 1:"
      player1 = gets.chomp
      game = RPS.new(player1, "computer")

    while game.winner == nil do
      puts "Please enter rock, paper, or scissors:"
      player1choice = gets.chomp

      game.play(player1choice, player2choice=nil)
    end

    end

    if game.winner
    puts "Would you like to play another game?"
    another_game = gets.chomp
    if another_game == "y" || another_game == "yes"
      RPSPlayer.start
    else
      puts "Goodbye!"
    end
    end

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
