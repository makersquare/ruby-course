
class TM::Task
  attr_reader :project_id
  attr_accessor :description, :priority_number
  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
  end
end
