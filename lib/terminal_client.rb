require_relative 'task-manager.rb'
require 'io/console'

@cpl = TM::Project_list.new


puts "\nWelcome to ProjectManager Pro!"
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
# <----------creates a new project----------->
  if answer.split(" ").first == "create"
    array = answer.split[1..-1]
    proj_name = array.join(' ')
    @cpl.add_project(proj_name)
    puts "\n#{@cpl.projects.last.name} was added"
    puts "\nWhat next?"
    answer = gets.chomp
  end

# <------------lists projects--------------->

  if answer =="list"
    puts"\nPROJECTS:"
    @cpl.projects.each {|project| puts "#{project.name} ID:#{project.id}"}
    answer = gets.chomp
  end
# <-----------------shows incomplete tasks-------------->
  if answer.split(" ").first =="show"
    project_id = answer.split[1].to_i
    project = @cpl.projects.find{|project| project.id == project_id}
    puts "\n #{project.name}: Incomplete Tasks."
    project.retrieve_incomplete.each{|task| puts "Task ID: #{task.task_id}. Task Description: #{task.description}. Priority:#{task.priority}"}
    puts "\nWhat next?"
    answer = gets.chomp
  end

  # <---------changes task status to complete------------->

  if answer.split(" ").first =="mark"
    task_id = answer.split[1].to_i
    project = @cpl.projects.find do |project|
      project.tasks.find{|task| task.task_id==task_id}
    end
    task = project.tasks.find{|task| task.task_id==task_id}
    project.complete(task_id)
    puts "\nYou set the status of: '#{task.description}' to completed."
    puts "\n What next?"
    answer = gets.chomp
  end

  # <------------gives history of completed tasks------------>

  if answer.split(" ").first =="history"
    project_id = answer.split[1].to_i
    project = @cpl.projects.find{|project| project.id == project_id}
    puts "#{project.name} completed tasks:"
    project.retrieve_completed.each{|task| puts "Task Description: #{task.description}."}
    puts "\nWhat next?"
    answer = gets.chomp
  end
# <-------adds a new task------------->
  if answer.split(" ").first.to_i >= 1
    array = answer.split(" ")
    project_id = array[0].to_i
    priority = array[1].to_i
    description = array[2..-1].join(' ')
    puts description
    @cpl.add_task(project_id, priority, description)
    project = @cpl.projects.find{|project| project.id ==project_id}
    puts "\nYou added '#{description}' to Project: #{project.name}."
    puts "\nWhat would you like to do next?"
    answer = gets.chomp
  end
end


