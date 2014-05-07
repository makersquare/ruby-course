require_relative '../task_manager.rb'
require 'pry-debugger'


class TM::TerminalClient
  def self.start
    manager = TM::TerminalClient.new
    @@user = ""
    @@exit = false
    while @@exit == false
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts ""
    puts ""
    puts "Here are the available Commands you can interact with:" .colorize(:green)
    puts
    puts " help - Show these commands again"
    puts " list - List all the projects"
    puts " create NAME - Create a new project with name=NAME"
    puts " add PID PRIORITY DESC' - Add a new task to project with id=PID"
    puts " show PID - Show remaining tasks for project with id=PID"
    puts " history PID - to show completed tasks for project with id=PID"
    puts " mark TID - Mark task with id=TID as complete"
    puts " exit - Exit the program"
    @@user = gets.chomp
    user_input = @@user.downcase.split(' ')


      if user_input == "help"
        manage.help
      elsif user_input == "list"
        manage.get_projects
      elsif user_input == "show"
        manage.show_tasks
      elsif user_input == "add"
        manage.add_task
      elsif user_input == "history"
        manage.tasks_record
      elsif user_input == "mark"
        manage.complete_task
      elsif "create"
        manage.create_new_project
      elsif user_input == "exit"
        @@exit = true
      else puts "Sorry #{user_input} is not a valid command"
      puts "Please follow the instructions or use help"
        end
      end
    end
end





