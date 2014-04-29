
class TM::Task

  attr_reader :project_id
  attr_accessor :description, :priority_number, :status

  def initialize(project_id, description, priority_number, status="incomplete")
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @status = "incomplete"
  end


end
