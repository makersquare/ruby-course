class TM::TerminalClient

  def initialize
    TM::TerminalClient.help
  end

  def help
    puts "Commands:"
    puts "help - Shows Commands"
    puts "list - Lists Projects"
    puts "project (type name) - Creates New Project"
    puts "task (type description and priority number) - Creates New Task"
    puts "show PID - Show Project ID"
    puts "show TID - Show Task ID"
    puts "complete - Shows Complete Tasks"
    puts "incomplete -Shows Incomplete Tasks"
    puts "mark TID - Marks Task Complete with ID"
    puts "quit - Quit Program"
    input = gets.chomp
    command = input.split[0]
    x = input.split[1]
    y = input.split[2]
  end

  def run
    case command
    when "project"
      TM::Project.new(x)
    when "task"
      TM::Task.new(x, y)
    when "help"
      TM::TerminalClient.help
    when "list"
      TM::Project.projects
    when "complete"
      TM::Project.complete_tasks
    when "incomplete"
      TM::Project.incomplete_tasks
    when "mark TID"
      TM::Task.complete_task(x)
    when "show TID"
      TM::Task.task_id(x)
    when "show PID"
      TM::Task.id(x)
    else
      puts "Goodbye"
    end
  end

end

