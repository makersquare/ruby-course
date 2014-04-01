require_relative 'lib/task-manager.rb'
require 'colorize'

class PManager
  def self.start
    puts "Welcome to Project Manager Pro®. ".colorize(:yellow)
    def self.main_menu
      puts "What would you like to do?"
    puts " project list - List all projects"
    puts " project create NAME - Create a new project"
    puts " project show PID - Show remaining tasks for project PID"
    puts " project history PID - Show completed tasks for project PID"
    puts " project employees PID - Show employees participating in this project"
    puts " project recruit PID EID - Adds employee EID to participate in project PID"

    puts " task create PID PRIORITY DESC - Add a new task to project PID"
    puts " task assign TID EID - Assign task to employee"
    puts " task mark TID - Mark task TID as complete"
    puts " emp list - List all employees"
    puts " emp create NAME - Create a new employee"
    puts " emp show EID - Show employee EID and all participating projects"
    puts " emp details EID - Show all remaining tasks assigned to employee EID,
                    along with the project name next to each task"
    puts " emp history EID - Show completed tasks for employee with id=EID"
    puts "--"
    puts "-- GENERAL"
    puts " 'help' to show these commands again"
    puts "-- Exit 'exit' to quit this program"
    end
    @@user_command = ""
    project_list = TM::ProjectList.new
    PManager.main_menu
    while (@@user_command != 'quit')
      print "What would you like to do?  ".colorize(:yellow)
      @@user_command = gets.chomp
      # if @@user_command == help
      #   PManager.main_menu
      # end
        object = @@user_command.split(' ')[0]
        action = @@user_command.split(' ')[1]
        description = @@user_command.split(' ').drop(2).join(' ')

        case object
            when 'project'
                case action
                    when 'create'
                        result = TM::CreateProjects.run(:project_name => description)
                                if result.success?
                                        project = result.project
                                        puts; puts "Project ID #{project.id} with name: #{project.name} was created"
                                        puts;
                                else
                                        puts; puts "Put in a mother fucking project name. Seriously. How am I supposed to know what you're talking about?".colorize(:red)
                                        puts;
                                end
                    when 'list'
                        puts "Project ID   Project Name"
                        result = TM.DB.projects
                        result.values.each { |project| puts "      #{project.id}         #{project.name}" }

                    when 'show'
                        result = TM::ShowRemainingTasks.run(:pid => pid)

                        if result.success?
                            tasks = result.tasks
                                puts; tasks.each { |task| put "Description: #{task.description}, Task ID: #{task.id} Priority: #{task.priority}".colorize(:green)}
                        elsif result.error == :provide_a_project_id
                                puts; puts "Put in a project id. Come on.".colorize(:red)
                                puts;
                        else
                                puts; puts "That project doesn't exist. Get yo shit together.".colorize(:red)
                                puts;
                        end

                    when 'history'
                        result = TM::ShowCompletedTasks.run(:pid => pid)

                        if result.success?
                            tasks = result.tasks
                                puts; tasks.each { |task| put "Description: #{task.description}, Task ID: #{task.id} Priority: #{task.priority}".colorize(:green)}
                        elsif result.error == :provide_a_project_id
                                puts; puts "Put in a project id. Come on.".colorize(:red)
                                puts;
                        elsif result.error == :project_doesnt_exist
                                puts; puts "That project doesn't exist. Get yo shit together.".colorize(:red)
                                puts;
                        end


                    when 'employees'
                        result = TM::ShowEmployees.run(:pid => pid)

                        if result.success?
                            employees = result.employees
                            print employees
                                puts; "em".colorize(:green)
                        elsif result.error == :provide_a_project_id
                                puts; puts "Put in a project id. Come on.".colorize(:red)
                                puts;
                        elsif result.error == :project_doesnt_exist
                                puts; puts "That project doesn't exist. Get yo shit together.".colorize(:red)
                                puts;
                        end

                    when 'recruit'
                        inputs = description.split(' ')
                        pid = inputs[0].to_i
                        eid = inputs[1].to_i
                        result = TM::RecruitEmployees.run(:eid => eid, :pid => pid)

                        if result.success?
                            employee = result.employee
                            project = result.project
                                puts; puts "Employee, #{employee.name} was added to Project #{project.name} ".colorize(:green)
                        elsif result.error == :provide_a_project_id
                                puts; puts "Put in a project id. Come on.".colorize(:red)
                                puts;
                        elsif result.error == :project_doesnt_exist
                                puts; puts "That project doesn't exist. Get yo shit together.".colorize(:red)
                                puts;
                        end

                end
            when 'task'
                case action
                    when 'create'
                        inputs = description.split(' ')
                        pid = inputs[0].to_i
                        priority = inputs[1].to_i
                        description = inputs.drop(2).join(' ')
                        result = TM::CreateTask.run(:pid => pid, :priority => priority, :description=> description)
                                if result.success?
                                        task = result.task
                                        puts; puts "Task #{task.description} with ID #{task.id} was created"
                                        puts;
                                else
                                        puts; puts "Put in a mother fucking project name. Seriously. How am I supposed to know what you're talking about?".colorize(:red)
                                        puts;
                                end
                    when 'assign'
                        inputs = description.split(' ')
                        tid = inputs[0].to_i
                        eid = inputs[1].to_i

                        result = TM::AddTaskToEmployee.run(:tid => tid, :eid => eid)

                        if result.success?
                                tasks = result.tasks
                                puts; puts "Task with id #{tasks.id} was added to employee #{eid}".colorize(:green)
                        elsif result.error == :provide_a_project_id
                                puts; puts "Put in a project id. Come on.".colorize(:red)
                                puts;
                        elsif result.error == :provide_a_task_description
                                puts; puts "You need to reoncsider your life. Give me a task description, already.".colorize(:red)
                                puts;
                        else
                                puts; puts "That project doesn't exist. Get yo shit together.".colorize(:red)
                                puts;
                        end

                    when 'mark'
                        inputs = description.split(' ')
                        tid = inputs[0].to_i
                        result = TM::MarkComplete.run(:tid => tid)
                                if result.success?
                                        task = result.tasks
                                        puts; puts "Task #{task.description} was marked complete"
                                        puts;
                                else
                                        puts; puts "You didn't tell me which ID to mark complete. You are worthless".colorize(:red)
                                        puts;
                                end
                end
            when 'emp'
                case action
                    when 'list'
                        puts "Employee ID   Employee Name"
                        result = TM.DB.employees
                        result.values.each { |emp| puts "      #{emp.id}         #{emp.name}" }
                    when 'create'
                        result = TM::CreateEmployee.run(:employee => description)
                                if result.success?
                                        employee = result.employee
                                        puts; puts "Employee, #{employee.name} with ID #{employee.id} was created"
                                        puts;
                                else
                                        puts; puts "Put in a name, homie. Who is that supposed to be?".colorize(:red)
                                        puts;
                                end

                    when 'show'
                        result = TM::ShowProjects.run(:eid => description.to_i)
                                if result.success?
                                        projects = result.projects
                                        puts projects
                                        puts;
                                else
                                        puts; puts "Put in an ID, homie.".colorize(:red)
                                        puts;
                                end

                    when 'details'
                        result = TM::EmployeeDetails.run(:eid => description.to_i)
                                if result.success?
                                        tasks = result.remaining_tasks
                                        puts tasks.each { |task| put s"Remaining task #{task.description} with project id #{task.pid }"}
                                        puts;
                                else
                                        puts; puts "Put in an ID, homie.".colorize(:red)
                                        puts;
                                end

                    when 'history'
                        result = TM::ShowCompletedTasksEID.run(:eid => description.to_i)

                        if result.success?
                            tasks = result.tasks
                                puts; tasks.each { |task| puts "Description: #{task.description}, Task ID: #{task.id} Priority: #{task.priority}".colorize(:green)}
                                puts;
                        end
                end
        end
    end


  end
end
PManager.start
