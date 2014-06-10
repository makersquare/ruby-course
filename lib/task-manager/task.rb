require "pry-debugger"
class TM::Task
  attr_reader :project_id, :id, :priority, :description, :status, :date
  def initialize(project_id, task_description, priority, id)
    @project_id = project_id
    @description = task_description
    @priority = priority
    @id=id
    @date = Time.now

    @status = "uncompleted"
  end
  def change_status
    @status = "completed"
  end
end
