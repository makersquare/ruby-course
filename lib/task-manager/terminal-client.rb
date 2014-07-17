class TM::TerminalClient

  def initialize
    @run = true
  end

  def run_program
    list_commands
    @run = true
    while @run == true
      @input = gets.chomp
      execute
    end
  end

  def list_commands
    puts "Welcome to Project Manager Pro. What can I do for you today?"
    puts ""
    puts "Available Commands:"
    puts "\t help - Show these commands again"
    puts "\t list - List all projects"
    puts "\t create NAME - Create a new project with name=NAME"
    puts "\t show PID - Show remaining tasks for project with id=PID"
    puts "\t history PID - Show completed tasks for project with id=PID"
    puts "\t add PID PRIORITY DESC - Add a new task to project with id=PID"
    puts "\t mark TID - Mark task with id=TID as complete"
    puts "\t exit - Exits Project Manager Pro"
  end

  def execute
    command = @input.split(" ")[0].to_sym
    action = @input.split(" ")[1..-1]

    case command
    when :help
      list_commands
    when :list
      puts "PID\tName"
      TM::Project.print_projects
    when :create
      # creates new project with action array
      name = action.join(" ")
      TM::Project.new(name)
    when :show
      # shows tasks with project ID
      id = action[0].to_i
      project = TM::Project.get_project(id)
      tasks = project[0].todo
      puts "Priority\tID\tDescription"
      tasks.each{|task| puts "#{task.priority}\t\t#{task.tid}\t#{task.description}"}
    when :history
      # shows completed tasks for project matching PID
      id = action[0].to_i
      project = TM::Project.get_project(id)
      tasks = project[0].completed_tasks
      puts "Completed tasks:"
      puts "ID\tDescription"
      tasks.each{|task| puts "#{task.tid}\t#{task.description}"}
    when :add
      #adds new task to matching PID with priority and description
      id = action[0].to_i
      project = TM::Project.get_project(id)
      priority = action[1].to_i
      description = action[2..-1].join(" ")
      project[0].new_task(description, priority)
      puts "New task #{description} created for #{project[0].id}: #{project[0].name}"
    when :mark
      # mark task as complete depending on TID
      id = action[0].to_i
      task = TM::Task.find_task(id)
      task[0].set_complete
      puts "Task from Project ID:#{task[0].pid}: #{task[0].description} has been completed"
    when :exit
      @run = false
    else
      puts "Not a command. Please enter one of the listed commands only"
      list_commands
    end
  end
end
