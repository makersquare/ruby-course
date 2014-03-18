
class TM::Task
attr_reader :project_id, :description, :priority

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
  end
end
