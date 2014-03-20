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
    puts "help - Show these commands again"
    puts "list - List all projects"
    puts "create NAME - Create a new project with name=NAME"
    puts "show PID - Show remaining tasks for project with id=PID"
    puts "history PID - Show completed tasks for project with id=PID"
    puts  "mark TID - Mark task with id=TID as complete"
    puts "add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "--------"
    puts  "Please type in the above commands"

    user_input = gets.chomp  #user_input = show 1

    user_input = user_input.split(" ")  #user_input_arr = ["show", "1"]


    if user_input[0] == "help"
      puts "list - List all projects
      show PID - Show remaining tasks for project with id=PID\n
      history PID - Show completed tasks for project with id=PID\n
      mark TID - Mark task with id=TID as complete\n"
      start
    end

    if user_input[0] == "list" # user input list run block
       if @pl.project_list.empty? #if no projects in array
         puts "\n"               #run this, others block not run
         puts "NO PROJECTS AT THE MOMENT"
         puts "\n"
       end


       if @pl.project_list.empty? == false #if there are projects
        @pl.project_list.each do |project|
          puts "\n"      # display project name
          puts "SHOWING PROJECTS   ---> #{project.name} with PID of #{project.id}"
          if project.task_list.empty? # if a project has not task
            puts "\n"                 # this will display
            puts "PROJECT #{project.name} HAS NO TASKS"
            puts "\n"
          else
            puts "\n"
            puts "PROJECT #{project.name} LIST OF TASKS" #below you want to iterate
            puts "--------"#through a projct's task_list and puts attr all tasks
            project.task_list.each do |task|
              puts "task ID: #{task.task_id}"
              puts "task is about #{task.descr}"
              puts "task PRIORITY: #{task.priority_num}"
              puts "task completion status: #{task.complete}"
              puts "--------"


            end
            puts "\n"
          end

        end
       end

    end

    if user_input[0] == "create"
      puts "\n"
      puts "WRITE PROJECT NAME"
      projectname = gets.chomp
      @pl.create(projectname)
      @pl.add_projects(projectname)
      puts "\n"
      puts "NEW PROJECT CREATED"
      puts "\n"
      start
    end

    if user_input[0] == "show"
       proj_id = user_input[1].to_i
       if @pl.list_task_remain(proj_id).empty?
         puts "\n"
         puts "NO REMAINING TASK AT THE MOMENT FOR PROJECT ID: #{proj_id}"
         puts "\n"
       else
          @pl.list_task_remain(proj_id).each do |task|
            puts "\n"
            puts "uncompleted task for project id of #{proj_id}"
            puts "--------"
            puts "task ID: #{task.task_id}"
            puts "task is about #{task.descr}"
            puts "task PRIORITY: #{task.priority_num}"
            puts "task completion status: #{task.complete}"
            puts "--------"
          end
       end


    end


   if user_input[0] == "history"
        projid = user_input[1].to_i
      if @pl.list_task_complete(projid).empty?
        puts "\n"
        puts "NO COMPLETED TASK AT THE MOMENT FOR PROJECT ID: #{projid}"
        puts "\n"
      else
        @pl.list_task_complete(projid).each do |task|
        puts "\n"
        puts "completed task for project id of #{projid}"
        puts "--------"
            puts "task ID: #{task.task_id}"
            puts "task is about #{task.descr}"
            puts "task PRIORITY: #{task.priority_num}"
            puts "task completion status: #{task.complete}"
            puts "--------"
        end
      end
    end

      if user_input[0] == "mark"
      task_id = user_input[1].to_i
      @pl.project_list.each do |project|
        if project.has_task?(task_id)

          project.task_list.each do |task|
             if task.task_id == task_id
                 puts "\n"
                 puts "task is now completed"
                 puts "\n"
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
    puts "\n"
    puts "ADDED SUCCESSFULLY"
    puts "\n"
   end

   return user_input.join(" ")

  end






end

# while true
#   user_input = tc.start
#   break if user_input == "quit"
# end
tc = TM::TerminalClient.new
while true

  tc.start

  user_input = tc.start
  break if user_input == "quit"
end



