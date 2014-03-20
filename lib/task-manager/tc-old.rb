require_relative 'lib/task-manager.rb'
class TM::TerminalClient

  def self.start
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
    # return user_input

    if user_input[0] == "help"
      puts "list - List all projects\n
      show PID - Show remaining tasks for project with id=PID\n
      history PID - Show completed tasks for project with id=PID\n
      mark TID - Mark task with id=TID as complete\n"
    end

    if user_input[0] == "list"
       pl = TM::Projectlist.new
       pl.add_projects("Fitness")
       pl.add_projects("Work")
       p pl.project_list

    end

    if user_input[0] == "show"

      pl = TM::Projectlist.new
      pl.add_projects("Fitness")
      pl.add_projects("Work")




      pl.list_task_remain(user_input[1])

    end



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

TM::TerminalClient.start


