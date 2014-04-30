
class TM::Project
  attr_reader :name, :id
  @@id_count = 0

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
    @tasks = []
  end

  def add_task(task)
    task.project_id = self.id
    @tasks << task
  end

  def self.reset_class_variables
    @@id_count = 0
  end

end
