
class TM::Task
  attr_reader :description, :priority, :project_id

  def initialize description, priority, project_id
    @description = description
    @priority    = priority
    @project_id  = project_id
    @complete   = false
  end

  def complete?
    @complete
  end

  def complete
    @complete = true
  end
end
