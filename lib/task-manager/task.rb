
class TM::Task

  attr_reader :project_id, :priority, :description

  def initialize(project_id, priority, description)
    @project_id = project_id
    @priority = priority
    @description = description
  end

end
