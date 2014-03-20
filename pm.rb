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
    puts "add  DESC PRIORITY PID - Add a new task to project with id=PID"
    puts "mark TID - Mark task with id=TID as complete"
    puts

  end

def self.start
  @@user_command = ''
  @@project_list = TM::ProjectList.new
  puts
  puts "Welcome to Project Manager Pro®. What can I do for you today?".colorize(:color => :light_blue, :background => :white)
  PM.first_menu

  while (@@user_command != 'quit')
    print "What would you like to do? ".colorize(:green)
    @@user_command = gets.chomp

    if (@@user_command == 'help')
        PM.first_menu
    elsif (@@user_command.include? 'create')
      length = @@user_command.length
      project_name = @@user_command.slice(7..length)

      @@project_list.add_project(project_name)
      puts
      puts
      puts "Project #{project_name} added!".colorize(:yellow)
      puts


    elsif(@@user_command == 'list')
      puts "Project List"
      puts
      @@project_list.projects.each {|project| puts "#{project.id} #{project.project_name}"}
      # @@project_list.list_projects
      puts

  elsif (@@user_command.include? 'add')
      #add 2 take out the trash 1
      puts "#{@@user_command}".colorize(:yellow)
      pid = @@user_command.slice(4).to_i
      priority = @@user_command.slice(@@user_command.length - 1).to_i
      description = @@user_command.slice(6..@@user_command.length - 2)
      @@project_list.add_task_to_project(description, priority, pid)
      chosen_project =  @@project_list.projects.find{|project| project.id == pid}

      puts
      puts "task was added to the #{chosen_project.project_name} project".colorize(:yellow)
      puts

  elsif (@@user_command.include? 'show')
      length = @@user_command.length
      pid = @@user_command.slice(5..length - 1).to_i
      # puts "#{pid}".colorize(:red)
      remaining_tasks = @@project_list.show_remaining_tasks(pid)

      remaining_tasks.each {|task| puts task.description}
      puts
  end

  end
end
end

PM.start
