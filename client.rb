require_relative 'lib/task-manager.rb'

TERMINAL_PROMPT = <<-eos
Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  project list - List all projects
  project create NAME - Create a new project
  project show PID - Show remaining tasks for project PID
  project history PID - Show completed tasks for project PID
  project employees PID - Show employees participating in this project
  project recruit PID EID - Adds employee EID to participate in project PID
  task create PID PRIORITY DESC - Add a new task to project PID
  task assign TID EID - Assign task TID to employee EID
  task mark TID - Mark task TID as complete
  emp list - List all employees
  emp create NAME - Create a new employee
  emp show EID - Show employee EID and all participating projects
  emp details EID - Show all remaining tasks assigned to employee EID,
                    along with the project name next to each task
  emp history EID - Show completed tasks for employee with id=EID
eos

class TM::TerminalClient
  # definitely don't want to do this.. abstract later
  def initialize
    @db = TM::DB.instance
  end

  def start
    run_terminal_prompt
    input = gets.chomp
    # Example input: task create 1 3 description of task
    split = input.split(' ')
    model = split.shift # e.g. project, task, emp
    action = split.shift # e.g. list, create, show, history, etc
    args = split # The rest of the arguments, since .split modifies the array
  end
  # def start
  #   run_terminal_prompt

  #   user_input = gets.chomp
  #   parse_input(user_input)

  #   start
  # end

  def parse_input(input)
    input = input.split(' ')
    command = input[0]

    if command == "help"
      help
    elsif command == "list"
      @db.projects.each do |proj|
        puts proj.name
      end
    elsif command == "create"
      title = input[1]
      created_proj = @db.create_project(title)
      puts "Created a new project: "
      puts "PID  Name"
      puts "  #{created_proj.id}   #{created_proj.name}"
    elsif command == "show"
      pid = input[1]
      remaining_tasks = @db.show_proj_tasks_remaining(pid)
      puts "Priority    TID  Description"
      remaining_tasks.each do |task|
        puts "       #{task.priority}      #{task.id}  #{task.description}"
      end
    elsif command == "history"
      pid = input[1]
      completed_tasks = @db.show_proj_tasks_complete(pid)
      puts "Priority    TID  Description"
      completed_tasks.each do |task|
        puts "       #{task.priority}      #{task.id}  #{task.description}"
      end
    elsif command == "add"
      pid = input[1]
      priority = input[2]

      # ***THIS IS NOT RIGHT*** - will only work for one-word descriptions
      desc = input[3]

      add_task(pid, desc, priority)

    elsif command == "mark"
      tid = input[1]
      completed_task = @db.mark_task_as_complete(tid)
      puts "Marked task as complete: "
      puts "Priority    TID  Description"
      puts "       #{completed_task.priority}      #{completed_task.id}  #{completed_task.description}"
    end

  end

  def run_terminal_prompt
    # found out this could be done by googling:
    # ruby multiline string
    puts TERMINAL_PROMPT

    print "> "
  end

private

  def help
    run_terminal_prompt
  end

  def add_task(pid, desc, priority)

    added_task = @db.add_task_to_proj(pid, desc, priority)

    puts "Priority    TID  Description"
    puts "       #{added_task.priority}      #{added_task.id}  #{added_task.description}"
  end
end

tm = TM::TerminalClient.new
tm.start

