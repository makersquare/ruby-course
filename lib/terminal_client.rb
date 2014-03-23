require_relative 'task-manager.rb'
require 'io/console'
require 'colorize'

@cpl = TM::Projectlist.new


puts "\nWelcome to ProjectManager Pro!".yellow
puts "\nPlease press enter to view available commands.".yellow
variable = gets.chomp
puts "AVAILABLE COMMANDS".blue
print"  help".red
puts " - Shows all these commands again"
print"  list".red
puts " - Lists all projects"
print"  create NAME".red
puts " - Create a new project with name=NAME"
print"  show PID".red
puts " - Show remaining tasks for project with id=PID"
print"  history PID".red
puts " - Show completed tasks for project with id=PID"
print"  add PID PRIORITY DESC".red
puts " - Adds a new task to the project with id=PID"
print"  mark TID".red
puts " - Marks task with id=TID as complete"
print"  quit".red
puts " - Exits the program"
answer = gets.chomp

while answer != "quit" do
  if answer == "help"
    puts "\nAVAILABLE COMMANDS".blue
    print"  help".red
    puts " - Shows all these commands again"
    print"  list".red
    puts " - Lists all projects"
    print"  create NAME".red
    puts " - Create a new project with name=NAME"
    print"  show PID".red
    puts " - Show remaining tasks for project with id=PID"
    print"  history PID".red
    puts " - Show completed tasks for project with id=PID"
    print"  add PID PRIORITY DESC".red
    puts " - Adds a new task to the project with id=PID"
    print"  mark TID".red
    puts " - Marks task with id=TID as complete"
    print"  quit".red
    puts " - Exits the program"
    answer = gets.chomp
  # end
# <----------creates a new project----------->
  elsif answer.split(" ").first == "create"
    array = answer.split[1..-1]
    proj_name = array.join(' ')
    @cpl.add_project(proj_name)
    puts "\n#{@cpl.projects.last.name} was added"
    puts "\nWhat next?"
    answer = gets.chomp
  # end

# <------------lists projects--------------->

  elsif answer =="list"
    puts"\nPROJECTS:"
    @cpl.projects.each {|project| puts "#{project.name} ID:#{project.id}"}
    answer = gets.chomp
  # end
# <-----------------shows incomplete tasks-------------->
  elsif answer.split(" ").first =="show"
    project_id = answer.split[1].to_i
    project = @cpl.projects.find{|project| project.id == project_id}
    puts "\n#{project.name}: Incomplete Tasks."
    project.retrieve_incomplete.each{|task| puts "Task ID: #{task.task_id}. Task Description: #{task.description}. Priority:#{task.priority}"}
    puts "\nWhat next?"
    answer = gets.chomp
  # end

  # <---------changes task status to complete------------->

  elsif answer.split(" ").first =="mark"
    task_id = answer.split[1].to_i
    project = @cpl.projects.find do |project|
      project.tasks.find{|task| task.task_id==task_id}
    end
    task = project.tasks.find{|task| task.task_id==task_id}
    project.complete(task_id)
    puts "\nYou set the status of: '#{task.description}' to completed."
    puts "\n What next?"
    answer = gets.chomp
  # end

  # <------------gives history of completed tasks------------>

  elsif answer.split(" ").first =="history"
    project_id = answer.split[1].to_i
    project = @cpl.projects.find{|project| project.id == project_id}
    puts "#{project.name} completed tasks:"
    project.retrieve_completed.each{|task| puts "Task Description: #{task.description}."}
    puts "\nWhat next?"
    answer = gets.chomp
  # end
# <-------adds a new task------------->
  elsif answer.split(" ").first == "add"
    array = answer.split(" ")
    project_id = array[1].to_i
    priority = array[2].to_i
    description = array[3..-1].join(' ')
    puts description
    @cpl.add_task(project_id, priority, description)
    project = @cpl.projects.find{|project| project.id ==project_id}
    puts "\nYou added '#{description}' to Project: #{project.name}."
    puts "\nWhat would you like to do next?"
    answer = gets.chomp
  # end
  else
  puts "\nYou entered an invalid command."
  puts "Enter help to get a list of valid commands"
  answer = gets.chomp
end

end


