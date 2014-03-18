class RPS
  attr_reader :player1, :player2, :winner
  attr_accessor :game_wins, :game_winner

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @game_wins = []
    @game_winner = nil
  end

  def play(choice1, choice2)
    @game_winner = @game_wins.detect { |winner| @game_wins.count(winner) > 1 }

    if @game_winner
      @game_wins = 0
      "Game over! #{@game_winner} wins the game."
    else
      if choice1 == choice2
        "This hand was a tie."
      elsif choice1 == 'rock' && choice2 == 'paper'
        @game_wins << @player2
        "paper beats rock, #{@player2} wins the hand!"
      elsif choice1 == 'rock' && choice2 == 'scissors'
        @game_wins << @player1
        "rock beats scissors, #{@player1} wins the hand!"
      elsif choice1 == 'paper' && choice2 == 'rock'
        @game_wins << @player1
        "paper beats rock, #{@player1} wins the hand!"
      elsif choice1 == 'paper' && choice2 == 'scissors'
        @game_wins << @player2
        "scissors beats paper, #{@player2} wins the hand!"
      elsif choice1 == 'scissors' && choice2 == 'rock'
        @game_wins << @player2
        "rock beats scissors, #{@player2} wins the hand!"
      elsif choice1 == 'scissors' && choice2 == 'paper'
        @game_wins << @player1
        "scissors beats paper, #{@player1} wins the hand!"
      else
        "Invalid choice. Enter 'rock', 'paper' or 'scissors'"
      end
    end
  end
end


require 'io/console'
class RPSPlayer

  def self.start
    print "Player 1 enter your name: "
    player1 = gets.chomp.capitalize
    print "Player 2 enter your name: "
    player2 = gets.chomp.capitalize

    game = RPS.new(player1, player2)

    until game.game_winner
      puts "Enter your choice #{player1}: "
      choice1 = STDIN.noecho(&:gets).chomp
      puts "Enter your choice #{player2}: "
      choice2 = STDIN.noecho(&:gets).chomp
      puts game.play(choice1, choice2)
    end

    if game.game_winner
      print "Do you want to play again? "
      answer = gets.chomp.downcase
      if answer == 'yes' || answer == 'y'
        puts "Great lets start again"
        RPSPlayer.start
      else
        puts "Good bye!"
      end
    end
  end
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