
class TM::Task
  attr_reader :id, :description, :priority, :project_id, :created_at

  @@counter = 0

  def initialize description, priority, project_id
    @id          = @@counter += 1
    @description = description
    @priority    = priority
    @project_id  = project_id
    @complete    = false
    @created_at  = Time.now
  end

  def complete?
    @complete
  end

  def complete
    @complete = true
  end
end
