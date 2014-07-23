
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
     if str == "wishes"
        return "nope"
      else 
           3.times do 
           puts str
          end  
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
    sum = 0 
    array.each {|x| sum+=x}
    sum 
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
   max = array[0]
   array.each do |x| 
     if x > max
       max = x
     end 
   end 
    max 
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each {|x| x}
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
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    array.include? str
    array.push(str)
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    print "#{people.keys} + "" #{people.values}"
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    if time % 4 != 0 
      false
    elsif  time %100 !=0
      true
    elsif time % 400 !=0
    false
    else 
      true
    end   
  end
end


class RPS

def initialize(player1, player2)
  @player1 = player1
  @player2 = player2
  @count_player1 = 0
  @count_player2 = 0
end

def play(opt1, opt2)
  if opt1 == "rock"
      if opt2 == "paper"
         @count_player1 +=1
         puts "#{player1} wins"
      elsif opt2 == "scissors"
         @count_player2 +=1
          puts "#{player2} wins"
      elsif opt2 == "rock"
        puts "they tie"
      else nil
      end 

    elsif opt1 == "paper"
        if opt2 == "scissors"
           @count_player2 +=1
         puts "#{player2} wins"
         player2
      elsif opt2 == "rock"
         @count_player1 +=1
          puts "#{player1} wins"
          player1
      elsif opt2 == "paper"
        puts "they tie"
      else nil
      end


    elsif opt1 == "scissors"
        if opt2 == "paper"
           @count_player1 +=1
         puts "#{player1} wins"
         player1
      elsif opt2 == "rock"
         @count_player2 +=1
          puts "#{player2} wins"
          player2
      elsif opt2 == "scissors"
        puts "they tie"
      else nil
      end 
    else 
      nil 
    end 
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
    # TODO
  end
end

# p Exercises.ex0("hello")

# p Exercises.ex0("wishes")

# p Exercises.ex1(["wishes", "hope"])

p Exercises.ex6(['ciao', 'hello', 'panda'])

p Exercises.ex7(['ciao', 'hello', 'panda'], "ciaoooo")

# p Exercises.ex2("wishes")



# p Exercises.ex3([1,2,3])
# p Exercises.ex4([-4,-2,3])

# puts  Exercises.ex5(["wishes", "hope"])



