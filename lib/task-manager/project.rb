
class TM::Project
  @@projects = []
  @@counter = 1
  attr_accessor :name
  attr_reader :id, :tasks
  def initialize(name)
    @name = name
    @id = @@counter
    @@counter += 1
    @tasks = []
    @@projects << self
  end

  def self.projects
    @@projects
  end

  def self.list_all
    @@projects.each do |project|
      puts "#{project.name} - #{project.id}"
    end
  end

  def self.show_incomplete_tasks(project_id)
    temp_project = nil
    @@projects.each do |project|
      if project.id == project_id
        temp_project = project
      end
    end

    if temp_project != nil
      tasks = temp_project.incomplete_tasks
      tasks.each do |task|
        puts "#{task.priority} #{task.task_id} #{task.description}"
      end
    else
      puts "There is not project with that ID."
    end
  end

  #helper method for tests
  def self.reset_class_variables
    @@counter = 1
    @@projects = []
  end

  def add_task(task)
    @tasks << task
  end

  def mark_complete(task_id)
    @tasks.each do |task|
      if task.task_id == task_id
        task.status = "Completed"
      end
    end
  end

  def completed_tasks
    new_array = @tasks.select { |task| task.status == "Completed" }

    new_array.sort! {|a, b| a.creation_date <=> b.creation_date}
  end

  def incomplete_tasks
    new_array = @tasks.select{ |task| task.status == "Not completed"}
    new_array.sort! {|a,b| a.priority <=> b.priority}
  end

end
