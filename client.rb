require_relative 'lib/task-manager.rb'
require 'colorize'

class PManager
  def self.start
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    def self.main_menu
      puts "Available Commands:".colorize(:green)
      puts "  help - Show these commands again"
      puts "  list - List all projects"
      puts "  create NAME - Create a new project with name=NAME"
      puts "  show PID - Show remaining tasks for project with id=PID"
      puts "  history PID - Show completed tasks for project with id=PID"
      puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
      puts "  mark TID - Mark task with id=TID as complete"
      print "what do you want to do?  "
      @@user_command = gets.chomp
    end
    @@user_command = ""
    project_list = TM::ProjectList.new

    while (@@user_command != 'quit')
      PManager.main_menu

      if (@@user_command == 'help')
        PManager.main_menu

      elsif (@@user_command == 'list')
        project_list.list_projects
        puts; puts; puts;

      elsif (@@user_command.include?'create')
        length = @@user_command.length
        name = @@user_command.slice(7..length)
        project_list.add_project(name)
        puts; puts; puts "Project #{name} was created".colorize(:yellow)
        puts; puts; puts;


      elsif (@@user_command.include?'show')
        length = @@user_command.length
        name = @@user_command.slice(5..length)
        print name
        puts

      elsif (@@user_command.include?'history')
        length = @@user_command.length
        name = @@user_command.slice(8..length)
        print name
        puts

      elsif (@@user_command.include?'add')
        length = @@user_command.length
        name = @@user_command.slice(4..length)
        print name
        puts

       elsif (@@user_command.include?'mark')
        length = @@user_command.length
        name = @@user_command.slice(5..length)
        print name
        puts



      end
    end
  end
end
PManager.start
