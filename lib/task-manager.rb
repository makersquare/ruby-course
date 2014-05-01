
# Create our module. This is so other files can start using it immediately
module TM

end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_manager.rb'


class TM::ProjectManager
  def self.start
    manager = TM::ProjectTracker.new
    @@exit = false
    while @@exit == false
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts ""
    puts ""
    puts "Here are the available Commands you can interact with:"
    puts
    puts "-- Type 'help' Show these commands again"
    puts "-- Type 'list' List all the projects"
    puts "-- Type 'create NAME' - Create a new project with name=NAME"
    puts "-- Type 'add PID PRIORITY DESC' - Add a new task to project with id=PID"
    puts "-- Type 'show PID' Show remaining tasks for project with id=PID"
    puts "-- Type 'history PID' to show completed tasks for project with id=PID"
    puts "-- Type 'mark TID' Mark task with id=TID as complete"
    puts "-- Type 'exit' Exit the program"
    user = gets.chomp
    user_input = user.downcase.split

      case user_user_input[0]
        when 'help'
          manager.help
        when 'list'
          manager.get_projects
        when 'show'
          manager.show_tasks(user_input[1])
        when 'add'
          manager.add_task(user_input[1], user_input[3], user_input[2])
        when 'history'
          manager.tasks_record(user_input[1])
        when 'mark'
          manager.complete_task(user_input[1])
        when 'exit'
          @@exit = true
        when 'create'
          manager.create_new_project(user_input[1])
        else
          puts "Sorry you enter wrong command"
      puts "Please follow the instructions and enter a valid command"
        end
      end
    end
end


