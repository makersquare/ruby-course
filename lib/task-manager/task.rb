class TM::Task
  attr_reader :project_id, :description, :priority, :id, :timestamp
  attr_reader :complete

  def initialize(p_id, desc, priority, id, complete, timestamp)
    @project_id = p_id
    @description = desc
    @priority = priority
    @id = id
    @complete = complete
    @timestamp = timestamp
  end
end
