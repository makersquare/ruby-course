class TM::TerminalClient

    attr_accessor :user

    def initalize
      @user = user
        puts "  ---------------------------------------------------------------- "
        puts "  Welcome to Project Manager Pro"
        puts " "
        puts "  What can I do for you today?"
        puts " "
        puts "  Available Commands:"
        puts "  ---------------------------------------------------------------- "
        puts " "
        puts "    help - Show these commands again"
        puts "    list - List all projects"
        puts "    create NAME - Create a new project with a name = NAME"
        puts "    show PID - Shows remaining tasks for project with id = PID"
        puts "    history PID - Show completed takss for project with id = PID"
        puts "    add PID PRIORITY DESC - Add a new task to project with id = PID"
        puts "    mark TID - Mark task with id = TID as complete"
        puts " "
      @user = gets.chomp
    end

    case user
      when help
        puts
      when list
        puts
      when create
        puts
      when show
        puts
      when history
        puts
      when add
        puts
      when mark
        puts
      else
        puts "I am sorry, please enter a valid command"
    end
end
