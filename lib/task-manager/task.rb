
class TM::Task
  attr_reader :id, :description
  def initialize(description)
    @id = self.object_id
    @description = description

  end

end
