require_relative 'lib/task-manager.rb'
require 'colorize'

class PManager
  def self.start
    puts "Welcome to Project Manager Pro®. What can I do for you today?".colorize(:color => :white, :background => :green)
    def self.main_menu
      puts "Available Commands:".colorize(:blue)
      puts "  help - Show these commands again".colorize(:light_blue)
      puts "  list - List all projects".colorize(:blue)
      puts "  create NAME - Create a new project with name=NAME".colorize(:light_blue)
      puts "  show PID - Show remaining tasks for project with id=PID".colorize(:blue)
      puts "  history PID - Show completed tasks for project with id=PID".colorize(:light_blue)
      puts "  add PID PRIORITY DESC - Add a new task to project with id=PID".colorize(:blue)
      puts "  mark TID - Mark task with id=TID as complete".colorize(:light_blue)
    end
    @@user_command = ""
    project_list = TM::ProjectList.new
    PManager.main_menu
    while (@@user_command != 'quit')
      print "what do you want to do?  "
      @@user_command = gets.chomp
      if (@@user_command == 'help')
        PManager.main_menu

      elsif (@@user_command == 'list')
        project_list.project_list.each { |project| puts "id: #{project.id} and name: #{project.name}".colorize(:green) }
        puts;

      elsif (@@user_command.include?'create')
        length = @@user_command.length
        name = @@user_command.slice(7..length)
        project_list.add_project(name)
        puts; puts "Project #{name} was created".colorize(:green)
        puts;


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
        full = @@user_command.slice(4..length)
        id = @@user_command.slice(4)
        pid = id.to_i
        priority_string = @@user_command.slice(@@user_command.length-1)
        priority = priority_string.to_i
        description = @@user_command.slice(6..@@user_command.length-2)

        project_list.add_task_to_project(description, priority, id)
        project = project_list.project_list.find { |project| project.id == pid }
        puts; puts "Task was added to project id #{project.name}".colorize(:green)
        puts;

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
