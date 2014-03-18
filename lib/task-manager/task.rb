
class TM::Task
  attr_reader :id, :description, :priority
  def initialize(description, priority=3)
    @id = self.object_id
    @description = description
    @priority = priority
  end

end
