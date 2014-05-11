class TM::ProjectManager

  attr_accessor :projects_list

  def initialize
    @projects_list = []
    @tasks_list = []
  end

  def help
    "Follow the instruction and have fun!"
  end

  def listed_projects
   @projects_list
  end

  def listed_tasks
    @tasks_list
  end

  def get_projects
    if @projects_list == []
      "You need to create your project first"
    else
    puts "List of Projects"
    puts "ID: NAME"
      @projects_list.each do |project|
      puts "#{project.id}: #{project.name}"
    end
    end
  end

  def create_new_project(name)
    project = TM::Project.new(name)
    @projects_list << project
    puts "#{project.name} project created"
  end

  def show_tasks(project_id)
    if @tasks_list == [] || @projects_list == []
      puts "You have to create your first projects and tasks"
    else
    task = @projects_list.each{|task| task.id == project_id.to_i}
    puts "#{task.first.name}"
    puts "Task ID: Priority, Description"
      task.first.incomplete_tasks.each do |task|
      puts "#{task.id}: #{task.priority_number}, #{task.description}"
      end
    end
  end

  def add_task(project_id, description, priority_no)
     if @projects_list == []
      "You need to create your project first"
    else
     project = @projects_list.each{|project| project.id == project_id.to_i}
     task = project.first.create_new_task(description, priority_no.to_i)
     puts "Created #{task.description} task"
     @tasks_list << task
     task
  end
end

  def search_project_by_id(project_id)
    @projects_list.select { |project| project.id == project_id }.first
  end

  def search_task_by_id(id)
    task = []
    @projects_list.each { |project| task.push(project.task)}
    task.flatten.select { |task| task.task_id == id }.first
  end

  def complete_task(task_id)
    if @tasks_list == [] || @projects_list == []
      puts "You have to create your first projects and tasks"
    else
      task2 = @tasks_list.select{|task| task.id == task_id.to_i}
      task2.first.status = true
   end
  end

  def tasks_record(project_id)
    if @tasks_list == [] || @projects_list== []
      puts "You have to create your first projects and tasks"
    else
      task = @projects_list.select{|task| task.id == project_id.to_i}
      puts "#{task.first.name}"
      puts "Task ID: Priority, Description"
      task.first.completed_tasks.select do |task|
      puts "#{task.id}: #{task.priority_no}, #{task.description}"
    end
  end
  end


end

