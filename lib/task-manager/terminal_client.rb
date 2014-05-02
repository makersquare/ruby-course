require 'pry-debugger'
class TM::TerminalClient
  attr_accessor :answer

  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
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
    puts "Enter a choice: "
    @answer = gets.chomp.downcase.split(' ')
    @choice = @answer[0]
    run(@choice)
  end

  def run(answer)
    case answer
        #lists all available commands
      when 'help'
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
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #lists all projects
      when 'list'
        TM::Project.list_all
        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #creates a new project with inputted name
      when 'create'
        TM::Project.new(@answer[1].capitalize!)
        puts "Project #{@answer[1]} Created. Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @choice[0]
        run(@choice)
        #shows incomplete tasks for inputted project
      when 'show'
        project = TM::Project.find_project(@answer[1].to_i)
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

        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #shows completed tasks for inputted project
      when 'history'
        project = TM::Project.find_project(@answer[1].to_i)
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

        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #adds a new task with PID PRIORITY DESC
      when 'add'
        temp_answer = @answer.dup
        temp_answer.slice!(0, 3)
        description = temp_answer.join(' ')
        project = TM::Project.find_project(@answer[1].to_i)
        if project != nil
          project.add_task(TM::Task.new(description, @answer[1].to_i, @answer[2].to_i))
          puts "Task added to #{project.name}."
        else
          puts "There is not a project with that ID."
        end

        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #marks task with inputted id as complete
      when 'mark'
        TM::Task.mark_complete(@answer[1].to_i)
        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #adds new tag to task with TID
      when 'tag'
        temp_answer = @answer.dup
        temp_answer.slice!(0,3)
        task = TM::Task.find_task(@answer[2].to_i )
        if task != nil
          task.add_tags(temp_answer)
          puts "Tags added to #{task.description}."
        else
          puts "There is not a task with that ID."
        end
        puts "Enter another command (help for list of command options) or exit if you wish to stop."
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
        #ending the task manager
      when 'exit'
        puts "Goodbye"
        #command is not valid
      else
        puts "That was not a valid option. Please enter another option. "
        @answer = gets.chomp.downcase.split(' ')
        @choice = @answer[0]
        run(@choice)
      end
    end
end
