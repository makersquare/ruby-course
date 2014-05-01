require 'date'

class TM::Terminal

  attr_accessor :choice

  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "Available Commands:
              help - Show these commands again
              list - List all projects
              create - Create a new project with name=NAME
              show  - Show remaining tasks for project with id=PID
              history  - Show completed tasks for project with id=PID
              add  - Add a new task to project with id=PID
              mark - Mark task with id=TID as complete"
    @choice = gets.chomp.downcase
    menu(@choice)
  end

  def menu(choice)
    case choice
      when 'help'
        puts "Available Commands:
                help - Show these commands again
                list - List all projects
                create - Create a new project with name=NAME
                show  - Show remaining tasks for project with id=PID
                history  - Show completed tasks for project with id=PID
                add - Add a new task to project with id=PID
                mark - Mark task with id=TID as complete"
        puts "Please input what you would like to do from the list above:"
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'list'
        TM::Project.projects.each {|x| puts x.name}
      when 'create'
        puts "What would you like to name the new project?"
        title = gets.chomp
        title = TM::Project.new(title)
        puts "Congratulations! #{title.name} project has been created."
      when 'show'
        puts "What project would you like to see the remaining tasks for?"
        project1 = gets.chomp
        for i in 0...TM::Project.projects.length
          if TM::Project.projects[i].name == project1
            TM::Project.projects[i].incomplete_tasks()
          end
          puts TM::Project.projects[i].incomplete_tasks().each {|x| puts x.description}
        end
      when 'history'
        puts "What project would you like to see the completed tasks for?"
        project1 = gets.chomp
        for i in 0...TM::Project.projects.length
          if TM::Project.projects[i].name == project1
            TM::Project.projects[i].completed_tasks()
          end
          puts TM::Project.projects[i].completed_tasks().each {|x| puts x.description}
        end
      when 'add'
        puts "What is the project you would like to add a task to?"
        project_task = gets.chomp
        puts "What is the project id of the new task?"
        task_id = gets.chomp.to_i
        puts "What is the task description?"
        task_description = gets.chomp
        puts "what is the priority of the task?"
        task_priority = gets.chomp.to_i
        puts "Do you want to assign a due date to this task?"
        task_due_date = gets.chomp
        for i in 0...TM::Project.projects.length
          if TM::Project.projects[i].name == project_task
            TM::Project.projects[i].create_task(task_id,task_description,task_priority,task_due_date)
          end
          TM::Project.projects[i].create_task(task_id,task_description,task_priority, task_due_date)
          puts TM::Project.projects[i].incomplete_tasks().each {|x| puts x.description}
        end
      when 'mark'
        puts "What is the project in which you would like to mark a task as complete?"
        project_task_complete = gets.chomp
        puts "What is the task id that you want to mark as complete?"
        task_id_complete = gets.chomp.to_i
        for i in 0...TM::Project.projects.length
          if TM::Project.projects[i].name == project_task_complete
            TM::Project.projects[i].mark_complete(task_id_complete)
          end
          TM::Project.projects[i].mark_complete(task_id_complete)
          puts TM::Project.projects[i].completed_tasks().each {|x| puts x.description}
        end
      else
        puts "Rock on King Kong"
      end
  end
end

