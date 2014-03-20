require_relative 'lib/task-manager.rb'
require 'pry-debugger'
class TM::TerminalClient

  def initialize
    @pl = TM::Projectlist.new
  end
#$ bundle exec ruby tc.rb type this in console.

  def start


    puts "Welcome to Project Manager Pro®. What can I do for you today?"

    puts "Available Commands:"
    puts "help - Show these commands again\n
      list - List all projects\n
      create NAME - Create a new project with name=NAME\n
      show PID - Show remaining tasks for project with id=PID\n
      history PID - Show completed tasks for project with id=PID\n
      mark TID - Mark task with id=TID as complete\n
      add PID PRIORITY DESC - Add a new task to project with id=PID\n
      Please type in the above commands\n"

    user_input = gets.chomp  #user_input = show 1

    user_input = user_input.split(" ")  #user_input_arr = ["show", "1"]


    if user_input[0] == "help"
      puts "list - List all projects\n
      show PID - Show remaining tasks for project with id=PID\n
      history PID - Show completed tasks for project with id=PID\n
      mark TID - Mark task with id=TID as complete\n"
    end

    if user_input[0] == "list"
       p @pl.project_list

       start
    end

    if user_input[0] == "create"
      puts "write project name"
      projectname = gets.chomp
      @pl.create(projectname)
      @pl.add_projects(projectname)
      puts "New project created"
      start
    end

    if user_input[0] == "show"
       proj_id = user_input[1].to_i
       if @pl.list_task_remain(proj_id).empty?
         puts "no remaining task at the moment"
       else
         p @pl.list_task_remain(proj_id)
       end


    end


   if user_input[0] == "history"
        projid = user_input[1].to_i
      if @pl.list_task_complete(projid).empty?
        puts "no completed tasks at the moment"
      else
        p @pl.list_task_complete(projid)
      end
    end

      if user_input[0] == "mark"
      task_id = user_input[1].to_i
      @pl.project_list.each do |project|
        if project.has_task?(task_id)

          project.task_list.each do |task|
             if task.task_id == task_id
                 return task.complete = true
             end
          end
        end

      end

    end

   if user_input[0] == "add"
    projid = user_input[1].to_i
    eating_better = TM::Task.new(1,"diet",1,2)
    @pl.add_task_project(projid,eating_better)
    puts "added successfully"
   end

  return user_input.join(" ")
end






end

# while true
#   user_input = tc.start
#   break if user_input == "quit"
# end

while true
  tc = TM::TerminalClient.new
  tc.start

  user_input = tc.start
  break if user_input == "quit"
end



