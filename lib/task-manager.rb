
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/tracker.rb'
require_relative 'task-manager/employee.rb'

class TM::ProjectManager
  def self.start
    tracker = TM::ProjectTracker.new
  @@exit = false
    while @@exit == false
    puts "What would you like to do?"
    puts "-- Type 'help' to show these commands again"
    puts "-- Type 'list' to list all the projects"
    puts "-- Type 'Generate employee name' to create a new employee with name=employee name"
    puts "-- Type 'create NAME' - Create a new project with name=NAME"
    puts "-- Type 'add PID PRIORITY DESC' - Add a new task to project with id=PID"
    puts "-- Type 'show PID' to show remaining tasks for project with id=PID"
    puts "-- Type 'history PID' to show completed tasks for project with id=PID"
    puts "-- Type 'mark TID' to mark task with id=TID as complete"
    puts "-- Type 'task assign TID EID' - Assign task TID to employee EID"
    puts "-- Type 'exit' to quit this program"
    string = gets.chomp
    choice = string.downcase.split

      case choice[0]
        when 'help'
          tracker.help
        when 'list'
          tracker.get_projects
        when 'show'
            tracker.show_tasks(choice[1])
        when 'add'
            tracker.add_task(choice[1], choice[3], choice[2])
        when 'history'
            tracker.history_tasks(choice[1])
        when 'mark'
            tracker.complete_task(choice[1])
        when 'task'
        when 'generate'
            employee = tracker.add_new_employee(choice[2])
            puts "#{employee.name} has been created"
        when 'exit'
          @@exit = true
        when 'create'
          tracker.create_new_project(choice[1])
        else
          puts "Dude, follow instructions!"
        end
      end
    end
end



