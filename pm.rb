require_relative 'lib/task-manager.rb'
require 'colorize'

class   PM
def self.first_menu
    puts
    puts "Available Commands:".colorize(:light_blue)
    puts
    puts "help - Show these `commands again"
    puts "create NAME - Create a new project with name=NAME"
    puts "list - List all projects`"
    puts "show PID - Show remaining tasks for project with id=PID"
    puts "history PID - Show completed tasks for project with id`=PID"
    puts "add  PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "mark TID - Mark task with id=TID as complete"
    puts
    print "What would you like to do? ".colorize(:green)

    @@user_command = gets.chomp
  end

def self.start
  @@user_command = ''
  @@project_list = TM::ProjectList.new
  puts "Welcome to Project Manager Pro®. What can I do for you today?"
  while (@@user_command != 'quit')
    PM.first_menu


    if (@@user_command == 'help')

    elsif (@@user_command.include? 'create')
      length = @@user_command.length
      project_name = @@user_command.slice(7..length)

      @@project_list.add_project(project_name)
      puts
      puts
      puts "Project #{project_name} added!".colorize(:yellow)


    elsif(@@user_command == 'list')
      @@project_list.list_projects

    end

  end
end
end

PM.start
