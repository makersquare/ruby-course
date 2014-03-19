require_relative 'lib/task-manager.rb'

class PManager
  def start
    user_command = ""
    while (user_command != 'quit')

      puts "Welcome to Project Manager Pro®. What can I do for you today?"

      puts "Available Commands:"
      puts "  help - Show these commands again"
      puts "  list - List all projects"
      puts "  create NAME - Create a new project with name=NAME"
      puts "  show PID - Show remaining tasks for project with id=PID"
      puts "  history PID - Show completed tasks for project with id=PID"
      puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
      puts "  mark TID - Mark task with id=TID as complete"
      print "what do you want to do?"

      user_command = gets.chomp

      if (user_command == 'help')
        puts "Available Commands:"
        puts "  help - Show these commands again"
        puts "  list - List all projects"
        puts "  create NAME - Create a new project with name=NAME"
        puts "  show PID - Show remaining tasks for project with id=PID"
        puts "  history PID - Show completed tasks for project with id=PID"
        puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
        puts "  mark TID - Mark task with id=TID as complete"
        print "what do you want to do?"

      elsif (user_command == 'list')

      elsif (user_command.include?'create')
        length = user_command.length
        name = user_command.slice(6..length)
        print name
        puts

      elsif (user_command.include?'show')
        length = user_command.length
        name = user_command.slice(4..length)
        print name
        puts

      elsif (user_command.include?'history')
        length = user_command.length
        name = user_command.slice(7..length)
        print name
        puts

      elsif (user_command.include?'add')
        length = user_command.length
        name = user_command.slice(3..length)
        print name
        puts

       elsif (user_command.include?'mark')
        length = user_command.length
        name = user_command.slice(4..length)
        print name
        puts



      end
    end
  end
end
