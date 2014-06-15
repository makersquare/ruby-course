
require_relative 'lib/task-manager.rb'

class TM::TerminalClient

  attr_accessor :input_arr

  def initialize
    @input_arr = nil
  end

  def self.start
    input = gets.chomp
    @input_arr = input.split
    self.options_list(@input_arr[0])
  end

  def self.options_list(user_response)
    case user_response
    when "help"
      self.help
    when "list"
      self.list
    when "create"
      self.create
    when "show"
      self.show
    when "history"
      self.history
    when "add"
      self.add
    when "mark"
      self.mark
    when "exit"
      self.exit
    end
  end

  def self.help
    puts "\n"
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "\nAvailable Commands:"
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark PID TID - Mark task with id=PID id=TID as complete"
    puts "  exit – Exits Project Manager Pro®"
    puts "\n"
    self.start
  end

  def self.list
    TM::Project.list_projects.each do |proj|
      puts "\n"
      puts "  Project Name: #{proj.name}"
      puts "  Project ID: #{proj.project_id}"
      puts "\n"
    end
    self.start
  end

  def self.create
    TM::Project.new(@input_arr[1])
    self.start
  end

  def self.show
    proj = TM::Project.list_projects[@input_arr[1].to_i]
    proj.list_incomplete.each do |task|
      puts "\n"
      puts "  Description: #{task.description}"
      puts "  Priority: #{task.priority}"
      puts "  Created: #{task.creation_time}"
      puts "  Task ID: #{task.task_id}"
      puts "\n"
    end
    self.start
  end

  def self.history
    proj = TM::Project.list_projects[@input_arr[1].to_i]
    proj.list_complete.each do |task|
      puts "\n"
      puts "  Description: #{task.description}"
      puts "  Priority: #{task.priority}"
      puts "  Created: #{task.creation_time}"
      puts "  Task ID: #{task.task_id}"
      puts "\n"
    end
    self.start
  end

  def self.add
    proj = TM::Project.list_projects[@input_arr[1].to_i]
    proj.add_task(@input_arr[3..-1].join(" "), @input_arr[2])
    self.start
  end

  def self.mark
    TM::Project.complete_task(@input_arr[1].to_i, @input_arr[2].to_i)
    puts "  Task complete!"
    puts "\n"
    self.start
  end

  def self.exit
    puts "Goodbye!"
  end

end

TM::TerminalClient.help
TM::TerminalClient.start

# TO DO:
# Refactor input/split
# Fix list_incomplete sorting (by date + priority)
