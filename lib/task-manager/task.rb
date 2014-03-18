
class TM::Task
    attr_reader :task_id, :description, :project_id, :priority
    attr_accessor :status
    @@task_counter = 0
  def initialize(project_id, description, priority, status="incomplete")
    @@task_counter += 1
    @task_id = @@task_counter
    @description = description
    @project_id = project_id
    @priority = priority
    @status = status
  end


end
