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
      print "Enter a command: "
    when "list"
      # List all projects
    when "create"
      new_project = TM::Project.new("Project")
      puts new_project.name
    when "show"
      project = TM::Project.get_project(1)
      puts "Priority\tID\tDescription"
      project.tasks.each do |task|
        puts "#{task.priority}\t#{task.task_id}\t#{task.description}"
      end
    when "history"
      # Show completed tasks for project
    when "add"
      TM::Task.new(1,10,"Description")
    when "mark"
      # Mark task as completed
    when "exit"
      choice = exit
    end

  end while choice != "exit" # This isn't necessary, exit will always exit the program
end
