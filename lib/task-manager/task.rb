
class TM::Task
  @@task_id = 0
  attr_reader :project_id, :description
  attr_accessor :priority

  def initialize(project_id, description, priority = nil)
    @project_id = project_id
    @description = description
    @priority = priority
    @@task_id +=1
  end

  def task_id
    @@task_id
  end

end
