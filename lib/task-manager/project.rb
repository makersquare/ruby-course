
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

  def self.find_project(project_id)
    @@projects.each do |project|
      if project.id == project_id
        return project
      end
    end
    return nil
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
      if tasks.length != 0
        tasks.each do |task|
          puts "#{task.priority} #{task.task_id} #{task.description}"
        end
      else
        puts "This project has no tasks."
      end
    else
      puts "There is not a project with that ID."
    end
  end

  def self.show_completed_tasks(project_id)
    temp_project = nil
    @@projects.each do |project|
      if project.id == project_id
        temp_project = project
      end
    end

    if temp_project != nil
      tasks = temp_project.completed_tasks
      if tasks.length != 0
        tasks.each do |task|
          puts "#{task.description} #{task.task_id}"
        end
      else
        puts "This project has no tasks"
      end
    else
      puts "There is not a project with that ID."
    end
  end

  def self.new_task(project_id, priority, description)
    temp_project = nil
    @@projects.each do |project|
      if project.id == project_id
        temp_project = true
        project.add_task(TM::Task.new(description, project_id, priority))
      end
    end

    if temp_project != true
      puts "There is not a project with that ID."
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


  def completed_tasks
    new_array = @tasks.select { |task| task.status == "Completed" }

    new_array.sort! {|a, b| a.creation_date <=> b.creation_date}
  end

  def incomplete_tasks
    new_array = @tasks.select{ |task| task.status == "Not completed"}
    new_array.sort_by! {|a| [a.priority, a.creation_date]}
  end

end
