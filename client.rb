
require_relative 'lib/task-manager.rb'

class TM::TerminalClient

  attr_accessor :input1, :input2, :input3, :menu_item

  def initialize
    @input1 = nil
    @input2 = nil
    @input3 = nil
    @menu_item = nil
  end

  def self.start
    # self.help
    string = gets.chomp
    # REFACTOR:
    @menu_item = string.split[0]
    @input1 = string.split[1]
    @input2 = string.split[2]
    @input3 = string.split[3]
    self.options_list(@menu_item)
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
    puts "  mark TID - Mark task with id=TID as complete"
    puts "  exit – Exits Project Manager Pro®"
    puts "\n"
    self.start
  end

  def self.list
    TM::Project.list_projects.each do |proj|
      puts "\n"
      puts "  Project Name: #{proj.name}"
      puts "  Project ID: #{proj.project_id}"
    end
    self.start
  end

  def self.create
    TM::Project.new(@input1)
    self.start
  end

  def self.show
    proj = TM::Project.list_projects[@input1.to_i]
    proj.list_incomplete.each do |task|
      puts "\n"
      puts "  Description: #{task.description}"
      puts "  Priority: #{task.priority}"
      puts "  Created: #{task.creation_time}"
    end
    self.start
  end

  def self.history
    # puts "  history PID - Show completed tasks for project with id=PID"
    self.start
  end

  def self.add
    # puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    proj = TM::Project.list_projects[@input1.to_i]
    proj.add_task(@input3, @input2, @input1)
    self.start

    #<TM::Project:0xb89c0dd4
    # @completed_tasks=[],
    # @incompleted_tasks=[],
    # @name="Portfolio",
    # @project_id=5,
    # @tasks=[]>]
  end

  def self.mark
    # puts "  mark TID - Mark task with id=TID as complete"
    self.start
  end

  def self.exit
    puts "Goodbye!"
  end

end

TM::TerminalClient.help
TM::TerminalClient.start
