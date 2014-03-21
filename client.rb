require_relative 'lib/task-manager.rb'

TERMINAL_PROMPT = <<-eos
Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  list - List all projects
  create NAME - Create a new project with name=NAME
  show PID - Show remaining tasks for project with id=PID
  history PID - Show completed tasks for project with id=PID
  add PID PRIORITY DESC - Add a new task to project with id=PID
  mark TID - Mark task with id=TID as complete
eos

class TM::TerminalClient
  # definitely don't want to do this.. abstract later
  def initialize
    @pl = TM::DB.instance
  end

  def start
    run_terminal_prompt

    user_input = gets.chomp
    parse_input(user_input)

    start
  end

  def parse_input(input)
    input = input.split(' ')
    command = input[0]

    if command == "help"
      help
    elsif command == "list"
      @pl.projects.each do |proj|
        puts proj.name
      end
    elsif command == "create"
      title = input[1]
      created_proj = @pl.create_project(title)
      puts "Created a new project: "
      puts "PID  Name"
      puts "  #{created_proj.id}   #{created_proj.name}"
    elsif command == "show"
      pid = input[1]
      remaining_tasks = @pl.show_proj_tasks_remaining(pid)
      puts "Priority    TID  Description"
      remaining_tasks.each do |task|
        puts "       #{task.priority}      #{task.id}  #{task.description}"
      end
    elsif command == "history"
      pid = input[1]
      completed_tasks = @pl.show_proj_tasks_complete(pid)
      puts "Priority    TID  Description"
      completed_tasks.each do |task|
        puts "       #{task.priority}      #{task.id}  #{task.description}"
      end
    elsif command == "add"
      pid = input[1]
      priority = input[2]
      desc = input[3]

      add_task(pid, desc, priority)

    elsif command == "mark"
      tid = input[1]
      completed_task = @pl.mark_task_as_complete(tid)
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

    added_task = @pl.add_task_to_proj(pid, desc, priority)

    puts "Priority    TID  Description"
    puts "       #{added_task.priority}      #{added_task.id}  #{added_task.description}"
  end
end

tm = TM::TerminalClient.new
tm.start

