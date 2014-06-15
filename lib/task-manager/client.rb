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
      puts ""
      puts "Projects in the database:"
      TM::Project.projects_list.each do |project|
        puts project.name
      end
      puts ""
    when "add"
      puts ""
      project_name = split_input[1..-1].join(' ')
      TM::Project.new project_name
      puts ""
      puts "The following project has been added to the database: #{project_name}"
      puts ""
    when "create"
      puts ""
      project_id = split_input[1]
      task_description = split_input[2..-2].join(' ')
      task_priority = split_input[-1]
      TM::Task.new project_id, task_description, task_priority
      puts "The following task has been added to the database:"
      puts "Project ID: #{project_id}"
      puts "Task description: #{task_description}"
      puts "Task priority: #{task_priority}"
      puts ""
    when "show"
      puts ""
      project_id = split_input[1]
      puts "The following tasks are incomplete for project #{project_id}:"
      TM::Task.tasks_list.each do |task|
        if task.project_id == split_input[1] && task.status == :incomplete
          puts task.description
        end
      end
      puts ""
    when "history"
      puts ""
      project_id = split_input[1]
      puts "The following tasks are complete for project #{project_id}:"
      TM::Task.tasks_list.each do |task|
        if task.project_id == split_input[1] && task.status == :complete
          puts task.description
        end
      end
      puts ""
    when "complete"
      puts ""
      task_id = split_input[1]
      TM::Task.mark_complete task_id
      puts "The following task has been marked complete in the database: #{task_id}"
      puts ""
    when "exit"
      return 
    else
      puts ""
      puts "That is not a command. Please, enter a command from the available list."
      puts ""
    end

    run
  end
end