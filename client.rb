require_relative 'lib/task-manager.rb'

class TM::ProjectManager
  def self.start
    tracker = TM::ProjectTracker.new
    @@exit = false
    while @@exit == false
    puts "What would you like to do?"
    puts "-- DOING THINGS"
    puts "-- Type 'create NAME' - Create a new project with name=NAME"
    puts "-- Type 'add PID DESC Priority' - Add a new task to project with id=PID"
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
          #{}"documentation"  #MAN command#
   string = gets.chomp
    choice = string.downcase.split
      case choice[0]
        #DOING THINGS#
        when 'create'
          project = tracker.create_new_project(choice[1])
          puts "#{project.name} project created"
        when 'add'
          if tracker.projects == []
              puts "Dude, create a project to house your tasks first!"
          else
            task = tracker.add_task(choice[1], choice[2], choice[3])
            puts "#{task.description} task created"
          end
        when 'emp'
            employee = tracker.add_new_employee(choice[2])
            puts "Employee #{employee.name} has been created"
        when 'delegate'
            employee = tracker.assign_to_project(choice[2], choice[1])
            if employee == nil
              puts "Yo bro, check if that employee and project exist.  If they do, recheck their ids."
            else
              project = tracker.get_project(choice[2])
              puts "Employee #{employee.name} has been assigned to the #{project.name} project"
            end
        when 'task'
            task = tracker.assign_task(choice[2], choice[3])
            if task == nil
              puts "Error has occurred.  Check the ids of task and employee.  Make sure task is not already assigned"
            else
              puts "Employee #{task.employee.name} has been assigned to #{task.description} task"
            end
        when 'mark'
            task = tracker.complete_task(choice[1])
            if task == nil
              puts "Dude, create projects and tasks first..."
            else
              puts "#{task.description} now has a status of #{task.status}"
            end
        #ACCESSING THINGS#
        when 'list'
          projects = tracker.projects
          if projects == []
            puts "You got no projects sucker"
          else
            puts "List of Projects"
            puts "ID: NAME"
            projects.each do |x|
            puts "#{x.id}: #{x.name}"
            end
          end
         when 'emplist'
            employees = tracker.employees
            if employees == []
              puts "You don't have any employees...Try craigslist!"
            else
              puts "List of employees"
              puts "Employee ID: Employee Name"
               employees.each do |x|
               puts "#{x.id}: #{x.name}"
               end
            end
         when 'employees'
            project = tracker.get_project(choice[1])
            if project == nil
              puts "Dude, create that project first."
            else
            puts "#{project.name} project's employees"
            puts "Employee ID: Employee Name"
            project.employees.each do |x|
            puts "#{x.id}: #{x.name}"
            end
          end
        when 'show'
            projects = tracker.projects_of_employee(choice[1])
            employee = tracker.employees.find {|x| x.id == choice[1].to_i}
            if projects == nil
              puts "Dude, either that employee does not exist or he is slacking with no projects"
            else
              puts "Employee {employee.name}'s projects"
              puts "Project ID: Project Name"
              projects.each do |x|
                puts "#{x.id}: #{x.name}"
              end
            end
        when 'see'
          project = tracker.show_tasks(choice[1])
          if project == nil
          puts "Dude, create projects and tasks first!"
          else
            puts "#{project.name} project's incomplete tasks"
            puts "Task ID: Priority, Description"
              project.incomplete_tasks.each do |x|
              puts "#{x.id}: #{x.priority_number}, #{x.description}"
              end
          end

         when 'history'
            project = tracker.show_tasks(choice[1])
          if project == nil
          puts "Dude, create projects and tasks first!"
          else
            puts "#{project.name} project's completed tasks"
            puts "Task ID: Priority, Description"
              project.completed_tasks.each do |x|
              puts "#{x.id}: #{x.priority_number}, #{x.description}"
              end
          end
        when 'remaining'
            tasks = tracker.remaining_employee_tasks(choice[1])
            puts "Remaining Tasks of employee with id #{choice[1]}"
            puts "Task id: Description, Priority"
              tasks.each do |x|
                puts "#{x.id}: #{x.description}, #{x.priority_number}"
              end
        when 'completed'
            tasks = tracker.completed_employee_tasks(choice[1])
              puts "Completed Tasks of employee with id #{choice[1]}"
              puts "Task id: Description, Priority"
              tasks.each do |x|
                puts "#{x.id}: #{x.description}, #{x.priority_number}"
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

TM::ProjectManager.start
