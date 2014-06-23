# require 'pry'
class TM::TerminalClient
  
  @@menu = 'Welcome to Project Manager Pro®. What can I do for you today?

Available Commands:
  help - Show these commands again
  project list - List all projects
  project create NAME - Create a new project 
  project show PID - Show remaining tasks for project PID
  project history PID - Show completed tasks for project PID 
  project employees PID - Show employees participating in this project
  project recruit PID EID - Adds employee EID to participate in project PID
  task create PID PRIORITY DESC - Add a new task to project PID
  task assign TID EID - Assign task to employee
  task mark TID - Mark task TID as complete
  emp list - List all employees
  emp create NAME - Create a new employee
  emp show EID - Show employee EID and all participating projects
  emp details EID - Show all remaining tasks assigned to employee EID,
                    along with the project name next to each task
  emp history EID - Show completed tasks for employee with id=EID

  '
	
  def initialize 
	
    puts @@menu
    
    storage = TM::Connector.new 


    while true

     comand_raw = (gets.chomp).split
     # binding.pry
     comand = comand_raw[0..1].join('-')
     arg = comand_raw[2..-1]
     
     case comand
        when "help"
          puts @@menu
        when "project-list"
          TM::Project.list_proyects(storage.get_projects())
        when "project-create"
          if  !(arg == [])
            project = TM::Project.new(arg.join(" "))
            storage.save_project(project)
            # puts p.name
            puts 'you just create project with id #{project.id}'
          else
              puts "name missed"
          end

        when  'project-recruit'
          if !(arg.size != 2)
            p_id = arg[0]
            e_id = arg[1]
            storage.recruit(p_id,e_id)
            puts 'done'
          else
            puts "missed data"
          end
        when 'emp-create'
          if !(arg == [])
            puts arg.join(" ")
            emp = TM::Employee.new(arg.join(" "))
            storage.save_employee(emp)
            puts 'you just create employee with id #{emp.id}'
          else
            puts "name missed"
          end
          
        when 'task-create'
          if !(arg == [])
            pid = arg[0]
            pri = arg[1]
            desc = arg[2..-1].join(" ")
            ts = TM::Task.new(pid,desc,pri)
            if storage.save_task(ts) != false
              puts 'you just create task with id #{ts.id}'
            else
              puts 'error!'
            end
          else
              puts "missed data"
          end

        when "project-show"
          if !(arg == []) 
            pending_task = storage.rem_tasks(arg[0].to_i)
            TM::Project.show_remaining(pending_task)
          else 
            puts "id missed"
          end

        when 'project-history'
          if !(arg == [])
            completed_tasks = storage.com_tasks(arg[0].to_i)
            TM::Project.show_remaining(completed_tasks)
          else
             puts 'id missed'
          end
        
        when "task-mark"
          if  !(arg == [])
            storage.mark_complete(arg[0].to_i)
            puts "you just modify task with id #{arg[0].to_i}"
          else
            puts "id missed"
          end
        
        when 'emp-list'
          emp_list = storage.get_employees()
          TM::Employee.list(emp_list)
        
        when 'project-employees'
          if !(arg == [])
            list = storage.employees_on_proj(arg[0].to_i)
            TM::Employee.list(list)  
          else
            puts "id missed"
          end
        
        when 'task-assign'
          if !(arg == [])
            t_id = arg[0]
            e_id = arg[1]
            state = storage.check_res_avi(t_id,e_id)
            if state
              storage.assign_task(t_id,e_id)
            else
              puts 'invalid employee'
            end
          else
            puts 'missed parameters'
          end
          
        when 'emp-show'
          if !(arg == [])
            list = storage.get_emp_proj(arg[0].to_i)
            emp = storage.get_employee_id(arg[0].to_i)
            puts "The employee: #{emp[0]['name']} participate at:"
            TM::Project.list_proyects(list)
          else
            puts "id missed"
          end

        when 'emp-details'        
          if !(arg == [])
            list = storage.emp_x_tasks(arg[0].to_i,false)
            emp = storage.get_employee_id(arg[0].to_i)
            puts "The employee: #{emp[0]['name']} has pendding to do:"
            list.each {|e| puts "Task: #{e['tid']} - Desc: #{e['tdesc']} from Project: #{e['pname']} "}
          else
            puts 'missed parameters'
          end

        when "emp-history"
          if !(arg == [])
            list = storage.emp_x_tasks(arg[0].to_i,true)
            emp = storage.get_employee_id(arg[0].to_i)
            puts "The employee: #{emp[0]['name']} completed:"
            list.each {|e| puts "Task: #{e['tid']} - Desc: #{e['tdesc']}
            from Project: #{e['pname']} "}
          else
              puts 'missed parameters'
          end
          
        end

     
    
    end
  end  
end
    
