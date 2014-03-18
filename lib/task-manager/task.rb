
class TM::Task
  attr_reader :project_id
  def initialize(description, priority_number = 0, project_id)
    @description = description
    @priority_number = priority_number
    @project_id = project_id
  end
end
