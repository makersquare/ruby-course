
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

  #helper method for tests
  def self.reset_class_variables
    @@counter = 1
    @@projects = []
  end

  def self.projects
    @@projects
  end

  def self.list_all
    @@projects.each do |project|
      puts "Name: #{project.name} - ID: #{project.id}"
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
