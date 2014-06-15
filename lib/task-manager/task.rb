
class TM::Task
  attr_reader :description, :priority_number, :project_id, :task_id, :status, :creation_date

  def initialize(description, priority_number, project_id, task_id)
    @description = description
    @priority_number = priority_number
    @project_id = project_id
    @task_id = task_id
    @status = false
    @creation_date = Time.now
  end

  def change_status
    @status = !@status
  end
end
