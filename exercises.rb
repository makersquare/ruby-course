
require 'time'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if str == 'wishes'
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
    array.inject{|sum,x| sum + x }
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    array.max {|a,b| a <=> b }
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each {|x| puts "I say #{x}"}
    # TODO
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array, str)
    if array[-1] == str
      array[-1] = 'GODZILLA'
    else
      array[-1] = str
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
   blue = array.select {|x| x == str}
   if blue.count >= 1
    blue.count.times{array.push(str)}
  end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
      people.each do |x|
        puts x[:name] + ": " + x[:occupation]
      end

  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    if time.year % 4 == 0
      true
    else
      false
    end
  end
end


class RPS
  def self.play(person_one, person_two)

    if person_one.choice == "rock"
      if person_two.choice == "rock"
        return "Tie"
      elsif person_two.choice == "paper"
        return "Congrats User 2!"

      elsif person_two.choice == "scissors"
        return "Congrats User 1!"
      end
       elsif person_one.choice == "paper"
        if person_two.choice == "rock"
         return "Congrats User 1!"
       elsif person_two.choice == "paper"
         return "Tie"
       elsif person_two.choice == "scissors"
         return "Congrats User 2!"
       end
    elsif person_one.choice == "scissors"
        if person_two.choice == "rock"
         return "Congrats User 2!"
       elsif person_two.choice == "paper"
         return "Congrats User 1!"
       elsif person_two.choice == "scissors"
         return "Tie."
       end
   end
  end
end

require 'io/console'
class RPSPlayer
  def self.start
  while (person_one.score < 2) || (person_two.score < 2)
    puts "What is your name, User 1?"
    name_one = gets.chomp
    puts "What is your name, User 2?"
    name_two = gets.chomp
    puts "What is your play, User 1?"
    choice_one = gets.chomp
    puts "What is your play, User 2?"
    choice_two = gets.chomp

    player_one = Person.new(name_one)
    player_one.choice = choice_one
    player_two = Person.new(name_two)
    player_two.choice = choice_two
    RPS.play(player_one, player_two)
    if  RPS.play(player_one, player_two) == "Congrats User 1!"
      player_one.score += 1
    elsif RPS.play(player_one, player_two) == "Congrats User 2!"
      player_two.score += 1
    end

    if player_one.score == 2
      puts "Game Over. #{player_one.name} wins"
      player_one.score = 0
      player_two.score = 0
    elsif player_two.score == 2
       puts "Game Over. #{player_two.name} wins"
        player_one.score = 0
        player_two.score = 0
    else
      puts "#{player_one.name}: #{player_one.score}.  #{player_two.name}: #{player_two.score}."
    end
  end
end
end

class Person
attr_accessor :choice, :score, :name
def initialize(name)
@choice = nil
@score = 0
@name = name
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
