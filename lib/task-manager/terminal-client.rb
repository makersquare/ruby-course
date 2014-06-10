class TM::TerminalClient
  
  @@menu = 'Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  list - List all projects
  create NAME - Create a new project with name=NAME
  show PID - Show remaining tasks for project with id=PID
  history PID - Show completed tasks for project with id=PID
  add PID PRIORITY DESC - Add a new task to project with id=PID
  mark TID - Mark task with id=TID as complete' 	
	
  def initialize 
	
    puts @@menu
    while true

     comand_raw = gets.chomp
     comand = comand_raw.split()[0]
     arg = comand_raw.size == 2 ? comand_raw.split()[1] : nil
     
     case comand
        when "help"
          puts @@menu
        when "list"
          TM::Project.list_proyects
        when "create"
          puts arg

          if !arg.nil? 
            TM::Project.new(arg)
          else
              puts "name missed"
          end 
        when "show"
          if !arg.nil? 
            TM::Project.show_remaining(arg.to_i)
          else 
            puts "id missed"
          end
      end
    end
  end  

end
    
