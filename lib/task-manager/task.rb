
class TM::Task

  attr_reader :project_id, :description, :priority
  attr_reader :id, :timestamp

  @@id_counter = 0

  def initialize(project_id, description, priority)
    @project_id = project_id
    @description = description
    @priority = priority
    @@id_counter += 1
    @id = @@id_counter
    @timestamp = Time.now
  end

  def mark_complete

  end

end
