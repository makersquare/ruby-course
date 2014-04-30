# require_relative 'project.rb'

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
    conf.echo = nil
    get_input
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

  def exec_cmd(cmd, args)
    case cmd
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create_project(args.join(' '))
    when 'show' then show_tasks(args)
    else "command invalid. 'help' displays the menu."
    end
  end

  def list_all_projects
    puts "ID__Project_Name"  + ("_" * 20)
    TM::Project.projects.each {|proj| puts proj}
    nil
  end

  def create_project(name)
    TM::Project.new(name)
    nil
  end

  def display_tasks(pid)

end


