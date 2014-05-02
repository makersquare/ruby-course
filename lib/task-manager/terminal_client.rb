require 'pry-debugger'

class TM::Terminal_client

  attr_accessor :command

  def initialize
    @command = command
    puts"\t\tWelcome to Task Manager"
    puts "\tWhat would you like to do today?"
    puts "\tHelp - Show the list of commands"
    puts "\tList - List all incomplete tasks by PID"
    puts "\tShow - Show complete tasks by project id"
    puts "\tAdd Task - Add new task to a project with name, priority, and ID"
    puts "\tMark complete - Mark task with an ID=TID"
    puts "\tPlease enter a command"
    @command = gets.chomp.downcase
    self.grab_input
  end

  def grab_input
    if @command == "help"
      TM::Terminal_client.new
    elsif @command == "list"
       @project1.incomplete_tasks
    elsif @command == "show"
       @project1.completed_tasks
    elsif @command == "task"
        puts "\tPlease enter the new task "
        new_task = gets.chomp
        puts "\tPlease enter the priority"
        priority = gets.chomp
        puts "\tPlease enter the tasks PID"
        pid = gets.chomp
        TM::Task.new(new_task, priority, pid)
    elsif @command = "mark complete"
        tid = gets.chomp
        TM::Task.is_complete(tid)
    else
      "Please enter a command"
    end




    end
  end

  def list
    TM::Task.add_task
  end

  # def create
  #   "Enter the name of the new project"
  #   new_project = gets.chomp
  # end

end

