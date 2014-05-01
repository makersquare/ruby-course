# require_relative 'project.rb'
require 'pry-debugger'

class TM::TerminalClient

  attr_reader :menu

  def initialize
    @term_width = 80
    @help =
    'Welcome to Project Manager Pro®. What can I do for you today?

      Available Commands:
        list - List all projects
        create NAME - Create a new project with name=NAME
        add PID PRIORITY DESC - Add a new task to project id=PID 1=HighestPriority
        show PID - Show remaining tasks for project with id=PID
        history PID - Show completed tasks for project with id=PID

        mark TID - Mark task with id=TID as complete
        exit
        '
    get_input
  end

  def get_input
    puts @help
    while true
      puts ''
      print '>> '
      cmds = parse_cmd(gets.chomp!)
      exec_cmd(cmds)
      update_term_width
    end
  end

  def parse_cmd(input)
    input = input.split(' ')
    cmd = input.shift
    args = input.length ? input : nil
    return [cmd, args]
  end

  # basically, a router
  def exec_cmd(cmds)
    cmd, args = cmds.shift, cmds.last

    case cmd
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create(args)
    when 'add' then add(args)
    when 'show' then show(args)
    when 'history' then history(args)
    when 'mark' then mark(args)
    when 'help' then help
    else "command invalid. 'help' displays the menu."
    end
  end

  def list_all_projects
    header("ID__Project_Name")
    TM::Project.projects.each {|proj| puts proj}
  end


  def create(args)
    name = args.join(' ')
    TM::Project.new(name)
  end

  def show(args)
    pid = args.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    header("Project_#{project.id}_Incomplete_Tasks")
    project.incomplete.each {|t| puts t}
  end

  def history(args)
    pid = args.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    header("Project_#{project.id}_Completed_Tasks")
    project.completed.each {|t| puts t}
  end

  def mark(args)
    tid = args.shift.to_i
    TM::Task.mark_complete(tid)
  end

  def add(args)
    pid = args.shift.to_i
    priority = args.shift.to_i
    desc = args.join(' ')
    task = TM::Task.new(pid, priority, desc)
    puts "New Task #{task.id} created and assigned to Project #{pid}"
    TM::Project.find_project_by_id(pid).add_task(task)
    task
  end

  def help
    @help
  end

  def update_term_width
    @term_width = `tput cols`.chomp!.to_i
  end

  def header(str)
    puts(str + "_" * (@term_width - str.length))
  end

end


