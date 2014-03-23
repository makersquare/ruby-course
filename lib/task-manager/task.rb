
class TM::Task
attr_reader :task_id, :description, :priority, :timecreated
attr_accessor :complete

  def initialize(task_id, description, priority)
    @task_id = task_id
    @description = description
    @priority = priority
    @complete = false
    @timecreated = Time.now
  end
end
