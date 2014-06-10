
class TM::Project
  attr_reader :name
  attr_accessor :project_id, :tasks

  def initialize(name)
    @name = name
    @project_id = self.object_id * -1
    @tasks = []
  end
end
