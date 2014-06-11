
class TM::Task
  attr_reader :description, :priority, :project_id
  attr_accessor :complete, :creation_time

  def initialize(description, priority, project_id)
    @description = description
    @priority = priority
    @project_id = project_id
    @complete = false
    @creation_time = Time.now
  end

  def complete_task
    @complete = true
  end

end
