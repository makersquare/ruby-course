class TM::TerminalClient

  attr_accessor :projects

  def initialize
    @project_manager = TM::ProjectsManager.new
  end

  def list_all_projects
    puts "PID        Project Name"
    @project_manager.list_projects.each do |project|
      puts " #{project.id}         #{project.name}"
    end
  end

  def create_project(name)
    @project_manager.create_project(name)
  end

  def add_task(project_id, priority, description)
    @project_manager.add_task(project_id, priority, description)
  end

  def uncompleted_task(pid)
    puts "Priority  TID  Description"
    @project_manager.remaining_task(pid).each do |task|
      puts "       #{task.priority}   #{task.task_id}   #{task.description}"
    end
  end

  def complete_task(tid)
    @project_manager.complete_task(tid)
  end

  def history(pid)
    puts "TID  Description"
    @project_manager.history(pid).each do |task|
      puts " #{task.task_id}   #{task.description}"
    end
  end

  def run_program
    @run = true
    puts "Welcome to Project Manager Pro.  What can I do for you today?"
    puts
    list_instructions
    while @run == true
      input = gets.chomp
      check_user_input(input)
   end
  end

  def list_instructions
    puts "Available Commands:"
    puts
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show remaining tasks for project with id=PID"
    puts "  add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark TID - Mark task with id=TID as complete"
    puts "  exit - Will exit the program"
    puts
    puts "Please enter in a command: "
  end

  def check_user_input(input)
    input_array = input.split(" ")
    input_action = input_array[0].downcase.to_sym

    if input_action == :list
      list_all_projects
    elsif input_action == :create
      create_project(input_array[1..-1].join(" "))
    elsif input_action == :show
      uncompleted_task(input_array.last.to_i)
    elsif input_action == :show
      history(input_array.last.to_i)
    elsif input_action == :add
      add_task(input_array[1].to_i, input_array[2].to_i, input_array[3..-1].join(" "))
    elsif input_action == :mark
      complete_task(input_array[1].to_i)
    elsif input_action == :help
      list_instructions
    elsif input_action == :exit
      @run = false
    else
      "I'm sorry that is not a valid command"
    end
  end

end
