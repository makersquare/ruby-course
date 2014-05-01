require_relative '../task-manager.rb'


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
    # SEPARATE YO GETS CHOMPY
    TM::Project.initialize(name)
  end

  def show(pid)
    # MOVE STARTS HERE
    @@projects.each do |x|
      if x == pid
        pid.incomplete_tasks
      end

     # FINISH THIS MAYBE IN PROJECT CLASS
  end

  def history(pid)
# SAME AS ABOVE
    pid.completed
  end

  def add(pid, name, description, priority_number)
    # SAME AS ABOVE FOR PID
    pid

    name = TM::Task.name
    description = TM::Task.description
    priority_number = TM::Task.priority_number

    newTask = TM::Task.new(name, description, priority_number)
      # OMG HOW TO I ADD THIS TO A PROJECT!?!?!
      spec @ symbols are what pid needs to be
      pid.add_task
  end

  def mark(task_name)
    tid = TM::Task.
    complete
  end

end






