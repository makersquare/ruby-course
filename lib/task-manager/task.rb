class TM::Task
  attr_reader :task_id, :description, :priority, :time_created
  attr_accessor :status

  def initialize(description, priority, task_id)
    @description = description
    @priority = priority
    @task_id = task_id
    @time_created = Time.now
    @status = 'not complete'
  end

  def complete
    @status = 'complete'
  end
end
