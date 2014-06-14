class TM::TerminalClient

  def run
    puts "Please, enter a command."
    user_input = gets.chomp
    split_input = user_input.split

    user_cmd = split_input[0]

    parse(user_cmd, split_input) XXXXXXXXXXXXXXXXXXXXXXX

  end

  def parse(user_cmd, user_input)

    case user_cmd

    when "help"
      puts "You can use these commands:"
      puts "help, add projects, list projects, create tasks, show incomplete tasks, history, complete a task, and exit the terminal."
    when "list"
      TM::Project.projects_list.name

    when "create"
    when "show"
    when "history"
    when "add"
    when "complete"
    else 
      puts "That is not a command. Please, enter a command from the available list."


  end



end


$ bundle exec ruby pm.rb
Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  list - List all projects
  create NAME - Create a new project with name=NAME
  show PID - Show remaining tasks for project with id=PID
  history PID - Show completed tasks for project with id=PID
  add PID PRIORITY DESC - Add a new task to project with id=PID
  mark TID - Mark task with id=TID as complete
> show 1
Showing Project "Bucket List"

Priority    ID  Description
       1    12  Become a vegan
       2     8  Master cookie clicking
       2     9  Reconsider eating meat again