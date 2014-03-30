require_relative 'lib/task-manager.rb'
module TM
class ProjectManager
  def self.start
   @database = TM.database
    @@exit = false
    while @@exit == false
    puts "What would you like to do?"
    puts "-- DOING THINGS"
    puts "-- Type 'create NAME' - Create a new project with name=NAME"
    puts "-- Type 'add PID Priority DESC' - Add a new task to project with id=PID"
    puts "-- Type 'emp create NAME' to create a new employee with name=employee name"
    puts "-- Type 'delegate EID PID' - Assign an employee to a project"
    puts "-- Type 'task assign TID EID' - Assign task TID to employee EID"
    puts "-- Type 'mark TID' to mark task with id=TID as complete"
    puts "--"
    puts "-- ACCESSING THINGS"
    puts "-- Type 'list' to list all the projects"
    puts "-- Type 'emplist' - List all employees"
    puts "-- Type 'employees PID' - Show employees participating in this project with PID=Project ID"
    puts "-- Type 'show EID projects' - Show employee EID and all participating projects"
    puts "-- Type 'see PID tasks' to show remaining tasks for project with id=PID"
    puts "-- Type 'history PID' to show completed tasks for project with id=PID"
    puts "-- Type 'remaining EID tasks' to show remaining tasks of employee with id=EID"
    puts "-- Type 'completed EID tasks' to show completed tasks of employee with id=EID"
    puts "--"
    puts "-- GENERAL"
    puts "-- Type 'help' to show these commands again"
    puts "-- Exit-- Type 'exit' to quit this program"
   string = gets.chomp
    choice = string.downcase.split
      case choice[0]
        #DOING THINGS#
        when 'create'
          result = TM::CreateProject.run(:name => choice[1..-1].join(' '))
            if result.success?
              project= result.project
              puts "You project with name #{project.name} and id #{project.id} has been created!"
            else
              if result.error == :project_name_not_given
              puts "Dude, you gotta give me a name to create this project!"
              end
            end
        when 'add'
          result = TM::AddTaskToProject.run(:project_id => choice[1], :priority => choice[2], :description => choice[3..-1].join(' '))
            if result.success?
              project= result.project
              task = result.task
              puts "You successfully added #{task.description} to the #{project.name} project!"
            else
              if result.error == :project_not_found
                puts "Dude, that project does not exist!"
              end
            end
        when 'emp'
          result = TM::CreateEmployee.run(:name => choice[2..-1].join(' '))
            if result.success?
              employee = result.employee
              puts "You successfully added #{employee.name} with the id #{employee.id}!"
            else
              if result.error == :employee_not_given_name
                puts "Dude, that employee cannot be created without a name!"
              end
            end
        when 'delegate'
          result = TM::DelegateEmployeeToProject.run(:employee_id => choice[1], :project_id => choice[2])
            if result.success?
              employee = result.employee
              project = result.project
              puts "You successfully added #{employee.name} to the #{project.name} project!"
            else
              if result.error == :employee_not_found
                puts "Dude, I can't find that employee!"
              elsif result.error == :project_not_found
                puts "Dude, I can't find that project!"
              end
            end
        when 'task'
          result = TM::AssignTaskToEmployee.run(:task_id => choice[2], :employee_id => choice[3])
            if result.success?
              employee = result.employee
              task = result.task
              puts "You successfully delegated #{task.description} to the employee #{employee.name}!"
            else
              if result.error == :employee_not_found
                puts "Dude, I can't find that employee!"
              elsif result.error == :task_not_found
                puts "Dude, I can't find that task!"
              elsif result.error == :task_already_assigned
                puts "Dude, that task is already assigned"
              elsif result.error == :employee_not_assigned_to_project
                puts "Dude, that employee has to be a part of the project team first"
              end
            end
        when 'mark'
          result = TM::MarkTaskAsComplete.run(:task_id => choice[1])
            if result.success?
              task = result.task
              puts "You successfully gave #{task.description} a status of #{task.status}!"
            else
              if result.error == :task_not_found
                puts "Dude, I can't find that task!"
              elsif result.error == :task_already_completed
                puts "Dude, that task is already completed"
              end
            end
        #ACCESSING THINGS#
        when 'list'
          result = TM::ListProjects.run
          if result.success?
            puts "Project ID: Project Name"
            result.projects.values.each do |x|
              puts "#{x.id}: #{x.name}"
              end
          else
            if result.error == :no_projects_found
              puts "Dude, how can i list projects when there are none"
            end
          end
         when 'emplist'
          result = TM::ListEmployees.run
            if result.success?
              puts "Employee ID: Employee Name"
                result.employees.values.each do |x|
                puts "#{x.id}: #{x.name}"
                end
            else
              if result.error == :no_employees_found
              puts "Dude, how can i list employees when there are none"
              end
            end
        when 'employees'
          result = TM::EmployeesInProject.run(:project_id => choice[1])
          if result.success?
              puts "Project: #{result.project.name}"
              puts "Employee ID: Employee Name"
                result.employees.each do |x|
                puts "#{x.id}: #{x.name}"
                end
          else
            if result.error == :project_not_found
              puts "Dude, how can i list employees when that project does not exist"
            elsif result.error == :no_employees_in_project
              puts "Dude, that project has no assigned employees"
            end
          end
        when 'show'
        result = TM::ProjectsOfEmployee.run(:employee_id => choice[1])
          if result.success?
              puts "Employee: #{result.employee.name}"
              puts "Project ID: Project Name"
                result.projects.each do |x|
                puts "#{x.id}: #{x.name}"
                end
          else
            if result.error == :employee_not_found
              puts "Dude, how can i list projects when that employee does not exist"
            elsif result.error == :no_projects_of_employee
              puts "Dude, that lazy employee has no assigned projects"
            end
          end
        when 'see'
          result = TM::RemainingOfProject.run(:project_id => choice[1])
          if result.success?
              puts "#{result.project.name} Remaining Tasks"
              puts "Task ID: Task Name"
                result.tasks.each do |x|
                puts "#{x.id}: #{x.description}"
                end
          else
            if result.error == :project_not_found
              puts "Dude, how can i list tasks when that project does not exist"
            elsif result.error == :no_remaining_tasks_found
              puts "Dude, that project has no remaining tasks"
            end
          end
        when 'history'
          result = TM::HistoryOfProject.run(:project_id => choice[1])
          if result.success?
              puts "#{result.project.name} Completed Tasks"
              puts "Task ID: Task Name"
                result.tasks.each do |x|
                puts "#{x.id}: #{x.description}"
                end
          else
            if result.error == :project_not_found
              puts "Dude, how can i list tasks when that project does not exist"
            elsif result.error == :no_completed_tasks_found
              puts "Dude, that project has no completed tasks"
            end
          end
        when 'remaining'
          result = TM::RemainingOfEmployee.run(:employee_id => choice[1])
          if result.success?
              puts "#{result.employee.name} Remaining Tasks"
              puts "Task ID: Task Name"
                result.tasks.each do |x|
                puts "#{x.id}: #{x.description}"
                end
          else
            if result.error == :employee_not_found
              puts "Dude, how can i list tasks when that employee does not exist"
            elsif result.error == :no_remaining_tasks_found
              puts "Dude, that employee has no remaining tasks"
            end
          end
        when 'completed'
          result = TM::HistoryOfEmployee.run(:employee_id => choice[1])
          if result.success?
              puts "#{result.employee.name} Completed Tasks"
              puts "Task ID: Task Name"
                result.tasks.each do |x|
                puts "#{x.id}: #{x.description}"
                end
          else
            if result.error == :employee_not_found
              puts "Dude, how can i list tasks when that employee does not exist"
            elsif result.error == :no_completed_tasks_found
              puts "Dude, that lazy employee has no completed tasks"
            end
          end
        #GENERAL#
        when 'help'
          puts "The system is pretty straightforward. Figure it out!"
        when 'exit'
          @@exit = true
        else
          puts "Dude, follow instructions!"
        end
      end
    end
end
end
TM::ProjectManager.start
