
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    str*3
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
    array[1]
    # TODO
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    sum = 0
    array.each do |x|
      sum+=x
    end
    sum
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
    array.each{|x| puts x}
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    unless array.include?("panda")
      array.push("panda")
    else 
      array.push("GODZILLA")
    end
    
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    if array.include?(str)
      array.push(str)
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each{|x| puts "#{x[:name]}: #{x[:occupation]}"}
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    time = DateTime.now
    Date.leap?(time.year)
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
  attr_reader :count2, :count1, :name1, :name2, :gameover, :winner
  def initialize (name1,name2)
    @name1 = name1
    @name2 = name2
    @count1 = 0
    @count2 = 0
    @gameover = false
    @winner = ""
  end

  def winner
    if @count1 == 2
      @winner = @name1
      puts "#{@winner} is the winner!"
    elsif @count2 == 2
      @winner = @name2
      puts "#{@winner} is the winner!"
    end
    end

  def play (choice1,choice2)
    if @count2 >= 2 || @count1 >= 2
    puts "Game already over!"
     elsif choice1 == choice2
        puts "It's a tie!"
        elsif choice1 == "scissors" && choice2 == "rock"
        puts "#{@name2} wins!"
        @count2+=1
        elsif choice1 == "scissors" && choice2 == "paper"
        puts "#{@name1} wins!"
        @count1+=1
        elsif choice1 == "rock" && choice2 == "scissors"
        puts "#{@name1} wins!"
        @count1+=1
        elsif choice1 == "rock" && choice2 == "paper"
        puts "#{@name2} wins!"
        @count2+=1
        elsif choice1 == "paper" && choice2 == "rock"
        puts "#{@name1} wins!"
        @count1+=1
        elsif choice1 == "paper" && choice2 == "scissors"
        puts "#{@name2} wins!"
        @count2+=1

        end
         if @count1 == 2 || @count2 == 2
          @gameover = true
          puts "Game is now over!"
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
  def start

    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
   

   puts "1st player's name?"
   player1 = STDIN.noecho(&:gets)
   puts "2nd player's name?"
   player2 = STDIN.noecho(&:gets)

   newgame = RPS.new(player1, player2)
while newgame.gameover == false
    puts "1st player, whats your move?"
    move1 = STDIN.noecho(&:gets).chomp
    puts "2nd player,s what's your move?"
    move2 = STDIN.noecho(&:gets).chomp

    newgame.play(move1, move2)
    newgame.winner
    end

   

    puts "Do you want to play again?"
    response =STDIN.noecho(&:gets)
    if response == "yes"
      puts "1st player's name?"
      player1 = STDIN.noecho(&:gets).chomp
      puts "2nd player's name?"
      player2 = STDIN.noecho(&:gets).chomp
      newgame2=RPS.new(player1, player2)
  while newgame2.gameover == false
    puts "1st player, whats your move?"
    move1 = STDIN.noecho(&:gets).chomp
    puts "2nd player,s what's your move?"
    move2 = STDIN.noecho(&:gets).chomp

    newgame2.play(move1, move2)
    newgame2.winner
    end
  else 
    puts "Thanks for playing!"
  end

  end
end

RPSPlayer.new.start


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
