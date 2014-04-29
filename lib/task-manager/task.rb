
class TM::Task

  attr_reader :project_id, :priority, :description, :task_id, :date_created
  attr_accessor :completed

  @@task_id = 0

  def initialize(project_id, priority, description)
    @project_id = project_id
    @priority = priority
    @description = description
    @completed = false
    @@task_id += 1
    @date_created = Time.now
  end

  def complete
    @completed = true
    self
  end

end
