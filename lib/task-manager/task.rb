
class TM::Task
  attr_reader :description, :priority, :task_id
  attr_accessor :complete, :creation_time

  def initialize(description, priority, task_id)
    @description = description
    @priority = priority
    @task_id = task_id
    @complete = false
    @creation_time = Time.now
  end

end
