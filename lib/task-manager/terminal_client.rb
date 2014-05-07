require 'pry-debugger'
class TM::TerminalClient

  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    list_commands
    get_user_input
  end

  def get_user_input
    puts "Enter a command (help for list of command options) or exit if you wish to stop."
    input = gets.chomp.downcase.split()
    run(input)
  end

  def list_commands
    puts "Available Commands:
          help - Show these commands again
          list - List all projects
          create NAME - Create a new project with name=NAME
          show PID - Show remaining tasks for project with id=PID
          history PID - Show completed tasks for project with id=PID
          add PID PRIORITY DESC - Add a new task to project with id=PID
          mark TID - Mark task with id=TID as complete
          tag add TID TAG - Add a new tag to a task with id=TID
          exit - exits project manager"
  end

  def run(input)
    option = input.first

    case option
        #lists all available commands
      when 'help'
        list_commands
        get_user_input
        #lists all projects
      when 'list'
        TM::Project.list_all
        get_user_input
        #creates a new project with inputted name
      when 'create'
        TM::Project.new(input[1].capitalize!)
        puts "Project #{input[1]} Created."
        get_user_input
        #shows incomplete tasks for inputted project
      when 'show'
        project = TM::Project.find_project(input[1].to_i)
        if project != nil
          tasks = project.incomplete_tasks
          if tasks.length != 0
            #display organization
            tasks.each do |task|
              if task.options[:due_date] < Date.today
                puts "OVERDUE: #{task.options[:due_date]} - Priority: #{task.priority} - Task ID: #{task.task_id} - Description: #{task.description} - Tags: #{task.options[:tags]}"
              else
                puts "Due Date: #{task.options[:due_date]} - Priority: #{task.priority} - Task ID: #{task.task_id} - Description: #{task.description} - Tags: #{task.options[:tags]}"
              end
            end
          else
            puts "This project has no incomplete tasks."
          end
        else
          puts "There is not a project with that ID."
        end
        get_user_input
        #shows completed tasks for inputted project
      when 'history'
        project = TM::Project.find_project(input[1].to_i)
        if project != nil
          tasks = project.completed_tasks
          if tasks.length != 0
            #display organization
            tasks.each do |task|
              puts "Description: #{task.description} - Task ID: #{task.task_id} - Completed: #{task.date_completed}"
            end
          else
            puts "This project has no completed tasks."
          end
        else
          puts "There is not a project with that ID."
        end
        # TM::Project.show_completed_tasks(@answer[1].to_i)

        get_user_input
        #adds a new task with PID PRIORITY DESC
      when 'add'
        temp_answer = input.dup
        temp_answer.slice!(0, 3)
        description = temp_answer.join(' ')
        project = TM::Project.find_project(input[1].to_i)
        if project != nil
          project.add_task(TM::Task.new(description, input[1].to_i, input[2].to_i))
          puts "Task added to #{project.name}."
        else
          puts "There is not a project with that ID."
        end

        get_user_input
        #marks task with inputted id as complete
      when 'mark'
        TM::Task.mark_complete(input[1].to_i)
        get_user_input
        #adds new tag to task with TID
      when 'tag'
        temp_answer = input.dup
        temp_answer.slice!(0,3)
        task = TM::Task.find_task(input[2].to_i )
        if task != nil
          task.add_tags(temp_answer)
          puts "Tags added to #{task.description}."
        else
          puts "There is not a task with that ID."
        end
        get_user_input
        #ending the task manager
      when 'exit'
        puts "Goodbye"
        #command is not valid
      else
        puts "That was not a valid option."
        get_user_input
      end
    end
end
