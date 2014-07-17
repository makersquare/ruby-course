require 'date'

class TM::Terminal

  attr_accessor :choice

  def initialize
    @db = TM::DB.new
    @k = 0
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
        if @db.projects.length == 0
          puts "There are no projects currently"
        else
          @db.projects.each {|x,y| puts y[:name]}
        end
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'create'
        puts "What would you like to name the new project?"
        title = gets.chomp
        @db.create_project(name: title)
        puts "Congratulations! #{@db.projects[@k][:name]} project has been created."
        @k+=1
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'show'
        puts "What project would you like to see the remaining tasks for?"
        project1 = gets.chomp.to_i
        # for i in 0...@db.projects.length
        #   if @db.projects[i][:name] == project1
        #      list = @db.get_all_incomplete_tasks_for_project(@db.projects[i][:project_id])
        #      p list
          # end
        p @db.get_all_incomplete_tasks_for_project(project1)
          # puts TM:.projects[i].incomplete_tasks().each {|x| puts x.description}
          # p @db.get_all_incomplete_tasks_for_project(@db.projects[i][:project_id])
        # end
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'history'
        puts "What project would you like to see the completed tasks for?"
        project1 = gets.chomp.to_i
        # for i in 0...@db.projects.length
        #   if @db.projects[i][:name] == project1
        #     @db.get_all_completed_tasks_for_project(@db.projects[i][:project_id])
        #   end
        #   p @db.get_all_completed_tasks_for_project(@db.projects[i][:project_id])
        # end

        p @db.get_all_completed_tasks_for_project(project1)
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'add'
        puts "What is the project you would like to add a task to?"
        project_task = gets.chomp
        puts "What is the project id of the new task?"
        task_id = gets.chomp.to_i
        puts "What is the name of the task?"
        task_name = gets.chomp
        puts "What is the task description?"
        task_description = gets.chomp
        puts "what is the priority of the task?"
        task_priority = gets.chomp.to_i
        puts "Do you want to assign a due date to this task?"
        task_due_date = gets.chomp
        for i in 0...@db.projects.length
          if @db.projects[i][:name] == project_task
            # TM::Project.projects[i].create_task(task_id,task_description,task_priority,task_due_date)
            @db.create_task(name: task_name, project_id: task_id, description: task_description, priority: task_priority, status: 'incomplete' , due_date: task_due_date)
          end
          # TM::Project.projects[i].create_task(task_id,task_description,task_priority, task_due_date)
          # @db.create_task(name: task_name, project_id: task_id, description: task_description, priority: task_priority, status: 'incomplete' , due_date: task_due_date)
          # puts TM::Project.projects[i].incomplete_tasks().each {|x| puts x.description}
          p @db.get_all_incomplete_tasks_for_project(task_id)
        end
        @choice = gets.chomp.downcase
        menu(@choice)
      when 'mark'
        # puts "What is the project in which you would like to mark a task as complete?"
        # project_task_complete = gets.chomp.to_i
        puts "What is the task id that you want to mark as complete?"
        task_id_complete = gets.chomp.to_i
        test_task = @db.get_task(task_id_complete)
        test_task.status = 'complete'
        @db.update_task(test_task)
        # for i in 0...TM::Project.projects.length
        #   if TM::Project.projects[i].name == project_task_complete
        #     TM::Project.projects[i].mark_complete(task_id_complete)
        #   end
        #   TM::Project.projects[i].mark_complete(task_id_complete)
        #   puts TM::Project.projects[i].completed_tasks().each {|x| puts x.description}
        # end
        @choice = gets.chomp.downcase
        menu(@choice)
      else
        puts "Rock on King Kong"
      end
  end
end

