
class TM::Task

  attr_reader :project_id, :description, :priority, :task_id

  def initialize(project_id,description,priority,task_id)
    @project_id = project_id
    @description = description
    @priority = priority
    @task_id = task_id
  end

end



