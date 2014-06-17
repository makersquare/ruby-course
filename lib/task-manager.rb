
# Create our module. This is so other files can start using it immediately
module TM

  def self.run
    @active = true
    @history = []
    TM.start_message
    TM.help
    while @active
      TM.parse_command
    end

  end

  def self.parse_command
    print "$: "
    # partition only partitions up to the first instance
    input = gets.chomp
    @history << input
    input = input.strip.partition(" ")
    command = input.first
    # split the remaining argument up
    args = input.last.split(" ")

    puts args

    case command
      when "mark"
        TM.cmd_mark(args)
      when 'add'
        TM.cmd_add(args)
      when 'history'
        TM.cmd_history(args)
      when 'show'
        TM.cmd_show(args)
      when 'create'
        TM.cmd_create(args)
      when 'list'
        TM.cmd_list()
      when 'help'
        TM.help
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
    if args.count != 1
      TM::PMTerminal.invalid_args("arg count")
      return nil
    elsif args.first.is_a Integer
      TM::PMTerminal.invalid_args("need integers")
      return nil
    end
    tid = args.pop
    TM::Task.master_task_list[tid].mark_complete
  end

  def self.cmd_add(args)

    if args.count < 3
      TM::PMTerminal.invalid_args("arg count")
      return nil
    end

    begin
      project_id = Integer(args[0])
      priority = Integer(args[1])
    rescue
      TM::PMTerminal.invalid_args("need integers")
      return nil
    end

    project = TM::Project.get_project(project_id)
    if project == nil
      puts "project does not exist"
      return nil
    end
    desc = args[2..-1].join(" ")
    project.add_task(desc, priority)
    puts "Created task in #{project.name}"
    puts "-- DESCRIPTION: #{desc}"
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

  def self.cmd_create(args)
    if args.count != 1
      puts "Wrong number of arguments."
      return nil
    end
    name = args[0]
    TM::Project.new(name)
    puts "New project created named: #{name}"
  end

  def self.cmd_list
    projects = TM::Project.get_projects
    if projects.empty?
      puts "You have no projects to list"
    else
      projects.each do |project|
        puts "ID: #{project.pid} - NAME: #{project.name}"
      end
    end
  end
#
# End Commands
#
#
# Begin Status Messages
#
  def self.invalid_args(type)
    puts "invalid number of arguments! #{type}"
  end

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

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'

TM::run

