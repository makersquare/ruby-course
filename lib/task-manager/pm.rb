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
    # puts "  help - Show these commands again"
    # puts "  list - List all projects"
    # puts "  create NAME - Create a new project with name=NAME"
    # puts "  show PID - Show remaining tasks for project with id=PID"
    # puts "  history PID - Show completed tasks for project with id=PID"
    # puts "  add PID TID PRIORITY DESC - Add a new task with id=TID to project with id=PID"
    # puts "  mark PID TID - Mark task with PID[TID] as complete"
    # puts "  quit - Exit program"
    puts "help - Show these commands again"
    puts "project list - List all projects"
    puts "project create NAME - Create a new project"
    puts "project show PID - Show remaining tasks for project PID"
    puts "project history PID - Show completed tasks for project PID"
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
            when "employees" then list_employees
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
            when "create" then create_employee
            when "show" then show_employee
            when "details" then employee_remaining_tasks
            when "history" then employee_history
            else input
          end
        # when "list" then list
        # when "create" then create
        # when "show" then show
        # when "history" then history
        # when "add" then add
        # when "mark" then mark
        else input
      end
    end
  end

  def input
    puts "Input your choice:"
    @input = gets.chomp
    @control = @input.split
  end

  def list
    templist = @projectlist.projects.compact
    templist.each do |project|
      puts project.name
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

  def list_employees
    input
  end

  def assign
    input
  end

  def create_employee
    input
  end

  def show_employee
    input
  end

  def employee_remaining_tasks
    input
  end

  def employee_history
    input
  end
end
