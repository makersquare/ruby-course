
class TM::Task

  attr_reader :project_id, :description, :priority
  attr_reader :id, :timestamp, :status

  @@id_counter = 0

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @@id_counter += 1
    @id = @@id_counter
    @timestamp = Time.now
    @status = 'incomplete'
  end

  def mark_complete
    @status = 'complete'
    return true
  end

end
