require_relative 'lib/task-manager.rb'
require 'colorize'

class   PM
def self.first_menu
puts  "Available Commands:"
puts  "help - Show these commands again"
puts  "project list - List all projects"
puts  "project create NAME - Create a new project"
puts  "project show PID - Show remaining tasks for project PID"
puts  "project history PID - Show completed tasks for project PID"
puts  "project employees PID - Show employees participating in this project"
puts  "project recruit PID EID - Adds employee EID to participate in project PID"
puts  "task create PID PRIORITY DESC - Add a new task to project PID"
puts  "task assign TID EID - Assign task TID to employee EID"
puts  "task mark TID - Mark task TID as complete"
puts  "emp list - List all employees"
puts  "emp create NAME - Create a new employee"
puts  "emp show EID - Show employee EID and all participating projects"
puts  "emp details EID - Show all remaining tasks assigned to employee EID, along with the project name next to each task"
puts  "emp history EID - Show completed tasks for employee with id=EID"
end


  def self.start
    @@user_command = ''
    # @@db = TM.
    puts
    puts "Welcome to Project Manager Pro®. What can I do for you today?".colorize(:color => :magenta, :background => :yellow, :mode => :underline)
    PM.first_menu

    while (@@user_command != 'quit')
      print "What would you like to do? ".colorize(:green)
      @@user_command = gets.chomp

      object = @@user_command.split(' ')[0]
      action =  @@user_command.split(' ')[1]
      description = @@user_command.split(' ').drop(2).join(' ')


      case object
        when 'project'
          case action
            when 'create'
              PM.create_project(description)
            when 'list'
              PM.list_projects
            when 'show'
              PM.show_tasks(description)
            when 'history'
              PM.history(description)
            when 'employees'
              PM.employees(description)
            when 'recruit'
              PM.recruit(description)
          end
        when 'task'
          case action
            when 'create'
              PM.create_task(description)
            when 'assign'
              PM.assign(description)
            when 'mark'
              PM.mark(description)
          end
        when 'emp'
          case action
            when 'list'
              PM.list_employees(nil)
            when 'create'
              PM.create_employee(description)
            when 'show'
              PM.show_employee_projects(description)
            when 'details'
              PM.show_employee_details(description)
            when 'history'
              PM.employee_history(description)
          end
      end
    end
  end
  def self.create_project(description)
    result = TM::CreateProject.run(project_name: description)

    if (result.success?)
      project = result.project
      puts
      puts "#{project.project_name} successfully created!".colorize(:yellow)
      puts
    else
      if result.error == :please_provide_a_project_name
        puts 'please provide a project name'
        puts
      end
    end
  end
  def self.list_projects
    result = TM::ListProjects.run(nil)
    puts "project id   project name".colorize(mode: :underline)
    result.projects.each do |project|
      puts "#{project.id}            #{project.project_name}"
    end
  end

  def self.show_tasks(description)
    pid = description.to_i
    result = TM::ShowRemainingTasks.run(pid: pid)
    if (result.success?)
    puts "task id   task description".colorize(mode: :underline)
      remaining_tasks = result.remaining_tasks
      remaining_tasks.each do |task|
        puts " #{task.id}         #{task.description}"
      end
    else
      if (result.error == :project_doesnt_exist)
        puts "a project with that id doesn't exist!".colorize(:red)
      elsif (result.error == :enter_a_project_id)
        puts "please enter a project id"
      end
    end
  end

  def self.history(description)
    pid = description.to_i
    result = TM::ShowCompletedTasks.run(pid: pid)
    if (result.success?)
      completed_tasks = result.completed_tasks
      completed_tasks.each do |task|
        puts "#{task.id} #{task.description}"
      end
    else
      if (result.error == :project_doesnt_exist)
        puts "project doesn't exist!"
      end
    end
  end

  def self.employees(description)
    pid = description.to_i
    result = TM::GetProjectEmployees.run(pid: pid)
    if (result.success?)
      employees = result.project_employees

      employees.each do |employee|
        puts "#{employee.name}"
      end
    else
      if (result.error == :project_does_not_exist)
        puts "project doesn't exist!"
      elsif (result.error == :no_employees_assigned_to_this_project)
        puts 'no employees currently assigned to this project!'
      end
    end
  end

  def self.recruit(description)
    inputs = description.split(' ')
    pid = inputs[0].to_i
    eid = inputs[1].to_i

    result = TM::AssignEmployeeToProject.run(pid: pid, eid: eid)

    if (result.success?)
      project = result.project
      employee = result.employee
      puts "#{employee.name} has been assigned to #{project.project_name}!"
    else
      if (result.error == :project_does_not_exist)
        puts "a project with that id doesn't exist!".colorize(:red)
      elsif (result.error == :employee_does_not_exist)
        puts "an employee with that id doesn't exist!".colorize(:red)
      end
    end

  end

  def self.create_task(description)

    inputs = description.split(' ')
    pid = inputs[0].to_i
    priority = inputs[1].to_i
    task_description = inputs.drop(2).join(' ')

    result = TM::AddTaskToProject.run(description: task_description, priority: priority, pid: pid)

    if (result.success?)
      added_task = result.added_task
      project = result.project
      puts
      puts "#{added_task.description} added to #{project.project_name}!".colorize(:yellow)
      puts
    else
      if (result.error == :project_does_not_exist)
        puts "a project with that id doesn't exist!".colorize(:red)
      end
    end

  end

  def self.assign(description)
    inputs = description.split(' ')
    tid = inputs[0].to_i
    eid = inputs[1].to_i

    result = TM::AssignTaskToEmployee.run(tid: tid, eid: eid)

    if (result.success?)
      assigned_task = result.assigned_task
      employee = result.employee

      puts "#{assigned_task.description} assigned to #{employee.name}"
    else
      if (result.error == :task_does_not_exist)
        puts "a task with that id does not exist!".colorize(:red)
      elsif (result.error == :employee_does_not_exist)
        puts "a employee with that id does not exist!".colorize(:red)
      end
    end


  end

  def self.mark(description)
    tid = description.to_i
    result = TM::MarkTaskComplete.run(tid: tid)
    if (result.success?)
      completed_task = result.completed_task
      puts "#{completed_task.description} completed!"
    end
  end

  def self.list_employees(description=nil)
    result = TM::ListEmployees.run(nil)
    if (result.success?)
      employees = result.employees

      employees.each do |employee|
        puts "#{employee.id} #{employee.name}"
      end
    end
  end

  def self.create_employee(description)
    name = description
    result = TM::CreateEmployee.run(name: name)
    if (result.success?)
      employee = result.employee
      puts "#{employee.name} created!"
    else
      if (result.error == :no_name_provided)
        puts "no name provided!"

      end
    end
  end

  def self.show_employee_projects(description)
    eid = description.to_i
    result = TM::ShowEmployeeProjects.run(eid: eid)
    if (result.success?)
     employee_projects = result.employee_projects
     employee = result.employee
     employee_projects.each do |project|
      puts "#{employee.id} #{project.project_name}"
     end
    else
      if (result.error == :employee_does_not_exist)
        puts "an employee with that id does not exist!".colorize(:red)
      end
    end

  end

  def self.show_employee_details(description)
    eid = description.to_i

    result = TM::ShowRemainingEmployeeTasks.run(eid: eid)

    if (result.success?)
      remaining_tasks = result.remaining_tasks
      associated_projects = result.associated_projects

      remaining_tasks.each do |task|
        puts "#{task.id} #{task.description} | #{associated_projects.find{|p| p.id == task.pid}.project_name} "
      end
    else
      if (result.error == :employee_does_not_exist)
        puts "an employee with that id does not exist!".colorize(:red)
      end
    end
  end

  def self.employee_history(description)
    eid = description.to_i
    result = TM::ShowCompletedEmployeeTasks.run(eid: eid)

    if (result.success?)
      completed_tasks = result.completed_tasks

      completed_tasks.each do |task|
        puts "#{task.eid} #{task.description}"
      end
    else
      if (result.error == :employee_does_not_exist)
        puts "an employee with that id does not exist!".colorize(:red)
      end
    end

  end

end
PM.start
