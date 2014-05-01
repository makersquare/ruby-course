# require_relative 'project.rb'
require 'pry-debugger'

class TM::TerminalClient

  attr_reader :menu

  def initialize
    @menu =
    'Welcome to Project Manager Pro®. What can I do for you today?

      Available Commands:
        help - Show these commands again
        list - List all projects
        create NAME - Create a new project with name=NAME
        show PID - Show remaining tasks for project with id=PID
        history PID - Show completed tasks for project with id=PID
        add PID PRIORITY DESC - Add a new task to project with id=PID
        mark TID - Mark task with id=TID as complete
        exit
        '
    # get_input
  end

  def get_input
    puts @menu
    while true
      cmd, args = parse_cmd(gets.chomp!)
      puts exec_cmd(cmd, args)
    end
  end

  def parse_cmd(input)
    input = input.split(' ')
    cmd = input.shift
    args = input.length ? input : nil
    return [cmd, args]
  end

  def exec_cmd(cmds)
    # create_project('asdfasdf project')
    # create_new_task([1, 1, 'asdfasdfa task'])
    # binding.pry
    case cmds.first
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create_project(args)
    when 'show' then display_incomplete(args)
    # when 'history' then
    when 'add' then create_new_task(args)
    # when 'mark' then
    else "command invalid. 'help' displays the menu."
    end
  end

  def list_all_projects
    puts "ID__Project_Name"  + ("_" * 20)
    TM::Project.projects.each {|proj| puts proj}
    # nil
  end

  def create_project(name)
    TM::Project.new(name)
    nil
  end

  def display_incomplete(pid)
    project = TM::Project.find_project_by_id(pid)
    puts "Project_#{project.id}_Incomplete_Tasks"
    project.incomplete.each {|t| puts t}
    nil
  end

  def create_new_task(args)
    task = TM::Task.new(args[0], args[1], args[2])
    TM::Project.add_task(task)
    puts "Task #{task.id} created and assigned to project #{task.project_id}"
    nil
  end

end


