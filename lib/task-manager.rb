require 'pry-debugger'

module TM

  def self.print_menu
    puts "Welcome to Project Manager.  What would you like to do?"
    puts "Available Commands:"
    puts "--Type 'list' to list all projects"
    puts "--Type 'new NAME' to create a new project"
    puts "--Type 'add PID NAME PRIORITY_NUMBER DESCRIPTION' to add a task for project id = PID"
    puts "--Type 'tasks PID' to show all tasks for project id = PID"
    puts "--Type 'complete PID' to show all complete tasks for project id = PID"
    puts "--Type 'incomplete PID' to show all incomplete tasks for project id = PID"
    puts "--Type 'task_list' to list all tasks in all projects"
    puts "--Type 'mark TID' to mark a task with id =TID as complete"
    puts "--Type 'quit' to exit"
  end

  def self.run
    print_menu
    while true

      puts "--Type your command or type 'help' for the menu"
      user_input = gets.downcase.split

      if user_input.length == 0
        puts "Invalid Command"
        next
      end

      case user_input[0]
      when 'help'
        print_menu
      when 'list'
        TM::Project.project_list.keys.each {|x| puts "PID: #{x}"}
      when 'new'
        name = user_input[1]
        new_project = TM::Project.new(name)
        puts "Created #{new_project.name} with PID: #{new_project.id}"
      when 'add'
        pid = Integer(user_input[1])
        name = user_input[2]
        priority_number = Integer(user_input[3])
        description = user_input.length < 5 ? nil : user_input[4]

        project = TM::Project.project_list[pid]
        new_task = project.create_task(name,priority_number,description)

        puts "Created Task #{new_task.task_id}"
      when 'tasks'
        pid = Integer(user_input[1])
        project = TM::Project.project_list[pid]
        project.tasks.each {|x| puts "Task ID: #{x.task_id}"}
      when 'complete'
        pid = Integer(user_input[1])
        project = TM::Project.project_list[pid]
        project.retrieve_completed_tasks
      when 'incomplete'
        pid = Integer(user_input[1])
        project = TM::Project.project_list[pid]
        project.retrieve_incomplete_tasks
      when 'task_list'
        TM::Task.task_list.keys.each {|x| puts "TID: #{x}"}
      when 'mark'
        tid = Integer(user_input[1])
        TM::Task.task_list.keys.each {|x| puts x}
        x.mark_complete
        puts "Task #{task.task_id} completed"
      when 'quit'
        break
      else
        puts 'Invalid Command'
      end

      #make method for each command instead of keeping within case statement
    end
  end
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
