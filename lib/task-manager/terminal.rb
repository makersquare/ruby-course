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
    self.command_list if  @command == 'help'
    if @command == 'exit'
    else
      puts "That is not a command."
      @command = gets.chomp
      self.call_methods(@command)
    end
  end

  def list
    TM::DB.db.list_projects
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
    TM::DB.db.remaining_tasks(projectid)
    @command = gets.chomp
    self.call_methods(@command)
  end

  def history
    puts "Please enter a project ID."
    projectid = gets.chomp
    TM::DB.db.project_history(projectid)
    @command = gets.chomp
    self.call_methods(@command)
  end

  def projects_employees
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
    TM::DB.db.list_employees
    @command = gets.chomp
    self.call_methods(@command)
  end

  def add_emp_to_proj
    puts "Please enter the project id."
    pid = gets.chomp
    puts "Please enter the employee id."
    eid = gets.chomp
    TM::DB.db.give_emp_proj(pid.to_i,eid.to_i)
    @command = gets.chomp
    self.call_methods(@command)
  end

  def add_emp_to_task
  end

  def mark_task
    puts "Please enter the task ID."
    taskid = gets.chomp
    TM::DB.db.update_task(taskid.to_i, complete: true)
    task = TM::DB.db.tasks[taskid.to_i]
    puts "Task with id #{task[:id]} and description \"#{task[:desc]}\" has been marked complete!"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def employees_projects
  end

  def emp_remaining_tasks
  end

  def emp_comp_tasks
  end

end
