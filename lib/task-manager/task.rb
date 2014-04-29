
class TM::Task
  @@counter = 1
  attr_reader :description, :project_id, :priority, :task_id
  attr_accessor :status

  def initialize(description, project_id, priority)
    @description = description
    @project_id = project_id
    @priority = priority
    @task_id = @@counter
    @@counter += 1
    @status = "Not completed"
  end
end
