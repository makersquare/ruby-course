require "pry-debugger"
class TM::Task
  attr_reader :project_id, :id, :priority, :description, :completed, :date
  def initialize(project_id, task_description, priority, id)
    @project_id = project_id
    @description = task_description
    @priority = priority
    @id = id
    @date = Time.now
    @completed = false
  end
  def change_status
    @completed = true #true means completed
  end
end
