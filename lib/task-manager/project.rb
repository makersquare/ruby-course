
class TM::Project
  attr_reader :name, :project_id
  @@counter = 0

  def initialize name
    @name = name
    @project_id = @@counter
    @@counter += 1
  end

  def retrieve_completed_tasks
  end

  def retrieve_incomplete_tasks
  end
end
