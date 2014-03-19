
class TM::Task
  attr_reader :task_id, :description, :priority, :project_id
  attr_accessor :status
  def initialize(project_id, description, priority=3)
    @task_id = self.object_id
    @description = description
    @priority = priority
    @project_id = project_id
    @status = "incomplete"
  end

end
