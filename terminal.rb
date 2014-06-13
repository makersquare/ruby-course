require 'pry-debugger'
require_relative 'lib/task-manager.rb'

class Terminal
  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?\n"
    instructions
    @projects = []
    input = gets.chomp
    commandline(input)
  end

  def commandline(input) # TODO: list, assuming all numbers are one digit
    input = input.split
    if input[0] == 'help'
      instructions
    elsif input[0] == 'create'
      @projects << TM::Project.new(input[1]) # input[7..-1] == NAME
    elsif input[0] == 'show'
      @pid = input[1].to_i
      @projects[@pid].show_tasks
    elsif input[0] == 'history'
      @pid = input[1].to_i
      @projects[@pid].show_done
    elsif input[0] == 'add'
      @pid = input[1].to_i
      key = input[2].to_i
      desc = input[3]
      @projects[@pid].create_task(desc, key)
    elsif input[0] == 'mark'
      tid = input[1]
      @projects[@pid].finish(tid)
    elsif input[0] == 'list'
      puts "your projects are:"
      @projects.each do |project|
        puts "  #{project.name}"
      end
    else
      puts "type help to repeat options"
    end

    input = gets.chomp
    commandline(input)
  end
  def instructions
    puts "Available Commands:"
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark TID - Mark task with id=TID as complete"
  end
end

Terminal.new
