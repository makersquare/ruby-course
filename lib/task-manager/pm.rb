class TM::ProjectManager

  def initialize(projectlist)
    @input = ""
    @projectlist = projectlist
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
    puts "  add PID TID PRIORITY DESC - Add a new task to project with id=PID"
    puts "  mark PID TID - Mark task with PID[TID] as complete"
    puts "  quit - Exit program"
    @input = gets.chomp

    while @input != "quit" do
      case @input.split.first
        when "help" then menu
        when "list" then list
        when "create" then create
        when "show" then show
        when "history" then history
        when "add" then add
        when "mark" then mark
      end
    end
  end

  def list
    templist = @projectlist.projects.compact
    templist.each do |project|
      puts project.name
    end
    puts "What now?"
    @input = gets.chomp
  end

  def create
    @projectlist.addproject(@input.split.last)
    puts "Project with name '#{@input.split.last}' created!"
    puts "What now?"
    @input = gets.chomp
  end

  def history
    if @projectlist.projects[@input.split.last.to_i].completedlist.count == 0
      puts "There are no completed tasks for this project."
    else
      @projectlist.projects[@input.split.last.to_i].completedlist.each do |task|
        puts task.description
      end
    end
    puts "What now?"
    @input = gets.chomp
  end

  def show
    if @projectlist.projects[@input.split.last.to_i].incompletelist.count == 0
      puts "There are no incomplete tasks for this project."
    else
      @projectlist.projects[@input.split.last.to_i].incompletelist.each do |task|
        puts task.description
      end
    end
    puts "What now?"
    @input = gets.chomp
  end

  def add
    control = @input.split
    description = control[4..-1]
    @projectlist.projects[control[1].to_i].addtask(control[2].to_i,control[3].to_i,description.join(" "))
    puts "Added new task to project #{control[1]}."
    puts "Task number: #{control[2]}"
    puts "Priority: #{control[3]}"
    puts "Description: #{description.join(" ")}"
    puts "What now?"
    @input = gets.chomp
  end

  def mark
    puts "What now?"
    @input = gets.chomp
  end

end
