require 'io/console'

class TM::Task_io
  def start
    puts "Welcome to Taskio, Task Manager.  How may we assist you?\n\n"

    puts "Available Commands: \n"
    puts "help - Show these commands again"
    puts "create NAME - Create a new project with name=NAME"
    puts "show PID - Show remaining tasks for a project with id=PID"
    puts "history PID - Show completed tasks for project wiht id=PID"
    puts "add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "mark TID - Mark task with id=TID as complete\n\n"

    puts "get TID - Get a list of tasks per project with project id=PID"
    #puts "get PID - Get a list of project ids"

    req = gets.chomp

    if req == 'help'
    elsif req.split(" ")[0] == 'create'
    elsif req.split(" ")[0] == 'show'
    elsif req.split(" ")[0] == 'history'
    elsif req.split(" ")[0] == 'add'
    elsif req.split(" ")[0] == 'mark'
    elsif req.split(" ")[0] == 'get'
    else
      puts "Invalid request, please try again"
  end
end
