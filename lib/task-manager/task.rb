
class TM::Task
  attr_reader :id, :description, :priority, :project_id
  def initialize(project_id, description, priority=3)
    @id = self.object_id
    @description = description
    @priority = priority
    @project_id = project_id
  end

end
