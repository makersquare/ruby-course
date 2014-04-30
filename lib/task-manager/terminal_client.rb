class TM::TerminalClient
  attr_accessor :answer

  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "Available Commands:
          help - Show these commands again
          list - List all projects
          create NAME - Create a new project with name=NAME
          show PID - Show remaining tasks for project with id=PID
          history PID - Show completed tasks for project with id=PID
          add PID PRIORITY DESC - Add a new task to project with id=PID
          mark TID - Mark task with id=TID as complete
          exit - exits project manager"
    puts "Enter a choice: "
    @answer = gets.chomp.downcase.split(' ')
    @choice = @answer[0]
    run(@choice)
  end

  def run(answer)
    case answer
        #lists all available commands
      when 'help'
        puts "Available Commands:
              help - Show these commands again
              list - List all projects
              create NAME - Create a new project with name=NAME
              show PID - Show remaining tasks for project with id=PID
              history PID - Show completed tasks for project with id=PID
              add PID PRIORITY DESC - Add a new task to project with id=PID
              mark TID - Mark task with id=TID as complete
              exit - exits project manager"
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #lists all projects
      when 'list'
        TM::Project.list_all
        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #creates a new project with inputted name
      when 'create'
        TM::Project.new(@answer[1])
        puts "Project #{@answer[1]} Created. Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @choice[0]
        run(@choice)
        #shows incomplete tasks for inputted project
      when 'show'
        TM::Project.show_incomplete_tasks(@answer[1].to_i)

        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #shows completed tasks for inputted project
      when 'history'
        TM::Project.show_completed_tasks(@answer[1].to_i)

        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #adds a new task with PID PRIORITY DESC
      when 'add'


        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #marks task with inputted id as complete
      when 'mark'
        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #ending the task manager
      when 'exit'
        puts "Goodbye"
        #command is not valid
      else
        puts "That was not a valid option. Please enter another option. "
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
      end
    end
end
