require_relative 'lib/task-manager.rb'
require 'pry-debugger'
class TM::TerminalClient

  def initialize
    @pl = TM::Projectlist.new
  end

  def start
    puts "Welcome to Project Manager Pro®. What can I do for you today?"

    puts "Available Commands:"
    puts "help - Show these commands again\n
      list - List all projects\n
      show PID - Show remaining tasks for project with id=PID\n
      history PID - Show completed tasks for project with id=PID\n
      mark TID - Mark task with id=TID as complete\n
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
       puts @pl.project_list

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
       @pl.add_projects("Fitness")
       @pl.add_projects("Work")
       if @pl.list_task_remain == []
         puts "no remaining task at the moment"
       else
         @pl.list_task_remain
       end


    end

    if user_input[0] == "history"
      @pl.add_projects("Fitness")
      @pl.add_projects("Work")
      if @pl.list_task_complete == []
         puts "no completed task at the moment"
      else
        @pl.list_task_complete
      end
    end

    if user_input[0] == "mark"
      @pl.add_projects("Fitness")
      @pl.add_projects("Work")
      p @pl.mark_task_complete
    end

user_input = gets.chomp


 # it "list task" do
 #    pl = TM::Projectlist.new
 #    pl.add_projects("fitness")
 #    expect(pl.list_task).to eq []
 #  end



    # if user_input == "list"


    # end

    # if user_input_arr.first == "show"
    #     # find the project that matches the proj id given by user_input
    #     project_found = nil
    #     projects_arr.each do |proj|
    #         project_found = proj if proj.id == user_input_arr.last.to_i # "1" => 1
    #     end

    #    puts "Showing Project #{project_found.name}"
    #     puts "Priority    ID  Description"
    #     project_found.task_list.each do |task|
    #         puts "#{task.priority_num} #{task.task_id} #{task.descr}"
    #     end


  end
end

tc = TM::TerminalClient.new
tc.start



