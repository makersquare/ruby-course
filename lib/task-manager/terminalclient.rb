class TM::TerminalClient
  def initialize
    puts "Welcome to Project Manager Pro®. What can I do for you today?\n"
    puts "Available commands:"

    puts "\thelp - Show these commands again"
    puts "\tlist - List all projects"
    puts "\tcreate NAME - Create a new project with name=NAME"
    puts "\tshow PID - Show remaining tasks for project with id=PID"
    puts "\thistory PID - Show completed tasks for project with id=PID"
    puts "\tadd PID PRIORITY DUE_DATE DESC - Add a new task to project with id=PID"
    puts "\tmark TID - Mark task with id=TID as complete"
    puts "\texit with EXIT"
    self.run_program
  end

  def run_program
    begin
      print "Enter a command: "
      choice = gets.chomp()
      case choice
      when "help" then help
      when "list" then list
      when /create ./ then create_project(choice)
      when /show ./ then show_project(choice)
      when /history ./ then project_history(choice)
      when /add ./ then add_task(choice)
      when /mark ./ then complete_task(choice)
      end
    end while choice != "exit" # This isn't necessary, exit will always exit the program
  end

  # Choice methods
  def help
    puts "Available commands:"

    puts "\thelp - Show these commands again"
    puts "\tlist - List all projects"
    puts "\tcreate NAME - Create a new project with name=NAME"
    puts "\tshow PID - Show remaining tasks for project with id=PID"
    puts "\thistory PID - Show completed tasks for project with id=PID"
    puts "\tadd PID PRIORITY DUE_DATE DESC - Add a new task to project with id=PID"
    puts "\tmark TID - Mark task with id=TID as complete"
    puts "\texit with exit"
  end

  def list
    puts "Project ID\tProject Name"
    TM::Project.list_projects.each do |project|
      puts"#{project.pid}\t\t#{project.name}"
    end
  end

  def create_project(choice)
    choice = choice.split(" ",2)
    name = choice[1]

    new_project = TM::Project.new(name)
    puts "Project created."
  end
  def show_project(choice)
    choice = choice.split(" ")
    pid = choice[1].to_i
    project = TM::Project.get_project(pid)

    puts "Priority\tID\tDue Date\tDescription\tTags"
    project.incomplete_tasks.each do |task|
      puts "#{task.priority}\t\t#{task.task_id}\t#{task.due_date}\t#{task.description}\t\t#{task.tags}"
    end
  end

  def project_history(choice)
    choice = choice.split(" ")
    pid = choice[1].to_i

    project = TM::Project.get_project(pid)
    puts "Completed Tasks"
    puts "Task ID\tTask Description"
    project.completed_tasks.each do |task|
      puts "#{task.task_id}\t\t#{task.description}"
    end
  end

  def add_task(choice)
    choice = choice.split(" ",5)
    pid = choice[1].to_i
    priority = choice[2].to_i
    due_date = choice[3]
    description = choice[4]
    print "Add tags to this task (optional): "
    tags = gets.chomp()

    TM::Task.new(pid, description, priority, due_date, tags: tags)
    puts "Task created"
  end

  def complete_task(choice)
    choice = choice.split(" ")
    id = choice[1].to_i

    TM::Task.complete_task(id)
    puts "Task completed"
  end
end
