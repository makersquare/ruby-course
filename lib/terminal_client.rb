require_relative 'task-manager.rb'
require 'io/console'

@cpl = TM::Project_list.new


puts "Welcome to ProjectManager Pro!"
puts "\nPlease press enter to view available commands."
variable = gets.chomp
puts "AVAILABLE COMMANDS"
puts "  help - Shows all these commands again"
puts "  list - Lists all projects"
puts "  create NAME - Create a new project with name=NAME"
puts "  show PID - Show remaining tasks for project with id=PID"
puts "  history PID - Show completed tasks for project with id=PID"
puts "  PID PRIORITY DESC - Adds a new task to the project with id=PID"
puts "  mark TID - Marks task with id=TID as complete"
answer = gets.chomp

while answer != "quit" do
  if answer == "help"
    puts "\nAVAILABLE COMMANDS"
    puts "  help - Shows all these commands again"
    puts "  list - Lists all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  PID PRIORITY DESC - Adds a new task to the project with id=PID"
    puts "  mark TID - Marks task with id=TID as complete"
    answer = gets.chomp
  end

  if answer.split(" ").first == "create"
    array = answer.split[1..-1]
    proj_name = array.join(' ')
    @cpl.add_project(proj_name)
    puts "#{@cpl.projects.last.name} was added"
    puts "\nWhat next?"
    answer = gets.chomp
  end


  if answer =="list"
    puts"\nPROJECTS:"
    @cpl.projects.each {|project| puts "#{project.name} ID:#{project.id}"}
    answer = gets.chomp
  end


end


