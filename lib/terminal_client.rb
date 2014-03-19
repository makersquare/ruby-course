require_relative 'task-manager.rb'
require 'io/console'


puts "Welcome to ProjectManager Pro!"
puts "\nPlease press enter to view available commands."
variable = gets.chomp
puts "AVAILABLE COMMANDS"
puts "  help - Shows all these commands again"
puts "  list - Lists all projects"
puts "  create NAME - Create a new project with name=NAME"
puts "  show PID - Show remaining tasks for project with id=PID"
puts "  history PID - Show completed tasks for project with id=PID"
puts "  PID PRIORITY DESC - Adds a new task to the project with id=PID"
puts "  mark TID - Marks task with id=TID as complete"
answer = gets.chomp

if answer == "help"
  puts "AVAILABLE COMMANDS"
  puts "  help - Shows all these commands again"
  puts "  list - Lists all projects"
  puts "  create NAME - Create a new project with name=NAME"
  puts "  show PID - Show remaining tasks for project with id=PID"
  puts "  history PID - Show completed tasks for project with id=PID"
  puts "  PID PRIORITY DESC - Adds a new task to the project with id=PID"
  puts "  mark TID - Marks task with id=TID as complete"
  answer = gets.chomp
end


