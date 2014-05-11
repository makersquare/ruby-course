class TM::TerminalClient

  attr_accessor :user

  def initialize
    help
  end

  def help
    @user = user
      puts "  ---------------------------------------------------------------- "
      puts "  Welcome to Project Manager Pro"
      puts " "
      puts "  What can I do for you today?"
      puts " "
      puts "  Available Commands:"
      puts "  ---------------------------------------------------------------- "
      puts " "
      puts "    list - List all projects"
      puts "    create NAME - Create a new project with a name = NAME"
      # puts "    show PID - Shows remaining tasks for project with id = PID"
      # puts "    history PID - Show completed tasks for project with id = PID"
      puts "    new TASK - create new task with (PID, description, priority number)"
      puts "    add PID PRIORITY DESC - Add a new task to project with id = PID"
      puts "    mark TID - Mark task with id = TID as complete"
      puts "    help - Show these commands again"
      puts "    exit - exit Project Manager Pro"
      puts " "
    @user = gets.chomp
    run(@user)
  end

  def run(input)
    case user
      when "list"
        TM::Project.all_projects
      when "create NAME"
        TM::Project.new(name)
      # when "show PID"
      #   do something
      when "new TASK"
        TM::Task.new(PID,desc,num)
      when "add"
        # do something
      when "mark TID"
        TM::Task.complete(mark)
      when "help"
        help
      when "exit"
        exit
      else
        puts "I am sorry, please enter a valid command"
    end
  end
end
