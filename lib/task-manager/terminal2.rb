require 'pry'

class TM::TerminalClient

  def initialize
    @db = TM.db
  end

  # Project Methods

  def list_projects
    puts "PID \t\ Name"
    TM.db.all_projects.each do |project|
        puts " #{project.id} \t\ #{project.name}"
    end
  end

  def create_project(project_data)
    if @db.create_project(name: project_data[:name])
      puts "Project Created"
      # binding.pry
    end
  end

  def assign_project_employee(employee_data)
    if @db.create_membership(eid: employee_data[:eid], pid: employee_data[:pid])
      puts "Employee assigned to project #{employee_data[:pid]}"
    end
  end

  def project_remaining_task(project_data)
    project = @db.get_project(project_data[:id])
    if project
      puts "Showing remaining task for #{project.name}"
      puts "TID \t\t\ Priority \t\ Description"
      project.incomplete_task.each do |task|
        # binding.pry
        puts" #{task.id} \t\t\ #{task.priority} \t\t\ #{task.description}"
      end
    else
      false
    end
  end

  def project_completed_task(project_data)
    project = @db.get_project(project_data[:id])
    if project
      puts "Showing completed task for #{project.name}"
      puts
      puts "TID \t\t\ Priority \t\ Description"
      project.completed_task.each do |task|
        # binding.pry
        puts" #{task.id} \t\t\ #{task.priority} \t\t\ #{task.description}"
      end
    else
      false
    end
  end

  def project_employees(project_data)
    project = @db.get_project(project_data[:id])
    if project
      puts "Showing employees for #{project.name}"
      puts
      puts "EID \t\ Name"
      project.show_employees.each do |employee|
        puts " #{employee.id} \t\ #{employee.name}"
      end
    else
      false
    end
  end


  # Task Methods

  def create_task(task_data)
    if @db.create_task(task_data)
      puts "Task Created"
      # binding.pry
    end
  end

  def assign_task_employee(data)
    task = @db.get_task(data[:tid])
    # binding.pry
    if task
      task.assign_employee(data)
      puts "#{TM.db.get_employee(data[:eid]).name} was assigned task #{data[:tid]}"
    else
      fasle
    end
  end

  def mark_task_complete(data)
    task = @db.get_task(data[:tid])
    task ? task.complete_task : false
    if task
      puts "Task: #{data[:tid]} has been completed"
    end
  end

  # Employee Methods

  def create_employee(employee_data)
    if @db.create_employee(name: employee_data[:name])
      puts "Employee Created"
      # binding.pry
    end
  end

  def show_all_employees
    employees = @db.all_employees
    if !employees.empty?
      puts "Showing all employees"
      puts
      puts "EID \t\ Name"
      employees.each do |employee|
        puts " #{employee.id} \t\ #{employee.name}"
      end
    else
      false
    end
  end

  def show_projects_employee(employee_data)
    employee = @db.get_employee(employee_data[:id])
    if employee
      puts "Showing all projects for #{employee.name}"
      puts
      puts "PID \t\ Project Name"
      employee.show_projects.each do |project|
        puts " #{project.id} \t\ #{project.name}"
      end
    else
      false
    end
  end

  def remaining_task_employee(employee_data)
    employee = @db.get_employee(employee_data[:id])
    if employee
      puts "Showing all remaining task for #{employee.name}"
      puts
      puts "PID \t\ TID \t\ Description"
      employee.show_task(completed: false).each do |task|
        puts " #{task.pid} \t\  #{task.id} \t\ #{task.description}"
      end
    else
      false
    end
  end

  def completed_task_employee(employee_data)
    employee = @db.get_employee(employee_data[:id])
    if employee
      puts "Showing all completed task for #{employee.name}"
      puts
      puts "PID \t\ TID \t\ Description"
      employee.show_task(completed: true).each do |task|
        puts " #{task.pid} \t\  #{task.id} \t\ #{task.description}"
      end
    else
      fasle
    end
  end

  def list_commands
    puts "Available Commands:"
    puts "\t\ help - Show thes commands again
    \t\ project list - List all projects
    \t\ project create NAME - Create a new project
    \t\ project show PID - Show remaining tsks for project PID
    \t\ project history PID - Show completed tasks for project PID
    \t\ project employees PID - Show employees participating in this project_data
    \t\ project recruit PID EID - Adds employee to participate in project PID
    \t\ task create PID PRIORITY DESC - Add a new task to project PID
    \t\ task assign TID EID - Assign task to employee
    \t\ task mark TID - Mark task TID as complete
    \t\ emp list - List all employees
    \t\ emp create NAME - Create a new employee
    \t\ emp show EID - Show employee EID and all participating projects
    \t\ emp details EID - Show all remaining tasks assigned to employee EID
    \t\ emp history EID - Show completed task for employee with EID
    \t\ exit - Exit program \n
    Please enter a command:"
  end

  def run
    list_commands
    @exit = false
    until @exit
      input = gets.chomp
      input = input.downcase.split(" ")

      case input[0]
      when "project"
        if input[1] = "list"
          list_projects
        end
      when "exit"
        @exit = true
      end
    end
  end

  def prompt_user

  end



  def test
    puts "Working"
  end

end

# def list_instructions
#   puts "Available Commands:"
#   puts
#   puts "  help - Show these commands again"
# end
