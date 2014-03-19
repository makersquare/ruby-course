class TM::ProjectTracker
  attr_accessor :list_of_projects

  def initialize
    @list_of_projects = []
    @list_of_tasks = []
  end

  def help
    puts "The system is pretty straightforward. Figure it out!"
  end
  def list_of_projects
    puts "List of Projects"
    puts "ID: NAME"
      @list_of_projects.each do |x|
      puts "#{x.id}: #{x.name}"
      end
  end

  def create_new_project(name)
    project = TM::Project.new(name)
    @list_of_projects.push(project)
    puts "#{project.name} project created"
  end

  def show_tasks(project_id)
    blue = @list_of_projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.incomplete_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
  end
  def add_task(project_id, description, priority_number)
   project = @list_of_projects.select{|x| x.id == project_id.to_i}
   task = project.first.create_new_task(description, priority_number.to_i)
   puts "#{task.description} task created"
   @list_of_tasks.push(task)
  end

  def history_tasks(project_id)
    blue = @list_of_projects.select{|x| x.id == project_id.to_i}
    puts "#{blue.first.name}"
    puts "Task ID: Priority, Description"
      blue.first.completed_tasks.each do |x|
      puts "#{x.id}: #{x.priority_number}, #{x.description}"
      end
  end
   def complete_task(task_id)
      red = @list_of_tasks.select{|x| x.id == task_id.to_i}
      red.first.status = "complete"
   end
end



