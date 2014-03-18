
class TM::Task
attr_reader :project_id, :description, :priority
attr_accessor :complete

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @complete = false
  end
end
