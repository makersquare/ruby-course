
class TM::Task
  attr_reader :description, :priority_number, :project_id, :task_id, :status

  def initialize(description, priority_number, project_id, task_id)
    @description = description
    @priority_number = priority_number
    @project_id = project_id
    @task_id = task_id
    @status = false
  end

  def change_status
    if @status == false
      @status = true
    else
      @status = false
    end
  end
end
