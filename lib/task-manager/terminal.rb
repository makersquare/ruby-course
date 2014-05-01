# require_relative 'project.rb'
require 'pry-debugger'

class TM::TerminalClient

  attr_reader :menu

  def initialize
    @menu =
    'Welcome to Project Manager Pro®. What can I do for you today?

      Available Commands:
        list - List all projects
        create NAME - Create a new project with name=NAME
        add PID PRIORITY DESC - Add a new task to project with id=PID
        show PID - Show remaining tasks for project with id=PID
        history PID - Show completed tasks for project with id=PID

        mark TID - Mark task with id=TID as complete
        exit
        '
    # get_input
  end

  def get_input
    puts @menu
    while true
      cmds = parse_cmd(gets.chomp!)
      puts exec_cmd(cmds)
    end
  end

  def parse_cmd(input)
    input = input.split(' ')
    cmd = input.shift
    args = input.length ? input : nil
    return [cmd, args]
  end

  def exec_cmd(cmds)
    cmd, args = cmds.shift, cmds.last
    case cmd
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create_project(args)
    when 'add' then create_new_task(args)
    when 'show' then show(args)
    # when 'history' then
    # when 'mark' then
    else "command invalid. 'help' displays the menu."
    end
  end

  def list_all_projects
    puts "ID__Project_Name"  + ("_" * 20)
    TM::Project.projects.each {|proj| puts proj}
  end

  def create_project(args)
    TM::Project.new(args[0])
  end


  def show(args)
    pid = args.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    puts "Project_#{project.id}_Incomplete_Tasks"
    project.incomplete.each {|t| puts t}
  end

  def create_new_task(args)
    pid = args.shift.to_i
    priority = args.shift.to_i
    desc = args.join(' ')
    task = TM::Task.new(pid, priority, desc)
    # puts "New Task #{task.id} created and assigned to Project #{pid}"
    task
  end

end


