class TM::PMClient
  def print_menu
    puts %q(Available Commands:
      help - Show these commands again
      list - List all projects
      create NAME - Create a new project with name=NAME
      show PID - Show remaining tasks for project with id=PID
      history PID - Show completed tasks for project with id=PID
      add PID PRIORITY DESC - Add a new task to project with id=PID
      mark TID - Mark task with id=TID as complete)
  end

  def get_command
    gets.chomp.split
  end

  def execute_command(command)
    case command.first
    when "help"
      print_menu
    when "list"
      list_projects
    when "create"
      TM::Project.new(command.last)
      puts "Create the #{command.last} project"
    when "show"
      show_project
    end
  end

  def run_pm
  end
end