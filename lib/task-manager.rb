# # # Create our module. This is so other files can start using it immediately
module TM

end

require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'

class TMTerminal
  # create new instance of project_list class to store user data for the session

  puts "Welcome to Project Manager Pro®. What can I do for you today?\n"
  puts "Available commands:"

  puts "\thelp - Show these commands again"
  puts "\tlist - List all projects"
  puts "\tcreate NAME - Create a new project with name=NAME"
  puts "\tshow PID - Show remaining tasks for project with id=PID"
  puts "\thistory PID - Show completed tasks for project with id=PID"
  puts "\tadd PID PRIORITY DESC - Add a new task to project with id=PID"
  puts "\tmark TID - Mark task with id=TID as complete"
  puts "\texit with EXIT"
  print "Enter a command: "
  begin
    choice = gets.chomp()
    case choice
    when "help"
      puts "Available commands:"

      puts "\thelp - Show these commands again"
      puts "\tlist - List all projects"
      puts "\tcreate NAME - Create a new project with name=NAME"
      puts "\tshow PID - Show remaining tasks for project with id=PID"
      puts "\thistory PID - Show completed tasks for project with id=PID"
      puts "\tadd PID PRIORITY DESC - Add a new task to project with id=PID"
      puts "\tmark TID - Mark task with id=TID as complete"
      puts "\texit with exit"
    when "list"
      puts "Project ID\tProject Name"
      TM::Project.list_projects.each do |project|
        puts"#{project.pid}\t\t#{project.name}"
      end
    when "create"
      print "Enter the project's name: "
      name = gets.chomp()
      new_project = TM::Project.new(name)
    when "show"
      project = TM::Project.get_project(1)
      puts "Priority\tID\tDescription"
      project.incomplete_tasks.each do |task|
        puts "#{task.priority}\t#{task.task_id}\t#{task.description}"
      end
    when "history"
      print "Enter the project id: "
      id = gets.chomp().to_i
      project = TM::Project.get_project(id)
      project.completed_tasks.each do |task|
        puts "#{task.task_id} | #{task.description}"
      end
    when "add"
      print "Enter the project id: "
      project = gets.chomp().to_i
      print "Enter the task description: "
      description = gets.chomp()
      print "Enter the task priority: "
      priority = gets.chomp().to_i

      TM::Task.new(project,description,priority)
    when "mark"
      print "Enter the task id: "
      id = gets.chomp().to_i
      TM::Task.complete_task(id)
    end
  end while choice != "exit" # This isn't necessary, exit will always exit the program

end
