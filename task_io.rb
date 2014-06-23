require_relative 'lib/task-manager.rb'
require 'terminal-table'

class Task_io
    puts "Welcome to Task Manager.  How may we assist you?\n\n"

    puts "Available Commands: \n"
    puts "  help - Show these commands again"
    puts "  project list - List all projects"
    puts "  project create NAME - Create a new project with name=NAME"
    puts "  project show PID - Show remaining tasks for a project with id=PID"
    puts "  project history PID - Show completed tasks for project with id=PID"
    puts "  project employees PID - Show employees participating in the project"
    puts "  project recruit PID EID - Adds employee EID to participate in project PID"
    puts "  task create PID PRIORITY DESC - Add a new task to project PID"
    puts "  task assign TID EID - Assign task to employee"
    puts "  task mark TID - Mark task TID as complete"
    puts "  emp list - List all employees"
    puts "  emp create NAME - Create a new employee"
    puts "  emp show EID - Show employee EID and all participating projects"
    puts "  emp details EID - Show all remaining tasks assigned to employee EID, along with the project name next to each task"
    puts "  emp history EID - Show completed tasks for employee with id=EID"
    puts "  quit - Exit program\n"

  def start
    puts 'Enter request>'
    req = gets.chomp
    command = req.split[0]
    command_type = req.split[1]
    input = req.split

    if req == 'quit'
        return
    else
        case command
        when 'help'
            puts "Available Commands: \n"
            puts "  help - Show these commands again"
            puts "  project list - List all projects"
            puts "  project create NAME - Create a new project with name=NAME"
            puts "  project show PID - Show remaining tasks for a project with id=PID"
            puts "  project history PID - Show completed tasks for project with id=PID"
            puts "  project employees PID - Show employees participating in the project"
            puts "  project recruit PID EID - Adds employee EID to participate in project PID"
            puts "  task create PID PRIORITY DESC - Add a new task to project PID"
            puts "  task assign TID EID - Assign task to employee"
            puts "  task mark TID - Mark task TID as complete"
            puts "  emp list - List all employees"
            puts "  emp create NAME - Create a new employee"
            puts "  emp show EID - Show employee EID and all participating projects"
            puts "  emp details EID - Show all remaining tasks assigned to employee EID, along with the project name next to each task"
            puts "  emp history EID - Show completed tasks for employee with id=EID"
            puts "  quit - Exit program\n"
            self.start

        when 'project'
            case command_type
            when 'list'
                #FORMATTING
                puts TM::Project.list_projects
                self.start
            when 'create'
                new_proj = TM::Project.add_project(input[2])
                puts "Project #{new_proj.name} was created with PID #{new_proj.pid}"
                self.start
            when 'show'
                #puts "  project show PID - Show remaining tasks for a project with id=PID"
                puts TM::Project.list_incomplete_tasks(input[2])
                self.start
            when 'history'
                #puts "  project history PID - Show completed tasks for project with id=PID"
                puts TM::Project.list_completed_tasks(input[2])
                self.start
            when 'employees'
                #puts "  project employees PID - Show employees participating in the project"
                puts TM::Project.list_project_staffing(input[2])
                self.start
            when 'recruit'
                TM::Project.update_employee_project(input[2], input[3])
                puts "Employee #{input[3]} has been recruited to project PID #{input[2]}"
                self.start
            else
                puts "Invalid request, please try again"
                self.start
            end

        when 'task'
            case command_type
            when 'create'
                new_task = TM::Project.add_task(input[3], input[4], input[2])
                puts "Task TID #{new_task.tid}, #{input[4]} with priority #{input[3]} was assigned to project PID #{input[2]}"
                self.start
            when 'assign'
                TM::Project.update_employee_task(input[3], input[2])
                puts "Task TID #{input[2]} was assigned to employee EID #{input[3]}"
                self.start
            when 'mark'
                TM::Project.update_complete(input[2])
                puts "Task #{input[2]} was marked 'complete'"
                self.start
            else
                puts "Invalid request, please try again"
                self.start
            end

        when 'emp'
            case command_type
            when 'list'
                #puts "  emp list - List all employees"
                puts TM::Project.list_employees
                self.start
            when 'create'
                new_employee = TM::Project.add_employee(input[2])
                puts "Employee #{input[2]} has been added with EID #{new_employee.eid}"
                self.start
            when 'show'
                #puts "  emp show EID - Show employee EID and all participating projects"
                puts TM::Project.list_employee_projects(input[2])
                self.start
            when 'details'
                #puts "  emp details EID - Show all remaining tasks assigned to employee EID, along with the project name next to each task"
                puts TM::Project.list_employee_tasks(input[2])
                self.start
            when 'history'
                #puts "  emp history EID - Show completed tasks for employee with id=EID"
                puts TM::Project.list_employee_history(input[2])
                self.start
            else
                puts "Invalid request, please try again"
                self.start
            end
            end
        end
    end
end

Task_io.new.start
