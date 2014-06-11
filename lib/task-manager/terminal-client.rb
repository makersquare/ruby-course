# require 'pry'
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
    puts
    while true



     comand_raw = (gets.chomp).split
     # binding.pry
     comand = comand_raw[0]
     arg = comand_raw[1..-1]


     # arg = comand_raw.size  2 ? comand_raw.split()[1] : nil
     # puts comand
     # puts comand_raw.size
     # puts comand
     # puts arg
     

     case comand
        when "help"
          puts @@menu
        when "list"
          TM::Project.list_proyects
        when "create"
          # puts arg

          if  !(arg == [])
            TM::Project.new(arg.join(" "))
            # puts p.name
            puts 'done!!'
          else
              puts "name missed"
          end 
        when "show"
          if !(arg == []) 
            TM::Project.show_remaining(arg[0].to_i)
          else 
            puts "id missed"
          end
        when "add"
          if arg.size >= 3
            pid = arg[0]
            pri = arg[1]
            desc = arg[2..-1].join(" ")
            TM::Task.new(pid,desc,pri)
          else
              "missed data"
          end
        when "mark"
          if  !(arg == [])
            TM::Task.complete_a_task(arg[0].to_i)
          else
            puts "id missed"
          end
            
          
      end
    end
  end  

end
    
