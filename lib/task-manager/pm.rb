require 'project'
require 'task'

#   $ bundle exec ruby pm.rb

class TerminalClient
  attr_accessor :input

  def start
    puts 'Welcome to Project Manager Pro®. What can I do for you today?'
    puts 'help - Show these commands again'
    puts 'list - List all projects'
    puts 'create NAME - Create a new project with name=NAME'
    puts 'show PID - Show remaining tasks for project with id=PID'
    puts 'history PID - Show completed tasks for project with id=PID'
    puts 'add PID PRIORITY DESC - Add a new task to project with id=PID'
    puts 'mark TID - Mark task with id=TID as complete'
    input = gets.chomp.downcase!
  end

case input
  when 'help'
    puts 'help - Show these commands again'
    puts 'list - List all projects'
    puts 'create NAME - Create a new project with name=NAME'
    puts 'show PID - Show remaining tasks for project with id=PID'
    puts 'history PID - Show completed tasks for project with id=PID'
    puts 'add PID PRIORITY DESC - Add a new task to project with id=PID'
    puts 'mark TID - Mark task with id=TID as complete'

  when 'list'
    list
  when 'create'
    create
  when 'show PID'
    show PID
  when 'history PID'
    history PID
  when 'add PID PRIORITY DESC'
    add PID PRIORITY DESC
  when 'mark TID'
    mark TID
  when 'exit'
    exit

  else
    "Sorry, that didn't match any of my commands. Please try again."
end


end

  def list
    TM::Project.list_projects
  end

  def create(name)
    TM::Project.initialize(name)
  end

  def show(PID)
     # 'show PID - Show remaining tasks for project with id=PID'

  end

  def history
     'history PID - Show completed tasks for project with id=PID'

  end

  def add_pid_priority_desc
     'add PID PRIORITY DESC - Add a new task to project with id=PID'

  end

  def mark_tid
     'mark TID - Mark task with id=TID as complete'

  end

end






