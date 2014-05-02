require 'pry-debugger'

class TM::Terminal_client

  attr_accessor :command

  def initialize
    @command = command
    puts"\t\tWelcome to Task Manager"
    puts "\tWhat would you like to do today?"
    puts "\tHelp - Show the list of commands"
    puts "\tList - List all projects"
    puts "\tCreate - Add a new project with name"
    puts "\tShow PID - Show incomplete tasks by project id"
    puts "\tCompleted tasks - Show complete tasks by project id=PID"
    puts "\tAdd Task - Add new task to a project with an id=PID"
    puts "\tMark complete - Mark task with an ID=TID"
    puts "\tPlease enter a command"
    @command = gets.chomp.downcase
    self.grab_input
  end

  def grab_input
    if @command == "help"
      TM::Terminal_client.new
    elsif @command == "create"
      self.create
    elsif @command == show
      TM::Project.pid




    end
  end

  def list
    TM::Task.add_task
  end

  # def create
  #   "Enter the name of the new project"
  #   new_project = gets.chomp
  # end


  de

end

