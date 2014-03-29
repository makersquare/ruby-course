require 'pry-debugger'
module TM
  class ProjectManager

    def initialize(db)
      @input = ""
      @db = db
      @control = []
    end

    def menu
      puts "Welcome to Project Manager Pro®. What can I do for you today?"
      puts ""
      puts "Available Commands:"
      puts "help - Show these commands again"
      puts "project list - List all projects"
      puts "project create NAME - Create a new project"
      puts "project show PID - Show remaining tasks for project PID"
      puts "project history PID - Show completed tasks for project PID"
      puts "project addemployee PID EID - Add an employee EID to project PID"
      puts "project employees PID - Show employees participating in this project"
      puts "task create PID PRIORITY DESC - Create a new task for project PID"
      puts "task assign TID EID - Assign task TID to employee EID"
      puts "task mark TID - Mark task TID complete"
      puts "emp list - List all employees"
      puts "emp create NAME - Create a new employee"
      puts "emp show EID - Show employee EID and all participating projects"
      puts "emp details EID - Show all remaining tasks assigned to employee EID,"
      puts "                  along with the project name next to each task"
      puts "emp history EID - Show completed tasks for employee with id=EID"
      puts "quit - Exit program"
      input

      while @control[0] != "quit" do
        case @control[0]
          when "help" then menu
          when "project"
            case @control[1]
              when "list" then list
              when "create" then create_project
              when "show" then show
              when "history" then history
              when "employees" then list_employees_on_project
              when "addemployee" then add_employee_to_project
              else input
            end
          when "task"
            case @control[1]
              when "create" then create_task
              when "assign" then assign
              when "mark" then mark
              else input
            end
          when "emp"
            case @control[1]
              when "list" then list_all_employees
              when "create" then create_employee
              when "show" then show_employee
              when "details" then employee_remaining_tasks
              when "history" then employee_history
              else input
            end
          else input
        end
      end
    end

    def input
      puts ""
      puts "Input your choice:"
      @input = gets.chomp
      @control = @input.split
      puts ""
    end

    def list
      result = TM::GetAllProjects.run({})
      if result.success?
        puts "PID:\tName:"
        result.projects.each { |project| puts "#{project.project_id}\t#{project.name}" }
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def create_project
      result = TM::CreateProject.run({ :name => @control[2..-1].join(" ") })
      if result.success?
        puts "Project with name '#{result.project.name}' and PID #{result.project.project_id} created!"
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def history
      result = TM::CompleteTaskList.run({ :project_id => @control[2].to_i })
      if result.success?
        puts "Complete Tasks:"
        puts ""
        puts "Priority   ID  Description"
        result.tasks.each do |task|
          puts "       #{task.priority}    #{task.task_id}  #{task.description}"
        end
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def show
      result = TM::GetProjectTasks.run({ :project_id => @control[2].to_i })

      if result.success?
        puts "Incomplete Tasks:"
        puts ""
        puts "Priority   ID  Description"
        result.tasks.each do |task|
          puts "       #{task.priority}    #{task.task_id}  #{task.description}" if !task.complete
        end
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def list_employees_on_project
      result = TM::GetEmployeesOnProject.run({ :project_id => @control[2].to_i })
      if result.success?
        puts "Employee\tID:"
        result.employees.each do |employee|
          puts "#{employee.name}\t\t#{employee.employee_id}"
        end
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def add_employee_to_project
      result = TM::AddEmployeeToProject.run({ :project_id => @control[2].to_i, :employee_id => @control[3].to_i })
      if result.success?
        puts "Added #{result.employee.name} to Project #{result.project.name}"
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def create_task
      result = TM::CreateTask.run({ :description => @control[4..-1].join(" "), :priority => @control[3].to_i, :project_id => @control[2].to_i })
      if result.success?
        puts "Added new task to project PID: #{result.task.project_id}"
        puts "Task ID: #{result.task.task_id}"
        puts "Priority: #{result.task.priority}"
        puts "Description: #{result.task.description}"
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def mark
      result = TM::MarkTaskComplete.run({ :task_id => @control[2].to_i })
      if result.success?
        puts "Task with TID #{result.task.task_id} marked complete."
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def list_all_employees
      result = TM::GetAllEmployees.run({})
      if result.success?
        puts "EID:\tName:"
        result.employees.each { |employee| puts "#{employee.employee_id}\t#{employee.name}" }
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def assign
      result = TM::AssignTaskToEmployee.run({ :employee_id => @control[3].to_i, :task_id => @control[2].to_i })
      if result.success?
        puts "Assigned task #{result.task.task_id} to employee #{result.employee.employee_id}"
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def create_employee
      result = TM::CreateEmployee.run({ :name => @control[2..-1].join(" ") })
      if result.success?
        puts "Created employee #{result.employee.name} with EID #{result.employee.employee_id}"
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def show_employee
      result = TM::GetProjectsForEmployee.run({ :employee_id => @control[2].to_i })
      if result.success?
        puts "Projects for Employee #{result.employee.employee_id}: #{result.employee.name}"
        result.projects.each do |project|
          puts "#{project.project_id}: #{project.name}"
        end
      else
        puts "Error: #{result.error}"
      end
      input
    end

    def employee_remaining_tasks
      # if @projectlist.employees[@control[2].to_i].nil?
      #   puts "Employee with that EID does not exist."
      # else
      #   puts "Employee still needs to complete the following tasks"
      #   @projectlist.employees[@control[2].to_i].tasks.each do |task|
      #     if !task.complete
      #       project_for_task = 0
      #       @projectlist.projects.each do |project_id, project|
      #         if project.tasks.values.include?(task)
      #           project_for_task = project
      #         end
      #       end
      #       puts "#{task.description} for Project #{project_for_task.name}"
      #     end
      #   end
      # end
      input
    end

    def employee_history
      # if @projectlist.employees[@control[2].to_i].nil?
      #   puts "Employee with that EID does not exist."
      # else
      #   puts "Employee has completed the following tasks"
      #   @projectlist.employees[@control[2].to_i].tasks.each do |task|
      #     puts "TID: #{task.task_id} Description: #{task.description}" if task.complete
      #   end
      # end
      input
    end
  end
end
