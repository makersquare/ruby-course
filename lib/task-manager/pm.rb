require_relative '../task-manager.rb'


# bundle exec ruby pm.rb

class TerminalClient
  attr_accessor :input

  def start
    puts 'Welcome to Project Manager Pro®. What can I do for you today?'
    puts 'help - Show these commands again'
    puts 'list - List all projects'
    puts 'create NAME - Create a new project with name=NAME'
    puts 'show PID - Show remaining tasks for project with id=PID'
    puts 'history PID - Show completed tasks for project with id=PID'
    puts 'add PID DESC PRIORITY - Add a new task to project with id=PID'
    puts 'mark NAME - Mark task with id=TID as complete'
    get_command
  end

  def get_command
    input = gets.chomp.downcase!
    words = input.split(' ')
    command = words[0]
    option = words[1]
    option1 = words[2]
    option2 = words[3]
    option2 = words[4]

    case command
      when 'help'
        start
      when 'list'
        list
      when 'create'
        create(option)
      when 'show'
        show(option)
      when 'history'
        history(option)
      when 'add'
        add(option, option2, option3, option4)
      when 'mark'
        mark(option)
      when 'exit'
        exit

      else
        "Sorry, that didn't match any of my commands. Please try again."
    end
  end


  def list
    TM::Project.list_projects
  end

  def create(option)
    TM::Project.new(option)
  end

  def show(option)
    option.incomplete_tasks
  end

  def history(option)
    option.completed
  end

  def add(option, option2, option3, option4)
    TM::Project.id = option
    newTask = TM::Task.new(option2, option3, option4)
    option.add_task(newTask)
  end

  def mark(option)
    option.complete
  end

end






