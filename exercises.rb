require 'time'
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if (str == 'wishes')
      'nope'
    else
      str * 3
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
    array.inject {|sum, x| sum + x}
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each {|elem| puts elem}
    #puts array
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array, str)
    last_element = Exercises.ex1(array) - 1

    if (array[last_element] == "panda")
      array[last_element] = "GODZILLA"
    else
      array[last_element] = "panda"
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include? (str)
      array.push(str)
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |person|
      puts "#{person[:name]}, #{person[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    if (time.year % 4 == 0)
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
  attr_reader :player_one, :player_two
  def initialize(p1, p2)
    @player_one = {name: p1, wins: 0}
    @player_two = {name: p2, wins: 0}
  end
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games

  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.
    def play(move_one, move_two)
      if (@player_one[:wins] >= 2 || @player_two[:wins] >= 2)
        return 'The game is already over! it\'s best 2 out of 3'
      elsif (move_one == 'rock' && move_two == 'rock')
        winner = 'tie'
      elsif (move_one == 'rock' && move_two == 'paper')
        winner = @player_two
        @player_one[:wins] += 1
      elsif (move_one == 'rock' && move_two == 'scissors')
        winner = @player_one
        @player_one[:wins] += 1
      elsif (move_one == 'paper' && move_two == 'rock')
        winner = @player_two
        @player_two[:wins] += 1
      elsif (move_one == 'paper' && move_two == 'paper')
        winner = 'tie'
      elsif (move_one == 'paper' && move_two == 'scissors')
        winner = @player_two
        @player_two[:wins] += 1
      elsif (move_one == 'scissors' && move_two == 'rock')
        winner = @player_two
        @player_two[:wins] += 1
      elsif (move_one == 'scissors' && move_two == 'paper')
        winner = @player_one
        @player_one[:wins] += 1
      elsif (move_one == 'scissors' && move_two == 'scissors')
        winner = 'tie'
      end
      winner
  end
end


require 'io/console'
class RPSPlayer
  def initialize
  end
  def start
    print 'enter player 1 name: '
    p1_name = gets.chomp
    print 'enter player 2 name: '
    p2_name = gets.chomp
    # puts "before game_count"
    game_count = 0
    # puts "before play_count"
    play_game = "yes"

    # puts "before the hashes"
    player_one = p1_name
    player_two = p2_name

    #binding.pry
    # puts "before instantiation"
    game = RPS.new(player_one, player_two)
    # puts "after instantiation"
    while (play_game == 'yes')
      while (game_count < 5)

        print "#{p1_name} choose your weapon: "
        move_one = gets.chomp
        print "#{p2_name} choose your weapon: "
        move_two = gets.chomp
        outcome = game.play(move_one, move_two)

        scoreboard.push(outcome[:name])

        if (outcome != 'tie')
          puts "AND THE WINNER IS... #{outcome[:name]}"
        else
          puts outcome
        end

        game_count += 1

      end

      print "do you want to play again?"
      play_game = gets

    end
  end
end
#   (No specs are required for RPSPlayer)

#   Complete the `start` method so that it uses your RPS class to present
#   and play a game through the terminal.

#   The first step is to read (gets) the two player names. Feed these into
#   a new instance of your RPS class. Then `puts` and `gets` in a loop that
#   lets both players play the game.

#   When the game ends, ask if the player wants to play again.


#     TODO

#     PRO TIP: Instead of using plain `gets` for grabbing a player's
#              move, this line does the same thing but does NOT show
#              what the player is typing! :D
#     This is also why we needed to require 'io/console'
#     move = STDIN.noecho(&:gets)


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
    temp_array = []
    temp_hash = Hash.new(0)
    extremes_hash = Hash.new(0)

    array.each do |elem|
      temp_hash[elem] += 1
    end

   temp_keys = temp_hash.keys
   temp_values = temp_hash.values
   most_index = temp_values.find_index(temp_hash.values.max)

   extremes_hash[:most] = temp_keys[most_index]

    temp_hash.each do |k,v|
      if k != temp_keys[most_index]
        temp_array.push(k)
      end
    end

    extremes_hash[:least] = temp_array

    extremes_hash
  end
end
