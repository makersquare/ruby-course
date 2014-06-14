require "./lib/task-manager.rb"

class TM::PMTerminal

  def initialize()
    @active = true
    PMTerminal.start_message
    PMTerminal.help
    while @active
      self.parse_command
    end

  end

  def self.parse_command
    print "$: "
    # partition only partitions up to the first instance
    input = gets.chomp.strip.partition(" ")
    command = input.first
    # split the remaining argument up
    args = input.last.split(" ")

    case command
      when "mark"
        TM::PMTerminal.cmd_mark(args)
      when 'add'
        TM::PMTerminal.cmd_add(args)
      when 'history'
        TM::PMTerminal.cmd_history(args)
      when 'show'
        TM::PMTerminal.cmd_show(args)
      when 'create'
        TM::PMTerminal.cmd_create(args)
      when 'list'
        TM::PMTerminal.cmd_list()
      when 'help'
        TM::PMTerminal.help
      when 'exit', 'q', 'quit'
        puts "Thank you for using the PM Terminal"
        @active = false
      else
        puts "I'm sorry hal, I am unable to do that..."
    end
  end
#
# Begin Commands
#
  def self.cmd_mark(args)
    # TODO
    # Takes one argument
    # TID
  end

  def self.cmd_add(args)
    # TODO:
    # Takes three arguments
    # PID, PRIORITY and DESC
    # add a new task to a project
  end

  def self.cmd_history(arg)
    # TODO:
    # Takes one argument
    # PID
    # show remaining tasks for project id
  end

  def self.cmd_show(arg)
    # TODO
    # Takes one argument
    # PID
    # show the remaining tasks for project id
  end

  def self.cmd_create(arg)
    # TODO
    # Takes one argument
    # project name
    # creates a new project
  end

  def self.cmd_list
    # TODO
    # Takes no arguments
    # List all projects
  end
#
# End Commands
#
#
# Begin Status Messages
#
  def self.start_message
    puts "-------------------------------------------------------------"
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "-------------------------------------------------------------"
  end

  def self.help
    puts "Available Commands:
  -- <name>-> <----<args>------> <-------<info>------------------------->
  -- help                       - Show these commands again
  -- list                       - List all projects
  -- create   NAME              - Create a new project with name=NAME
  -- show     PID               - Show remaining tasks for project with id=PID
  -- history  PID               - Show completed tasks for project with id=PID
  -- add      PID PRIORITY DESC - Add a new task to project with id=PID
  -- mark     TID               - Mark task with id=TID as complete
  -- exit/q,quit                       - exits the program"
  end
#
# End Status Messages
#
end
