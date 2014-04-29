
class TM::Project

  attr_reader :name, :id, :projects

  @@unique_id = 0

  def initialize(name)
    @name = name
    @id = @@unique_id += 1
    @uncompleted_task = []
    @completed_task = []
  end

end
