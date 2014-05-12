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
    puts "\tmark task - Mark a task as complete"
    puts "\texit - exits the program"
    @command = gets.chomp
    self.call_methods(@command)
  end

  def call_methods(command)
    self.list if @command == 'list'
    self.create_project if @command == 'create p'
    self.create_task if @command == 'create t'
    self.show if @command == 'show'
    self.history if @command == 'history'
    self.mark_task if @command == 'mark task'
    self.command_list if  @command == 'help'
    if @command == 'exit'
    else
      puts "That is not a command."
      @command = gets.chomp
      self.call_methods(@command)
    end
  end

  def list
    projects = TM::DB.db.projects
    puts "ID\tProject Name\t% Done \t% Over Due"
    projects.each do|x,y|
      percentage = TM::DB.db.projects_tasks(x)
      puts "#{y[:pid]}\t#{y[:name]}\t#{percentage[:percent_done]}\t#{percentage[:percent_over]}"
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
    tasks = TM::Task.incomplete_tasks(projectid.to_i)
    projects = TM::Project.list_projects
    project = projects.select {|project| project.pid == projectid.to_i}
    project_name = project[0]
    project_name = project_name.name
    puts "Project Name\t% Done \t% Over Due"
    percentage = TM::Project.percentage_complete(projectid.to_i)
    puts "#{project_name}\t#{percentage}\n\n"
    puts " Priority\tID Description\tDue Date\tOver Due?"
    t = Time.now
    today = "#{t.year} #{t.month} #{t.day}"
    tasks.each do |task|
      overdue = 'No'
      overdue = 'Yes' if task.duedate < today
      puts "\t#{task.pnum}\t#{task.tid}  #{task.description}\t#{task.duedate}\t#{overdue}"
    end
    @command = gets.chomp
    self.call_methods(@command)
  end

  def history
    puts "Please enter a project ID."
    projectid = gets.chomp
    tasks = TM::Task.completed_tasks(projectid.to_i)
    projects = TM::Project.list_projects
    project = projects.select {|project| project.pid == projectid.to_i}
    project_name = project[0]
    project_name = project_name.name
    puts "Project Name\t% Done \t% Over Due"
    percentage = TM::Project.percentage_complete(projectid.to_i)
    puts "\"#{project_name}\t#{percentage}\"\n\n"
    puts " Priority\tID Description\tDue Date"
    tasks.each {|task|  puts "\t#{task.pnum}\t#{task.tid}  #{task.description}\t#{task.duedate}"}
    @command = gets.chomp
    self.call_methods(@command)
  end

  def mark_task
    puts "Please enter the task ID."
    taskid = gets.chomp
    task = TM::Task.mark_complete(taskid.to_i)
    @command = gets.chomp
    self.call_methods(@command)
  end

end
