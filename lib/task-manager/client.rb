class TM::TerminalClient

  def run
    puts "Please, enter a command."
    user_input = gets.chomp
    split_input = user_input.split

    user_cmd = split_input[0]
    self.parse(user_cmd, split_input)

  end

  def parse(user_cmd, split_input)

    case user_cmd
    when "help"
      puts ""
      puts "You can use these commands:"
      puts ""
      puts "help"
      puts "add projects"
      puts "list projects"
      puts "create tasks"
      puts "show incomplete tasks"
      puts "history" 
      puts "complete a task" 
      puts "exit the terminal"
    when "list"
      TM::Project.new "Eat healthy"
      TM::Project.projects_list.each do |project|
        puts project.name
      end
    when "create"
      TM::Project.new split_input
      TM::Project.projects_list.each do |project|
        puts project.name
      end
    # when "show"
    # when "history"
    # when "add"
    # when "complete"
    # else 
    #   puts "That is not a command. Please, enter a command from the available list."
    end
  end
end