
class TM::Terminal
  @@lines_counter = 0

  def self.call()
    puts "Welcome to Project Manager Pro. What can I do for you?"
    get_input
  end

  def get_input
    @@lines_counter += 1
    print ">"
    input = gets.chomp
    input = input.split()
    parse_input(input[0], input)
  end

  def parse_input(cmd, input)
    case cmd
    when "add"
      add_task(input)
    when "list"
      list_tasks(input)
    when "create"
      create_task(input)
    when "show"
      show_tasks(input)
    when "history"
      show_history(input)
    when "mark"
      mark_task(input)
    when "help"
      show_help
    when "clear"
      system "clear" or system "cls"
    when "exit"
      return
    else
      puts "Invalid command #{cmd}."
    end

    get_input
  end

  def add_task(input)
    id, desc, priority = input
    TM::Task.new(id,desc,priority)
  end

  def show_tasks(input)
    id = input
    project = TM::Project.project_list[id]
    project.get_incomplete_tasks.each { |t| puts t }
  end

  def create_task(input)

  def list_tasks(input)
    TM::Task.task_list
  end

  def show_history(input)
    id = input
    
    project = TM::Project.project_list[id]
    project.get_complete_tasks.each { |t| puts t }
  end

  def add_task(input)
  def mark_task(input)
  def show_help
    command_list = {
      list:     [[    ], "List all projects"],
      create:   [:name], "Create a new project with name=NAME"],
      show:     [:pid ], "Show remaining tasks for project with id=PID"],
      history:  [:pid ], "Show completed tasks for project with id=PID"],
      add:      [:pid, :priority, :desc ], "Add a new task to project with id=PID"],
      mark:     [:tid ], "Mark task with id=TID as complete"]
      help:     [[    ]. "Display this menu"],
      clear:    [[    ]. "Clear the screen"],
      exit:     [[    ]. "Exit the program"],
    }

    system "clear" or system "cls"
    puts "-- Project Manager Pro --\n"
    puts "Available Commands:"
    command_list.each {|k,v| puts ""}
    puts
  end
    

  def invalid_input(input) 
    puts "ERROR: Invalid parameter(s) for command #{input[0]}"
    puts "-- #{input[1..-1].join(" ")} -- not recognized."
    puts "type 'help' at any time to display the help menu"
    get_input
  end

# def self.puts(*args)
#   @@lines_counter += 1
#   args.each { |arg| print arg }
#   print "\n"
#   nil
# end

end
