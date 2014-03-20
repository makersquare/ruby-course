require_relative 'task-manager.rb'
require 'io/console'

@client_list = TM::ProjectList.new

welcome = "Welcome to Project Manager Pro."
help = "Please enter a valid command\nAvailable Commands:\n   help - Show these commands again\n   list - List all projects\n   create NAME - Create a new project with name=NAME\n   add PID PRIORITY DESC - Add a new task to project with id=PID\n   history PID - show completed tasks for a project with id=PID\n   mark TID - Mark task with id=TID as complete"

puts welcome
puts "Press enter to view valid commands"
doNothing = gets.chomp
puts help
answer = gets.chomp

while answer != "quit" do
  if answer == "help"
    puts help
    answer = gets.chomp
  end

  if answer == "list"
    puts "\nPROJECTS:"
    @client_list.projects.each do |project|
      puts "Project Name: #{project.name}, Project ID: #{project.id}"
    end

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
  end

  if answer.split.first == "create"
    newarray = answer.split[1..-1]
    this_is_it = newarray.join(' ')
    @client_list.add_project(this_is_it)
    puts "\n#{@client_list.projects.last.name} was successfully created"

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
  end

  if answer.split.first == "add"
    newarray = answer.split[1..-1]
    priority = newarray[-1]
    p_id = newarray[-2]
    desc = newarray[0..-3].join(" ")
    @client_list.add_task(desc, p_id, priority)
    puts "\n#{@client_list.projects.last.task.description} was successfully added to the #{@client_list.projects.last.name} project"

    puts "\nWhat would you like to do next?"
    answer = gets.chomp
  end

  # # if answer.split.first == "show"
  # # end



  # end

end

# if answer == "help"
#   puts help
#   answer = gets.chomp
# end

# when answer == "list"
#   then
# when answer == "show PID"
#   then
# when answer == "history PID"
#   then
# when
