class TM::ProjectTracker
  attr_accessor :list_of_projects

  def initialize
    @list_of_projects = []
    @list_of_tasks = []
  end

def list_of_projects
@list_of_projects
end

def list_of_tasks
@list_of_tasks
end

  def help
    puts "The system is pretty straightforward. Figure it out!"
    return "The system is pretty straightforward. Figure it out!"
  end

  def get_projects
    if @list_of_projects == []
      puts "Dude, create a project first!"
      return "Dude, create a project first!"
    else
    puts "List of Projects"
    puts "ID: NAME"
      @list_of_projects.each do |x|
      puts "#{x.id}: #{x.name}"
      end
    end
  end

  def create_new_project(name)
    project = TM::Project.new(name)
    @list_of_projects.push(project)
    puts "#{project.name} project created"
  end

  def show_tasks(project_id)
    if @list_of_tasks == [] || @list_of_projects == []
      puts "Dude, create projects and tasks first!"
    else
    blue = @list_of_projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.incomplete_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
    end
  end
  def add_task(project_id, description, priority_number)
     if @list_of_projects == []
      puts "Dude, create a project to house your tasks first!"
      return "Dude, create a project to house your tasks first!"
    else
   project = @list_of_projects.select{|x| x.id == project_id.to_i}
   task = project.first.create_new_task(description, priority_number.to_i)
   puts "#{task.description} task created"
   @list_of_tasks.push(task)
    task
  end
end

  def history_tasks(project_id)
    if @list_of_tasks == [] || @list_of_projects == []
      puts "Dude, create projects and tasks first!"
    else
    blue = @list_of_projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.completed_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
    end
  end
   def complete_task(task_id)
    if @list_of_tasks == [] || @list_of_projects == []
      puts "Dude, create projects and tasks first!"
    else
      red = @list_of_tasks.select{|x| x.id == task_id.to_i}
      red.first.status = "complete"
   end
  end
end



