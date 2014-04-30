
class TM::Project
  attr_reader :name, :id
  @@id_count = 0

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
    @tasks = []
  end

  def add_tasks(project_id, description, priority)
    addTo = TM::Task.new(task_id, description, priority)
    @tasks << addTo
  end

  def self.reset_class_variables
    @@id_count = 0
  end

end
