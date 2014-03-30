require_relative 'lib/task-manager.rb'
require 'colorize'

class   PM
def self.first_menu
    Available Commands:
puts  "help - Show these commands again"
puts  "project list - List all projects"
puts  "project create NAME - Create a new project"
puts  "project show PID - Show remaining tasks for project PID"
puts  "project history PID - Show completed tasks for project PID"
puts  "project employees PID - Show employees participating in this project"
puts  "project recruit PID EID - Adds employee EID to participate in project PID"
puts  "task create PID PRIORITY DESC - Add a new task to project PID"
puts  "task assign TID EID - Assign task TID to employee EID"
puts  "task mark TID - Mark task TID as complete"
puts  "emp list - List all employees"
puts  "emp create NAME - Create a new employee"
puts  "emp show EID - Show employee EID and all participating projects"
puts  "emp details EID - Show all remaining tasks assigned to employee EID, along with the project name next to each task"
puts  "emp history EID - Show completed tasks for employee with id=EID"

  end

def self.start
  @@user_command = ''
  # @@db = TM.
  puts
  puts "Welcome to Project Manager Pro®. What can I do for you today?".colorize(:color => :magenta, :background => :yellow, :mode => :underline)
  PM.first_menu

  while (@@user_command != 'quit')
    print "What would you like to do? ".colorize(:green)
    @@user_command = gets.chomp

    if (@@user_command == 'help')
        PM.first_menu

    elsif (@@user_command.include? 'create')
      length = @@user_command.length
      project_name = @@user_command.slice(7..length)

      # @@project_list.add_project(project_name)
      result = TM::CreateProject.run(:project_name => project_name)

      if result.success?
        puts
        puts
        print "Project: ".colorize(:yellow); print "#{project_name}".colorize(:red); print " added!".colorize(:yellow)
        puts
        puts
      else
        print "#{result.error}".colorize(:red)
      end

    elsif(@@user_command == 'list')
      puts
      puts
      puts " PID      Project Name".colorize(:mode => :underline)
      @@project_list.projects.each {|project| puts "  #{project.id}       #{project.project_name}"}
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
      # puts "Showing project: \"#{} "
      remaining_tasks = @@project_list.show_remaining_tasks(pid)


      puts "Priority    ID    Description"
      remaining_tasks.each {|task| puts "      #{task.priority}      #{task.id}        #{task.description}"}
      puts

  elsif (@@user_command.include? 'history')
      length = @@user_command.length
      pid = @@user_command.slice(8..length - 1).to_i
      # puts "#{pid}".colorize(:red)
      remaining_tasks = @@project_list.show_completed_tasks(pid)

      remaining_tasks.each {|task| puts task.description}
      puts
  elsif (@@user_command.include? 'mark')
    length = @@user_command.length
    tid = @@user_command.slice(5..length - 1).to_i
    selected_task = @@project_list.mark_task_complete(tid)
    puts
    puts "you marked task: #{selected_task.description} as complete!"
    puts
  end

  end
end
end

PM.start
