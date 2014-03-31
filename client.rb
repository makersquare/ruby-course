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
                                        puts; puts "Project #{project.name} with ID #{project.id} was created"
                                        puts;
                                else
                                        puts; puts "Put in a mother fucking project name. Seriously. How am I supposed to know what you're talking about?".colorize(:red)
                                        puts;
                                end
                    when 'list'

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
                        pid = inputs[0].to_i
                        priority = inputs[1].to_i
                        description = inputs.drop(2).join(' ')
                        result = TM::AddTaskToProject.run(:description => description, :pid => pid, :priority => priority)

                        if result.success?
                                tasks = result.tasks
                                puts; puts "Task with id #{tasks.id} was added to project id #{pid}".colorize(:green)
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

                end
            when 'emp'
                case action
                    when 'list'

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

                    when 'details'

                    when 'history'
                end
        end
    end


  end
end
PManager.start
