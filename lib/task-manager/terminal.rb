require 'pry-debugger'

class TM::TerminalClient

  attr_accessor :command

  def initialize
    @command = command
    puts "Welcome to Project Manager Pro. What can I do for you today?\n\n"
    self.command_list
  end

  def command_list
    puts "Available Commands:"
    puts "\thelp - Show these commands again"
    puts "\tlist - List all projects"
    puts "\tcreate p - Create a new project"
    puts "\tcreate t - Create a new task for a project"
    puts "\tshow - Show remaining tasks for a project"
    puts "\thistory - Show completed tasks for a project"
    puts "\tprojects employees - Show the employees in a project"
    puts "\tcreate e - Add a new employee"
    puts "\temployees - Lists all employees"
    puts "\tadd project - Assign an employee to a project"
    puts "\tadd task - Assign an employee to a task"
    puts "\temployees projects - Show the projects for an employee"
    puts "\tmark task - Mark a task as complete"
    puts "\temployees tasks - Show remaining tasks for an employee"
    puts "\temployees complete - Show completed tasks for an employee"
    puts "\ttask employees - Show employees for a task"
    puts "\texit - Exits the program"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def call_methods(command)
    self.list if @command == 'list'
    self.create_project if @command == 'create p'
    self.create_task if @command == 'create t'
    self.show if @command == 'show'
    self.history if @command == 'history'
    self.projects_employees if @command == 'projects employees'
    self.create_employee if @command == 'create e'
    self.list_employees if @command == 'employees'
    self.add_emp_to_proj if @command == 'add project'
    self.add_emp_to_task if @command == 'add task'
    self.employees_projects if @command == 'employees projects'
    self.mark_task if @command == 'mark task'
    self.emp_remaining_tasks if @command == 'employees tasks'
    self.emp_comp_tasks if @command == 'employees complete'
    self.task_employees if @command == 'task employees'
    self.command_list if  @command == 'help'
    if @command == 'exit'
    else
      puts "That is not a command."
      @command = gets.chomp
      self.call_methods(@command)
    end
  end

  def list
    puts "ID\tProject Name"
    data = TM::DB.db.list_projects
    data.each do |x|
      puts "#{x[:pid]}\t#{x[:name]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def create_project
    puts "Please enter a project name:"
    name = gets.chomp
    project = TM::DB.db.create_project(name: name)
    puts "You created a new project, \"#{project.name}\"! It's ID is: #{project.pid}"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def create_task
    puts "Please enter the id of the project you want the task to be in."
    projid = gets.chomp
    puts "Please enter a description for your task."
    description = gets.chomp
    puts "Please enter a priority number for your task (one being the highest priority)."
    priority = gets.chomp
    puts "Please enter the date you want to complete this in the form \'Year Month Day\'."
    duedate = gets.chomp
    task = TM::DB.db.create_task(pid: projid.to_i, desc: description, pnum: priority.to_i, duedate: duedate)
    puts "You created a new task \"#{task.desc}!\""
    @command = gets.chomp
    self.call_methods(@command)
  end

  def show
    puts "Please enter a project ID."
    projectid = gets.chomp
    tasks = TM::DB.db.incomplete_tasks(projectid.to_i)
    puts "ID\tProject Name"
    project = TM::DB.db.get_project(projectid.to_i)
    puts "#{project.pid}\t#{project.name}"
    puts "Priority\tID Description\tDue Date\tOver Due?"
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    tasks.each do |y|
      overdue = 'No'
      overdue = 'Yes' if y[:duedate] < today
      puts "#{y[:pnum]}\t\t#{y[:tid]}  #{y[:desc]}\t#{y[:duedate]}\t#{overdue}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def history
    puts "Please enter a project ID."
    projectid = gets.chomp
    tasks = TM::DB.db.complete_tasks(projectid.to_i)
    puts "ID\tProject Name"
    project = TM::DB.db.get_project(projectid.to_i)
    puts "#{project.pid}\t#{project.name}"
    puts "Priority\tID Description\tDue Date"
    tasks.each do |y|
      puts "#{y[:pnum]}\t\t#{y[:tid]}  #{y[:desc]}\t#{y[:duedate]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def projects_employees
    puts "Please enter the project\'s id."
    pid = gets.chomp
    puts "ID\tProject Name"
    puts "#{TM::DB.db.projects[pid.to_i][:pid]}\t#{TM::DB.db.projects[pid.to_i][:name]}"
    data = TM::DB.db.get_emp_by_proj(pid.to_i)
    puts "ID\tEmployee Name"
    data.each do |x|
      puts "#{x[:eid]}\t#{x[:name]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def create_employee
    puts "Please enter the employees name."
    name = gets.chomp
    emp = TM::DB.db.create_employee(name: name)
    puts "Your new employee is #{emp.name} with the id: #{emp.eid}"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def list_employees
    puts "ID\tEmployee Name"
    data = TM::DB.db.list_employees
    data.each do |x|
      puts "#{x[:eid]}\t#{x[:name]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def add_emp_to_proj
    puts "Please enter the project id."
    pid = gets.chomp
    puts "Please enter the employee id."
    eid = gets.chomp
    data = TM::DB.db.create_proj_emp(pid.to_i,eid.to_i)
    puts "#{data[:name]} has been added to the project #{data[:project]}."
    @command = gets.chomp
    self.call_methods(@command)
  end

  def add_emp_to_task
    puts "Please enter the task id."
    tid = gets.chomp
    puts "Please enter the employee id."
    eid = gets.chomp
    data = TM::DB.db.create_emp_task(tid.to_i,eid.to_i)
    puts "#{data[:name]} has been added to the task #{data[:task]}."
    @command = gets.chomp
    self.call_methods(@command)
  end

  def mark_task
    puts "Please enter the task ID."
    taskid = gets.chomp
    TM::DB.db.update_task(taskid.to_i, complete: true)
    task = TM::DB.db.tasks[taskid.to_i]
    puts "Task with id #{task[:tid]} and description \"#{task[:desc]}\" has been marked complete!"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def employees_projects
    puts "Please enter the employee\'s id."
    eid = gets.chomp
    puts "ID\tEmployee Name"
    puts "#{TM::DB.db.employees[eid][:eid]}\t#{TM::DB.db.employees[eid][:name]}"
    puts "ID\tProject Name"
    data = TM::DB.db.get_proj_by_emp(eid.to_i)
    data.each do |x|
      puts "#{x[:pid]}\t#{x[:name]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def emp_remaining_tasks
    puts "Please enter the employee\'s id."
    eid = gets.chomp
    puts "ID\tEmployee Name"
    puts "#{TM::DB.db.employees[eid][:eid]}\t#{TM::DB.db.employees[eid][:name]}"
    puts "Priority\tID Description\tDue Date\tOver Due?"
    data = TM::DB.db.get_inctask_by_emp(eid.to_i)
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    data.each do |x|
      overdue = 'No'
      overdue = 'Yes' if data[:duedate] < today
      puts "#{data[:pnum]}\t\t#{data[:tid]}  #{data[:desc]}\t#{data[:duedate]}\t#{overdue}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def emp_comp_tasks
    puts "Please enter the employee\'s id."
    eid = gets.chomp
    puts "ID\tEmployee Name"
    puts "#{TM::DB.db.employees[eid][:eid]}\t#{TM::DB.db.employees[eid][:name]}"
    puts "Priority\tID Description\tDate Created"
    data = TM::DB.db.get_comptask_by_emp(eid.to_i)
    data.each do |x|
      puts "#{data[:pnum]}\t\t#{data[:tid]}  #{data[:desc]}\t#{data[:date]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def task_employees
    puts "Please enter the task id."
    tid = gets.chomp
    puts "Priority\tID Description\tComplete?\tDue Date"
    complete = false
    complete = true if TM::DB.db.tasks[tid][:complete]
    puts "#{TM::DB.db.tasks[tid][:pnum]}\t\t#{TM::DB.db.tasks[tid][:tid]}  #{TM::DB.db.tasks[tid][:desc]}\t#{complete}\t#{TM::DB.db.tasks[tid][:duedate]}"
    data = TM::DB.db.get_comptask_by_emp(tid.to_i)
    puts "ID\tEmployee Name"
    data.each do |x|
      puts "#{data[:eid]}\t#{data[:name]}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

end
