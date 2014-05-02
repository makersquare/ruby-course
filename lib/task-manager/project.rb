
class TM::Project #this means project class belongs to TM module...doing this sill help with class conflict names ex MKS::Project...creating a new onject would be p = TM::Project.new
  attr_reader :name, :id
  attr_accessor :description, :projects

  @@id_count = 0
  @@projects = {}

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
    @created_at = Time.now
  end

  def self.add_project_to_hash(new_project)
    @@projects = {}
    @@projects[new_project.id] = new_project
  end

  def complete_tasks
    complete = TM::Task.task_list do |task|
      (task.project_id == self.id) && task.complete_status == true
    end

    complete.sort_by { |task| task.created_at }
  end

  def incomplete_tasks
    incomplete = TM::Task.task_list do |task|
      (task.project_id == self.id) && task.complete_status == false
    end

    incomplete.sort_by { |task| task.created_at }
  end

  # def get_tasks
  #   tasks_array = TM::Task.get_tasks
  #   tasks_array.select { |task| task.project_id == self.id }
  # end

  def self.reset_class_variables
    @@id_count = 0
    @@projects = {}
  end

end
