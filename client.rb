require 'io/console'
require_relative './lib/task-manager.rb'

class Client

  puts "Welcome to Project Manager Pro! What can I do for you today?"

    def self.comm_ls
      puts "Available Commands: "
      puts "\n"
      puts "help - Show these commands again"
      puts "project list - List all projects"
      puts "project create NAME - Create a new project with NAME"
      puts "project show PID - Show remaining tasks for project PID"
      puts "project history PID - Show completed tasks for project PID"
      puts "project employees PID - Show employees participating in this project"
      puts "project recruit PID EID - Adds employee EID to participate in project PID"
      puts "task create PID PRIORITY DESC - Add a new task to project PID"
      puts "task assign TID EID - Assign task TID to employee EID"
      puts "task mark TID - Mark task TID as complete"
      puts "emp list - List all employees"
      puts "emp create NAME - Create a new employee"
      puts "emp show EID - Show employee EID and all participating projects"
      puts "emp details EID - Show all remaining tasks assigned to employee EID,
                    along with the project name next to each task"
      puts "emp history EID - Show completed tasks for employee with id=EID"
      puts "exit"
    end

    Client.comm_ls

    command = ""

    while command != "exit"

      command = gets.chomp

    case
      # HELP
      when (command =~ /\A\s*help\s*/i)
        Client.comm_ls

      # PROJECT LIST
      when (command =~ /\A\s*project\s*list\s*/i)
        result = TM::ListAllProjects.run({})

        puts "\n"
        puts "Project ID \t Project Name "

        if result.success?
          proj_arr = result.all_projects
          proj_arr.each do |project|
            puts "#{project.id} \t\t #{project.name}"
          end
        else
            puts result.error
        end

      # --PROJECT CREATE NAME--
      when (/\A\s*(project)\s*(create)\s*(.+)/i.match(command))
        result =TM::CreateNewProj.run({:name => $3})

        if result.success?
          project = result.project
          puts "\n"
          puts "Your new project: ID: #{project.id}  Name: #{project.name}"
        end

      # --PROJECT SHOW PID--
      when (/\A\s*(project)\s*(show)\s*(\d+)/i.match(command))
        result = TM::ShowRemainingTasksinProject.run({:project_id => $3})

        if result.success?
          project = result.project
          remaining_tasks = result.task_arr
          puts "\n"
          puts "Remaining Tasks in '#{project.name}'"
          puts "Task ID \t Created \t \t Description \t \t Priority"

          remaining_tasks.each do |task|
            puts "#{task.id} \t #{task.created} \t #{task.description} \t \t #{task.priority}"
          end
        else
          puts result.error
        end

      # --PROJECT HISTORY PID--
      when (/\A\s*(project)\s*(history)\s*(\d+)/i.match(command))


       result = TM::ShowCompletedTasksinProject.run({:project_id => $3})

        if result.success?
          project = result.project
          completed_tasks = result.task_arr
          puts "\n"
          puts "Remaining Tasks in #{project.name}"
          puts "Task ID \t Created \t Description \t Priority"

          completed_tasks.each do |task|
            puts "#{task.id} \t #{task.created} \t #{task.description} \t #{task.priority}"
          end
        else
          puts result.error
        end

        # --PROJECT EMPLOYEES PID--
      when (/\A\s*(project)\s*(employees)\s*(\d+)/i.match(command))

       result = TM::ShowEmployeesInProject.run({:project_id => $3})

        if result.success?
          project = result.project
          employee_arr = result.employees
          puts "\n"
          puts "Employees Participating in #{project.name}"
          puts "Employee ID \t Name"

          employee_arr.each do |emp|
            puts "#{emp.id} \t \t #{emp.name}"
          end
        else
          puts result.error
      end

      # --PROJECT RECRUIT PID EID--

      when (/\A\s*(project)\s*(recruit)\s*(\d+)\s*(\d+)/i.match(command))

       result = TM::AddEmployeeToProject.run({:project_id => $3, :employee_id => $4})

        if result.success?
          project = result.project
          employee = result.employee
          puts "\n"
          puts "You have added employee #{employee.name} to project [ID: #{project.id}]'#{project.name}'"
        else
          puts result.error
        end

      # --TASK CREATE PID PRIORITY DESC--

      when (/\A\s*(task)\s*(create)\s*(\d+)\s*(\d+)\s*(.+)/i.match(command))

       result = TM::CreateTask.run({:project_id => $3, :priority => $4, :description => $5})

        if result.success?
          project = result.project
          task = result.task
          puts "\n"
          puts "[ID:#{task.id}]'#{task.description}' with priority #{task.priority} has been added to [ID:#{project.id}]'#{project.name}'"
        else
          puts result.error
        end

      # --TASK ASSIGN TID EID--
      when (/\A\s*(task)\s*(assign)\s*(\d+)\s*(\d+)/i.match(command))

        result = TM::AssignTaskToEmployee.run({:task_id => $3, :employee_id => $4})

        if result.success?
          task = result.task
          employee = result.employee
          puts "\n"
          puts "[ID:#{task.id}]'#{task.description}' has been assigned to employee [ID:#{employee.id}]#{employee.name}"
        else
          puts result.error
        end

      # --TASK MARK TID--

      when (/\A\s*(task)\s*(mark)\s*(\d+)/i.match(command))

       result = TM::MarkTaskAsComplete.run({:task_id => $3})

        if result.success?
          task = result.task
          puts "\n"
          puts "[#{task.id}]'#{task.description}' has been marked complete"
        else
          puts result.error
        end

      # --EMP LIST--
      when (/\A\s*(emp)\s*(list)\s*/i.match(command))

        result = TM::ListAllEmployees.run({})

        if result.success?
          employee_hash = result.all_employees
          puts "\n"
          puts "Employee ID \t Name"
          employee_hash.each do |id, emp|
            puts "#{id} \t \t #{emp.name}"
          end
        else
          puts result.error
        end


      # --EMP CREATE NAME--
      when (/\A\s*(emp)\s*(create)\s*(.+)/i.match(command))

         result = TM::CreateEmployee.run({:name => $3})

        if result.success?
          employee = result.employee
          puts "\n"
          puts "[ID:#{employee.id}]#{employee.name} has been added to the database"
        end

      # --EMP SHOW EID--
      when (/\A\s*(emp)\s*(show)\s*(\d+)/i.match(command))
        result = TM::ShowEmpsProjects.run({:employee_id => $3})

        if result.success?
          employee = result.employee
          project_arr = result.projects
          puts "\n"
          puts "Projects for [ID:#{employee.id}]#{employee.name}"
          puts "Project ID \t Project Name"
          project_arr.each do |proj|
            puts "#{proj.id} \t \t #{proj.name}"
          end
        else
          puts result.error
        end

      # --EMP DETAILS EID--
      when (/\A\s*(emp)\s*(details)\s*(\d+)/i.match(command))
        result = TM::ShowEmployeeRemainingTasks.run({:employee_id => $3})

        # task_hash = {task_id => [task, project]}
        if result.success?
          employee = result.employee
          task_hash = result.task
          puts "\n"
          puts "Remaining Tasks for [ID:#{employee.id}]#{employee.name}"
          puts "Project \t Task Description \t \t Task Priority \t \t Task Created"

          task_hash.each do |task_id, tskprj_arr|
            puts "#{tskprj_arr[1].name} \t #{tskprj_arr[0].description} \t #{tskprj_arr[0].priority} \t \t #{tskprj_arr[0].created}"
          end
        else
          puts result.error
        end


      # --EMP HISTORY EID--

      when (/\A\s*(emp)\s*(history)\s*(\d+)/i.match(command))
        result = TM::ShowEmployeeCompleteTasks.run({:employee_id => $3})

        # task_hash = {task_id => [task, project]}
        if result.success?
          employee = result.employee
          task_hash = result.task
          puts "\n"
          puts "Completed Tasks for [ID:#{employee.id}]#{employee.name}"
          puts "Project \t \t Task Description \t \t Task Created "

          task_hash.each do |task_id, tskprj_arr|
            puts "#{tskprj_arr[1].name} \t \t #{tskprj_arr[0].description} \t \t #{tskprj_arr[0].created}"
          end
        else
          puts result.error
        end

      when (/exit/.match(command))
        puts "\n"
        puts "Goodbye! :)"
      else puts "Not a Project Manager Pro command"
      end

    end

end
