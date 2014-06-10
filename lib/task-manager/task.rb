class TM::Task
  attr_accessor :id, :description, :priority, :status, :creation_date

  def initialize(description, priority)
    @description = description
    @priority = priority
    @id = 0
    @status = "incomplete"
    @creation_date = Time.now
  end

  def generate_id
    @id += 1
  end

  def mark_complete
    @status = "complete"
  end
end
