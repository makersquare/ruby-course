require "pry-debugger"
require_relative "./lib/task-manager.rb"
# Welcome to Project Manager Pro®. What can I do for you today?

# Available Commands:
#   help - Show these commands again
#   list - List all projects
#   create NAME - Create a new project with name=NAME
#   show PID - Show remaining tasks for project with id=PID
#   history PID - Show completed tasks for project with id=PID
#   add PID PRIORITY DESC - Add a new task to project with id=PID
#   mark TID - Mark task with id=TID as complete
# > show 1
# Showing Project "Bucket List"

# Priority    ID  Description
#        1    12  Become a vegan
#        2     8  Master cookie clicking
#        2     9  Reconsider eating meat again
class TerminalClient
def initialize
  puts "Welcome to Project Manager Pro®. What can I do for you today?
    Available Commands:
    help - Show these commands again
    list - List all projects
    create NAME - Create a new project with name=NAME
    show PID - Show remaining tasks for project with id=PID
    history PID - Show completed tasks for project with id=PID
    add PID PRIORITY DESC - Add a new task to project with id=PID
    mark TID - Mark task with id=TID as complete"
  selector(gets.chomp)
end

def selector(response)
  if response == "help"
    help
  elsif response == "list"
    list
  elsif response[0..5] =="create"
    create(response[7..-1])
  elsif response[0..3] =="show"
    show(response[5..-1])
  elsif response[0..6] =="history"
    history(response[8..-1])
  elsif response[0..2] =="add"
    response=response[3..-1].split{/" "/}
    add(response[0],response[1],response[2])
  elsif response[0..3] =="mark"
    mark(response[5..-1])
  elsif response[0..3]=="exit"
    puts "Goodbye!"
  else
    puts "That was not a valid command.\nType help for a list of valid commands"
    selector(gets.chomp)
  end


end
def help
  puts "Available Commands:
    help - Show these commands again
    list - List all projects
    create NAME - Create a new project with name=NAME
    show PID - Show remaining tasks for project with id=PID
    history PID - Show completed tasks for project with id=PID
    add PID PRIORITY DESC - Add a new task to project with id=PID
    mark TID - Mark task with id=TID as complete"
  selector(gets.chomp)
end
def list
  selector(gets.chomp)
end
def create name
  selector(gets.chomp)
end
def show pid
  selector(gets.chomp)
end
def history pid
  selector(gets.chomp)
end
def add (pid, priority, desc)
  selector(gets.chomp)
end
def mark tid
  selector(gets.chomp)
end
end

TerminalClient.new

