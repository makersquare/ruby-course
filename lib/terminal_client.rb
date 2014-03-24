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

          else
           puts "Project name                                Project ID \n"
           puts "______________________________________________________\n"
              proj.project_list.each do |project|
                   puts "#{project.name}                                           #{project.project_id}"
              end
              puts "\n"

           command_list
           @ans = gets.chomp

        elsif @ans.split[0] == 'add'
          pid = @ans.split[1].to_i
          priority = @ans.split[2].to_i
          description = @ans.split[3..-1]
          description = description.join(" ")

          selected_proj = proj.project_list.find {|project| project.project_id == pid }
          selected_proj.add_task(description, priority)

          puts '\n'
          puts "New task added to project '#{selected_proj.name}'."

          puts "Project ID #{selected_proj.project_id}: '#{selected_proj.name}' "
          puts '______________________________________________________'

          puts "Task ID: #{selected_proj.tasks[-1].task_id}"
          puts "Task Description: '#{selected_proj.tasks[-1].description}'\n\n"
          puts "Task Priority: #{selected_proj.tasks[-1].priority}"

          command_list
          @ans = gets.chomp

        elsif @ans.split[0] == 'show'
          pid = @ans.split[1].to_i
          selected_proj = proj.project_list.find {|project| project.project_id == pid }
          puts "Project ID #{selected_proj.project_id}: '#{selected_proj.name}' "
          puts '______________________________________________________'
          selected_proj.incomplete_tasks.each {|task| puts "Task ID: #{task.task_id} '#{task.description}'"}

          command_list
          @ans = gets.chomp


        elsif @ans.split[0] == 'history'
          pid = @ans.split[1].to_i
          selected_proj = proj.project_list.find {|project| project.project_id == pid }
          puts "Project ID #{selected_proj.project_id}: '#{selected_proj.name}' "
          puts '______________________________________________________'
          selected_proj.completed_tasks.each {|task| puts "Task ID: #{task.task_id} '#{task.description}'"}

          command_list
          @ans = gets.chomp


        elsif @ans.split[0] == 'mark'
          task_id = @ans.split[1].to_i
          proj.project_list
          selected_proj = proj.project_list.find {|project| project.tasks.find {|task| task.task_id == task_id} }
          proj.mark_complete(selected_proj.project_id, task_id)
          puts '\n'
          puts "Task #{task_id} is now complete. \n"

          command_list
          @ans = gets.chomp
        else

          "Not a valid command."

          command_list
          @ans = gets.chomp

        end
  end


end

