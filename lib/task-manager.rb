
# Create our module. This is so other files can start using it immediately
module TM
  #terminal method: here is where I call the method

  #while active? and then a deactivate method?
  def self.terminal
    while true
      puts "Welcome to Project Manager.  What would you like to do?"
      puts "Available Commands:"
      puts "--Type 'help' to show these commands again"
      puts "--Type 'list' to list all projects"
      puts "--Type 'new NAME' to create a new project"
      puts "--Type 'add PID NAME PRIORITY_NUMBER DESCRIPTION' to add a task for project id = PID"
      puts "--Type 'tasks PID' to show all tasks for project id = PID"
      puts "--Type 'incomplete PID' to show all incomplete tasks for project id = PID"
      puts "--Type 'mark TID' to mark a task with id =TID as complete"
      puts "--Type 'quit' to exit"

      user_input = gets.downcase.split

      if user_input.length == 0
        puts "Invalid command"
        next
      end

      case user_input[0]
      when 'help'
        next
      when 'list'
        TM::Project.project_list.keys.each {|x| puts x} #explain
      when 'new'
        name = user_input[1]
        new_project = TM::Project.new(name)
        puts "Created Project #{new_project.id}"
      when 'quit'
        break
      when 'add'
        pid = Integer(user_input[1]) #change to lowercase
        name = user_input[2]
        priority_number = Integer(user_input[3])
        description = user_input.length < 5 ? nil : user_input[4]

        project = TM::Project.project_list[pid]
        new_task = project.create_task(name,priority_number,description)

        puts "Created Task #{new_task.task_id}"
      when 'tasks'
        pid = Integer(user_input[1])
        project = Project.project_list[pid]
        project.tasks.each {|x| puts "Task: #{x.task_id}"}
      when 'incomplete pid'

      when 'mark tid' #look at project list lookup
      else
        puts 'Invalid Command'
      end
    end
  end
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
