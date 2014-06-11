require "pry-debugger"
class TM::Task
  attr_reader :project_id, :id, :priority,
  :description, :task_is_completed, :creation_date

  def initialize(project_id, description, priority, id)
    @project_id = project_id
    @description = description
    @priority = priority
    @id = id
    @creation_date = Time.now
    @task_is_completed = false
  end

  def change_status
    @task_is_completed = true #true means completed
  end
end
