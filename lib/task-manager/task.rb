
class TM::Task

  attr_reader :project_id, :description, :priority, :id

  @@id_counter = 0

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @id = @@task_id_counter
    @@id_counter += 1
  end

end
