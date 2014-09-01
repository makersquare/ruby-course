
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if str == "wishes"
      'nope'
    else
      x = str * 3
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
    array.inject(:+)
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
  def self.ex6(array)
    if array[-1] == 'panda'
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
    array << str if array.include?(str)
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |p|
      print "#{p[:name]}: #{p[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    ((time % 4).zero? && !((time % 100).zero?)) || (time % 400).zero?
  end

  def self.ex10
    hr = Time.now.hour
    return "happy hour" if hr == 16 || hr ==17
    'normal prices'
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
    count_hash = Hash.new(0)

    array.each do |x|
      count_hash[x] = count_hash[x] + 1
    end

    max_repeat_value = count_hash.values.max
    min_repeat_value = count_hash.values.min

    hash_min = count_hash.select {|k,v| v == min_repeat_value}
    hash_max = count_hash.select {|k,v| v == max_repeat_value}

    if hash_min.keys.count == 1
      min_string = hash_min.keys[0]
    else
      min_string = hash_min.keys
    end

    if hash_max.keys.count == 1
      max_string = hash_max.keys[0]
    else
      max_string = hash_max.keys
    end

    {
      :most => max_string,
      :least => min_string
    }
  end
end
