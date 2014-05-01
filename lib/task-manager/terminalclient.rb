class TMTerminal
  # create new instance of project_list class to store user data for the session

  puts "Welcome to Project Manager Pro®. What can I do for you today?\n"
  puts "Available commands:"

  puts "\thelp - Show these commands again"
  puts "\tlist - List all projects"
  puts "\tcreate NAME - Create a new project with name=NAME"
  puts "\tshow PID - Show remaining tasks for project with id=PID"
  puts "\thistory PID - Show completed tasks for project with id=PID"
  puts "\tadd PID PRIORITY DESC - Add a new task to project with id=PID"
  puts "\tmark TID - Mark task with id=TID as complete"
  puts "\texit with EXIT"
  print "Enter a command: "
  begin
    choice = gets.chomp()
    case choice
    when "help"
      puts "Available commands:"

      puts "\thelp - Show these commands again"
      puts "\tlist - List all projects"
      puts "\tcreate NAME - Create a new project with name=NAME"
      puts "\tshow PID - Show remaining tasks for project with id=PID"
      puts "\thistory PID - Show completed tasks for project with id=PID"
      puts "\tadd PID DESC PRIORITY - Add a new task to project with id=PID"
      puts "\tmark TID - Mark task with id=TID as complete"
      puts "\texit with exit"
      print "Enter a command: "
    when "list"
      puts "Project ID\tProject Name"
      TM::Project.list_projects.each do |project|
        puts"#{project.pid}\t\t#{project.name}"
      end
      print "Enter a command: "
    when /create ./
      choice = choice.split(" ",2)
      name = choice[1]

      new_project = TM::Project.new(name)
      puts "Project created."
      print "Enter a command: "
    when /show ./
      choice = choice.split(" ")
      pid = choice[1].to_i
      project = TM::Project.get_project(pid)

      puts "Priority\tID\tDescription"
      project.incomplete_tasks.each do |task|
        puts "#{task.priority}\t\t#{task.task_id}\t#{task.description}"
      end
      print "Enter a command: "
    when /history ./
      choice = choice.split(" ")
      pid = choice[1].to_i

      project = TM::Project.get_project(pid)
      puts "Completed Tasks"
      puts "Task ID\tTask Description"
      project.completed_tasks.each do |task|
        puts "#{task.task_id}\t\t#{task.description}"
      end
      print "Enter a command: "
    when /add ./
      choice = choice.split(" ",4)
      pid = choice[1].to_i
      priority = choice[2].to_i
      description = choice[3]

      TM::Task.new(pid,description,priority)
      puts "Task created"
      print "Enter a command: "
    when /mark ./
      choice = choice.split(" ")
      id = choice[1].to_i

      TM::Task.complete_task(id)
      puts "Task completed"
      print "Enter a command: "
    end
  end while choice != "exit" # This isn't necessary, exit will always exit the program

end
