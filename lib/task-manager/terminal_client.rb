require_relative '../task-manager.rb'

class TM::TerminalClient
  def start
    puts "Welcome to Project Manager Pro. What can I do for you today?\n\n"
    help
  end

  def user_choice(input)
    case input
    when "help"
      help
    when "list"
      list
    when "create"
      puts "\nEnter project name:"
      project_name = gets.chomp
      create(project_name)
    when "show"
      puts "\nEnter project ID:"
      id = gets.chomp.to_f
      show(id)
    when "history"
      puts "\nEnter project ID:"
      id = gets.chomp.to_f
      history(id)
    when "add"
      puts "\nEnter project ID:"
      id = gets.chomp.to_f
      puts "\nWhat is the task?"
      description = gets.chomp
      puts "\nEnter task priority:\n1 - Low Priority\n2- Medium Priority\n3-High Priority"
      priority_number = gets.chomp.to_f
      add(description, priority_number, id)
    when "mark"
      puts "\nEnter the Project ID"
      project_id = gets.chomp.to_f
      puts "\nEnter the Task ID"
      task_id = gets.chomp.to_f
      mark(project_id, task_id)
    when "exit"
      exit
    else
      puts "\nInvalid choice. Enter 'help' to show available commands."
      user_choice(gets.chomp.downcase)
    end
  end

  def help
    puts "\nAvailable Commands:\n"
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create - Create a new project"
    puts "  show - Show remaining tasks for project"
    puts "  history - Show completed tasks for project with id = PID"
    puts "  add - Add a new task to project with id = PID"
    puts "  mark - Mark task with id = TID as complete"
    puts "  exit - Exit the program.\n\n"

    user_choice(gets.chomp.downcase)
  end

  def list
    if TM::Project.project_list.size == 0
      puts "\nYou have not created any projects yet! Enter 'create' to start a new project."
      return user_choice(gets.chomp.downcase)
    end

    puts "\nYour Projects:\nID             Name"
    puts "-------------------------------------"
    TM::Project.project_list.each do |project|
      puts "#{project.id}:             #{project.name}"
    end
    user_choice(gets.chomp.downcase)
  end

  def create(name)
    check_project_names(name)
    puts "\nAdded project #{name} to project list. Enter 'list' to view projects."
    TM::Project.new(name)
    user_choice(gets.chomp.downcase)
  end

  def show(project_id)
    puts "\nProject '#{TM::Project.project_list[project_id].name}' has the following tasks remaining:"
    puts "\nTasks ID:                Description"
    puts "-------------------------------------"
    TM::Project.project_list[project_id].get_incomplete_tasks.each do |task|
      puts "#{task.task_id}                        #{task.description}"
    end
    user_choice(gets.chomp.downcase)
  end

  def history(project_id)
    puts "The following tasks have been completed in Project '#{TM::Project.project_list[project_id].name}'."
    puts "\nTasks ID:                Description"
    puts "-------------------------------------"
    TM::Project.project_list[project_id].get_completed_tasks.each do |task|
      puts "#{task.task_id}                        #{task.description}"
    end
    user_choice(gets.chomp.downcase)
  end

  def add(description, priority_number, project_id)
    puts "Added task '#{description}' to Project '#{TM::Project.project_list[project_id].name}'"
    TM::Project.project_list[project_id].add_task(description, priority_number)
    user_choice(gets.chomp.downcase)
  end

  def mark(project_id, task_id)
    puts "Task '#{TM::Project.project_list[project_id].task_list[task_id].description}' in Project '#{TM::Project.project_list[project_id].name}' is complete."
    TM::Project.project_list[project_id].mark_complete(task_id)
    user_choice(gets.chomp.downcase)
  end

  def exit
    puts "Goodbye."
  end

  def check_project_ids(project_id)
    return "Invalid Project ID" if TM::Project.project_list[project_id].nil?
  end

  def check_task_ids(project_id, task_id)
    if TM::Project.project_list[project_id].task_list[task_id].nil?
      return "Invalid Task ID"
    end
  end

  def check_project_names(name)
    TM::Project.project_list.each do |project|
      if project.name == name
        return "This project name is already in use!  Please choose another."
      end
    end
  end
end

TM::TerminalClient.new.start

