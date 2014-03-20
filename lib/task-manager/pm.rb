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
    puts "  help - Show these commands again"
    puts "  list - List all projects"
    puts "  create NAME - Create a new project with name=NAME"
    puts "  show PID - Show remaining tasks for project with id=PID"
    puts "  history PID - Show completed tasks for project with id=PID"
    puts "  add PID TID PRIORITY DESC - Add a new task with id=TID to project with id=PID"
    puts "  mark PID TID - Mark task with PID[TID] as complete"
    puts "  quit - Exit program"

    input

    while @control[0] != "quit" do
      case @control[0]
        when "help" then menu
        when "list" then list
        when "create" then create
        when "show" then show
        when "history" then history
        when "add" then add
        when "mark" then mark
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

  def create
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

  def add
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

end
