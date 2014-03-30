
class TM::Task
  attr_reader :project_id, :task_completion
  def initialize(description, priority_number = 0, project_id)
    @description = description
    @priority_number = priority_number
    @project_id = project_id
    @task_completion = [@project_id, "no", Time.now]
  end

  def complete
    @task_completion[1] = "yes"
    @task_completion
  end


end
