require_relative 'lib/task-manager.rb'
require 'pry-debugger'

class TerminalClient
  def start
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts ""
    puts "Available Commands:"
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark TID - Mark task with id=TID as complete"
    puts "  exit - Exits the application"
    get_command
  end

  def get_command
    puts ""
    print "> "
    input = gets.chomp

    split_input = input.split(' ')
    case split_input[0]
    when "help"
      self.start
    when "list"
      self.list_projects
    when "create"
      self.create_project(split_input)
    when "show"
      self.show_remaining_tasks(split_input)
    when "history"
      self.show_completed_tasks(split_input)
    when "add"
      self.add_task(split_input)
    when "mark"
      self.mark_task(split_input)
    when "exit"
      exit
    else
      puts "Sorry, '#{split_input[0]}' is not a valid command. Use 'help' if you get stuck."
      self.get_command
    end
  end

  def list_projects
    projects = get_projects
    if projects.size > 0
      projects.each do |k, project|
        puts "\[#{project.id}\]: #{project.name}"
      end
    else
      puts "No projects available, try 'help' for more options"
    end
    self.get_command
  end

  def create_project(input)
    input.shift
    name = input.join(" ")

    new_project = TM::Project.new(name)
    if new_project
      puts ""
      puts "Project: #{new_project.name} created with ID: #{new_project.id}"
    else
      puts "Sorry, inputted project is not valid"
    end

    self.get_command
  end

  def show_remaining_tasks(input)
    pid = input[1].to_i

    project = get_projects(pid)
    if project
      puts "Remaining Tasks:"

      project.incomplete_tasks.each do |task|
        puts "\[#{task.id}\]: #{task.description}"
        puts "     Priority: #{task.priority_number}"
        puts ""
      end
    else
      puts "Project with PID #{pid} does not exist."
    end

    self.get_command
  end

  def show_completed_tasks(input)
    pid = input[1].to_i

    project = get_projects(pid)
    if project
      project.complete_tasks.each_with_index do |task|
        puts "#{task.id}: #{task.description}"
        puts "     Completed on: #{task.completed_at.strftime("%m/%d/%Y")}"
        puts ""
      end
    else
      puts "Project with PID #{pid} does not exist."
    end

    self.get_command
  end

  def add_task(input)
    input.shift
    pid = input.shift.to_i
    priority = input.shift.to_i
    desc = input.join(" ")

    task = TM::Task.new(pid, desc, priority)

    if task
      puts "Task '#{task.description}' created with TID #{task.id}"
    else
      puts "Sorry, inputted task is invalid, try again."
    end

    self.get_command
  end

  def mark_task(input)
    tid = input[1].to_i
    task = TM::Task.tasks[tid]

    if task
      TM::Task.mark_complete(tid)
      puts "Task '#{task.description}' marked completed"
    else
      puts "Task with TID #{tid} does not exist."
    end

    self.get_command
  end

  private

  def get_projects(pid=nil)
    pid ? TM::Project.projects[pid] : TM::Project.projects
  end

end

TerminalClient.new.start
