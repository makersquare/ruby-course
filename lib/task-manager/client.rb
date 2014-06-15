class TM::TerminalClient

  def run
    puts "Please, enter a command."
    user_input = gets.chomp
    split_input = user_input.split

    user_cmd = split_input[0]
    self.parse(user_cmd, split_input)

  end

  def parse(user_cmd, split_input)

    case user_cmd
    when "help"
      puts ""
      puts "You can use these commands:"
      puts ""
      puts "help ------------------ Show these commands again"
      puts "list ------------------ List all projects"
      puts "add NAME -------------- Add a new project with a name"
      puts "create PID, DESC, PRI-- Create a task with the given attributes"
      puts "show PID -------------- Show remaining tasks for a given project by PID"
      puts "history PID ----------- Show completed tasks for a given project, by PID" 
      puts "complete TID ---------- Mark a task as complete by TID" 
      puts "exit ------------------ Leave the terminal"
      puts ""
    when "list"
      TM::Project.projects_list.each do |project|
        puts project.name
      end
      puts ""
    when "add"
      TM::Project.new split_input[1..-1].join(' ')
      TM::Project.projects_list.each do |project|
        puts project.name
      end
      puts ""
    when "create"
      TM::Task.new split_input[1], split_input[2..-2].join(' '), split_input[-1]
      TM::Task.tasks_list.each do |task|
        puts task.project_id
        puts task.description
        puts task.priority
        puts task.task_id
      end
      puts ""
    when "show"
      TM::Task.tasks_list.each do |task|
        if task.project_id == split_input[1] && task.status == :incomplete
          puts task.project_id
          puts task.description
          puts task.priority
        end
      end
      puts ""
    when "history"
      TM::Task.tasks_list.each do |task|
        if task.project_id == split_input[1] && task.status == :complete
          puts task.project_id
          puts task.description
          puts task.priority
        end
      end
      puts ""
    when "complete"
      TM::Task.mark_complete split_input[1]
      # TM::Task.tasks_list.each do |task|
      #   if task.task_id == split_input[1]
      #     puts task.status
      #   end
      # end
      puts ""
    when "exit"
      return 
    else 
      puts "That is not a command. Please, enter a command from the available list."
      puts ""
    end

    run
  end
end