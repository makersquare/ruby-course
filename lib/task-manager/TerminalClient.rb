require 'pry-debugger'

class TM::TerminalClient

  attr_reader :menu

  def initialize

    @help =
    ' Available Commands:
        list - List all projects
        create NAME - Creates a new project with NAME
        add PID PRIORITY DESCRIPTION - Adds a new task ProjectID (1=Highest Priority)
        show PID - Shows the remaining tasks for project with id
        history PID - Shows completed tasks by the ProjectID
        mark TID - Marks task by TaskID as complete
        exit - Exits the program
        '
    get_input
  end

  def get_input
    puts @help
    while true
      puts ''
      print '>> '
      commands = format_command(gets.chomp!)
      run_command(commands)

    end
  end

  def format_command(input)
    input = input.split(' ')
    command = input.shift
    ans = input.length ? input : nil
    return [command, ans]
  end


  def run_cmd(commands)
    command, ans = commands.shift, commands.last

    case command
    when 'exit' then exit
    when 'list' then list_all_projects
    when 'create' then create(ans)
    when 'add' then add(ans)
    when 'show' then show(ans)
    when 'history' then history(ans)
    when 'mark' then mark(ans)
    when 'help' then help
    else "that is not a valid command. 'help' displays the menu."
    end
  end

  def list_all_projects

    TM::Project.projects.each {|proj| puts proj}
  end


  def create(ans)
    name = ans.join(' ')
    TM::Project.new(name)
  end

  def show(ans)
    pid = ans.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    project.incomplete.each {|task| puts task}
  end

  def history(ans)
    pid = ans.shift.to_i
    project = TM::Project.find_project_by_id(pid)
    project.completed.each {|task| puts task}
  end

  def mark(ans)
    tid = ans.shift.to_i
    TM::Task.mark_complete(tid)
  end

  def add(ans)
    pid = ans.shift.to_i
    priority = ans.shift.to_i
    description = ans.join(' ')
    task = TM::Task.new(pid, priority, description)
    puts "New Task #{task.id} created and assigned to Project #{pid}"
    TM::Project.find_project_by_id(pid).add_task(task)
    task
  end

  def help
    @help
  end


end

