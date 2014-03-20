class TM::ProjectTracker
  attr_accessor :projects, :tasks, :employees

  def initialize
    @projects = []
    @tasks = []
    @employees = []
  end


  def help
    puts "The system is pretty straightforward. Figure it out!"
    return "The system is pretty straightforward. Figure it out!"
  end

  def get_projects
    if @projects == []
      puts "Dude, create a project first!"
      return "Dude, create a project first!"
    else
    puts "List of Projects"
    puts "ID: NAME"
      @projects.each do |x|
      puts "#{x.id}: #{x.name}"
      end
    end
  end

  def create_new_project(name)
    project = TM::Project.new(name)
    @projects.push(project)
    puts "#{project.name} project created"
  end

  def show_tasks(project_id)
    if @tasks == [] || @projects == []
      puts "Dude, create projects and tasks first!"
    else
    blue = @projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.incomplete_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
    end
  end
  def add_task(project_id, description, priority_number)
     if @projects == []
      puts "Dude, create a project to house your tasks first!"
      return "Dude, create a project to house your tasks first!"
    else
   project = @projects.select{|x| x.id == project_id.to_i}
   task = project.first.create_new_task(description, priority_number.to_i)
   puts "#{task.description} task created"
   @tasks.push(task)
    task
  end
end

  def history_tasks(project_id)
    if @tasks == [] || @projects == []
      puts "Dude, create projects and tasks first!"
    else
    blue = @projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.completed_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
    end
  end
   def complete_task(task_id)
    if @tasks == [] || @projects == []
      puts "Dude, create projects and tasks first!"
    else
      red = @tasks.select{|x| x.id == task_id.to_i}
      red.first.status = "complete"
   end
  end
  def add_new_employee(name)
    employee = TM::Employee.new(name)
    @employees.push(employee)
    employee
  end
end


