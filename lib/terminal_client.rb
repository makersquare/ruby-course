require_relative 'task-manager.rb'
require 'io/console'

help = "Welcome to Project Manager Pro. What would you like to do? Please enter a valid command\nAvailable Commands:\n   help - Show these commands again\n   list - List all projects\n   create NAME - Create a new project with name=NAME\n   history PID = show completed tasks for a project with id=PID\n   add PID PRIORITY DESC - Add a new task to project with id=PID\n   mark TID - Mark task with id=TID as complete"
puts help
answer = gets.chomp

if answer == "help"
  puts help
  answer = gets.chomp
end

