require 'pry-debugger'

class TM::TerminalClient

  puts "Welcome to Project Manager Pro. What can I do for you today?\n\n"
  puts "Available Commands:"
  puts "\thelp - Show these commands again"
  puts "\tlist - List all projects"
  puts "\tcreate p - Create a new project"
  puts "\tcreate t - Create a new task for a project"
  puts "\tshow - Show remaining tasks for a project"
  puts "\thistory - Show completed tasks for a project"
  puts "\tmark task - Mark a task as complete"
  puts "\texit - exits the program"
  command = gets.chomp

  while command != 'exit'

    if command == 'list'

      projects = TM::Project.list_projects
      puts "ID\tProject Name"
      projects.each {|x| puts "#{x.pid}\t#{x.name}"}
      command = gets.chomp

    elsif command == 'create p'

      puts "Please enter a project name:"
      name = gets.chomp
      project = TM::Project.new(name)
      puts "You created a new project, #{project.name}! It's ID is: #{project.pid}"
      command = gets.chomp

    elsif command == 'create t'

      puts "Please enter the id of the project you want the task to be in."
      projectid = gets.chomp
      puts "Please enter a description for your task."
      description = gets.chomp
      puts "Please enter a priority number for your task (one being the highest priority)."
      priority = gets.chomp
      task = TM::Task.new(projectid,description,priority)
      puts "You created a new task #{description}!"
      command = gets.chomp

    elsif command == 'show'

      puts "Please enter a project ID."
      projectid = gets.chomp
      tasks = TM::Task.incomplete_tasks(projectid)
      puts "Showing Project #{TM::Project.project_name(projectid)}"

      command = gets.chomp

    elsif command == 'history'

      command = gets.chomp

    elsif command == 'mark task'

      command = gets.chomp

    elsif command == 'help'

      command = gets.chomp

    else

      puts "That is not a command."
      command = gets.chomp

    end

  end

end
