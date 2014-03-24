module TM
end
#require 'pry-debugger'

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/project_list.rb'

class TM::Terminal


  def self.command_list
    puts "\nCommands List"
    puts "  \n
          help - Show these commands again
          list - List all projects
          create NAME - Create a new project with name=NAME
          show PID - Show remaining tasks for project with id=PID
          history PID - Show completed tasks for project with id=PID
          add PID PRIORITY DESC - Add a new task to project with id=PID
          mark TID - Mark task with id=TID as complete"
  end

  proj = TM::ProjectList.new

  puts " \nWelcome to Project Manager Pro. What can I do for you today? \n"
  puts self.command_list

  @ans = gets.chomp.downcase


  while @ans != 'quit' || @ans != 'stop' || @ans != 'exit'

       if @ans == 'help'
         puts self.command_list
         @ans = gets.chomp


        elsif @ans.split[0] == 'create'
           split_array = @ans.split[1..-1]
           array = split_array.join(" ")
           proj.add_project(array)
           puts ""
           puts "A new project #{@ans.split[1]} has been created. \n "
           puts "Project List: \n"
           puts "Project name                                Project ID \n"
           puts "______________________________________________________\n"
              proj.project_list.each do |project|
                   puts "#{project.name}                                           #{project.project_id}"
              end
              puts "\n"

           command_list
           @ans = gets.chomp

        elsif @ans == 'list'
          if proj.project_list == []
            puts "There are no Projects on File."






        end
  end


end

