class TM::ProjectManager

  def initialize(projectlist)
    @input = ""
    @projectlist = projectlist
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
    puts "task create PID TID PRIORITY DESC - Add a new task TID to project PID"
    puts "task assign PID TID EID - Assign task TID from project PID to employee EID"
    puts "task mark PID TID - Mark task PID[TID] as complete"
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
    templist = @projectlist.projects.compact
    puts "PID: Name:"
    templist.each do |project|
      puts "#{project.id}:   #{project.name}"
    end
    input
  end

  def create_project
    @projectlist.addproject(@control[1..-1])
    puts "Project with name '#{@control[1..-1]}' created!"
    input
  end

  def history
    if @projectlist.projects[@control.last.to_i].completedlist.count == 0
      puts "There are no completed tasks for this project."
    else
      puts "Complete Tasks:"
      puts ""
      puts "Priority   ID  Description"
      @projectlist.projects[@control.last.to_i].completedlist.each do |task|
        puts "       #{task.priority}    #{task.project_id}  #{task.description}"
      end
    end
    input
  end

  def show
    if @projectlist.projects[@control.last.to_i].incompletelist.count == 0
      puts "There are no incomplete tasks for this project."
    else
      puts "Incomplete Tasks:"
      puts ""
      puts "Priority   ID  Description"
      @projectlist.projects[@control.last.to_i].incompletelist.each do |task|
        puts "       #{task.priority}    #{task.project_id}  #{task.description}"
      end
    end
    input
  end

  def list_employees_on_project
    puts "Employee:\tID:"
    @projectlist.projects[@control[2].to_i].employees_on_project.each do |employee|
      puts "#{employee.name}\t\t#{employee.id}"
    end
    input
  end

  def add_employee_to_project
    @projectlist.projects[@control[2].to_i].addemployee(@projectlist.employees[@control[3].to_i])
    puts "Added #{@projectlist.employees[@control[3].to_i].name} to Project #{@control[2]}"
    input
  end

  def create_task
    description = @control[4..-1]
    @projectlist.projects[@control[1].to_i].addtask(@control[2].to_i,@control[3].to_i,description.join(" "))
    puts "Added new task to project #{@control[1]}."
    puts "Task number: #{@control[2]}"
    puts "Priority: #{@control[3]}"
    puts "Description: #{description.join(" ")}"
    input
  end

  def mark
    @projectlist.projects[@control[1].to_i].markcomplete(@control[2].to_i)
    puts "Marked Task #{@control[2]} from Project #{@control[1]} complete."
    input
  end

  def list_all_employees
    puts "Name\t\tEID"
    @projectlist.employees.each do |employee|
      puts "#{employee.name}\t\t#{employee.id}"
    end
    input
  end

  def assign
    @projectlist.employees[@control[4].to_i].taketask(@projectlist.projects[@control[2].to_i].tasks[@control[3].to_i])
    puts "Assigned task #{@projectlist.projects[@control[2].to_i].tasks[@control[3].to_i].description} to #{@projectlist.employees[@control[4].to_i].name}"
    input
  end

  def create_employee
    @projectlist.addemployee(@control[2..-1].join(" "))
    puts "Created new employee #{@control[2..-1].join(" ")}"
    input
  end

  def show_employee
    puts "Employee #{@projectlist.employees[@control[2].to_i].name} is on the following projects:"
    @projectlist.projects.each do |projects|
      if projects.employees_on_project.include?(@projectlist.employees[@control[2].to_i])
        puts "#{projects.id}: #{projects.name}"
      end
    end
    input
  end

  def employee_remaining_tasks
    puts "Employee still needs to complete the following tasks"
    @projectlist.employees[@control[2].to_i].tasks.each do |task|
      if !task.complete
        project_for_task = 0
        @projectlist.projects.each do |project|
          if project.tasks.values.include?(task)
            project_for_task = project
          end
        end
        puts "#{task.description} for Project #{project_for_task.name}"
      end
    end
    input
  end

  def employee_history
    puts "Employee has completed the following tasks"
    @projectlist.employees[@control[2].to_i].tasks.each do |task|
      puts "TID: #{task.project_id} Description: #{task.description}" if task.complete
    end
    input
  end
end
